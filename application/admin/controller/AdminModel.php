<?php
/**
 * @desc 模型类控制器
 * @author oyj <ouyangjun@zhangyue.com>
 * @version 2017/01/21 20:31
 */
namespace app\admin\controller;

use think\Db;
use think\Exception;
use think\Loader;
use think\Config;
use app\admin\Controller;

class AdminModel extends Controller{

    // 方法黑名单
    protected static $blacklist = [];

    /**
     * @desc 首页
     * @return mixed
     */
    public function index(){
        $model = $this->getModel();
        // 列表过滤器，生成查询Map对象（过滤条件）
        $map = $this->search($model);
        $map['isdelete'] = $this::$isdelete;

        $this->datalist($model, $map);
        return $this->view->fetch();
    }

    /**
     * @desc 添加
     * @return mixed
     */
    public function add(){
        if ($this->request->isAjax()) {
            $controller = $this->request->controller();
            $module = $this->request->module();
            $data = $this->request->post();
            unset($data['id']);

            // 验证数据是否合法
            if (class_exists(Loader::parseClass($module, 'validate', $controller))) {
                $validate = Loader::validate($controller);
                if (!$validate->check($data)) {
                    return ajax_return_adv_error($validate->getError());
                }
            }
            $data['controller'] = $data['tableName'];//控制器
            $tablePre = Config::get("database.prefix");//表前缀
            $tableName = $tablePre . Loader::parseName($data['tableName']);//数据表
            $data['tableName'] = Loader::parseName($data['tableName']);

            //验证数据表是否已经存在
            $ret = Db::query("SHOW TABLES LIKE '{$tableName}'");
            if ($ret && isset($ret[0])) {
                return ajax_return_adv_error('数据表已经存在');
            }
            // 写入数据 创建事务
            Db::startTrans();
            try {
                //模型写入
                $model = Loader::model($controller);
                $model->allowField(true)->save($data);
                //获取自增主键
                $modelId = $model->getLastInsID();

                //获取model.sql(默认模型sql、模型字段)
                $modelSql = file_get_contents(APP_PATH.'common/fields/model.sql');

                //新的模型
                $modelSql = str_replace('$basic_table', $tableName, $modelSql);//模型表的信息
                //存储模型表字段的数据表
                $modelSql = str_replace('$table_model_field', $tablePre.'admin_model_field', $modelSql);
                $modelSql = str_replace('$model_id', $modelId, $modelSql);
                $arrSql = explode(';', $modelSql);
                //执行创建的sql语句
                foreach ($arrSql as $v){
                    if (!empty(trim($v))){
                        Db::execute($v);
                    }
                }
                //创建模型所需要的控制器、模型、验证等文件
                $model = new \Model();
                $model->run($data);
                // 提交事务
                Db::commit();
                return ajax_return_adv('添加成功');
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                return ajax_return_adv_error($e->getMessage());
            }
        } else {
            // 添加
            return $this->view->fetch(isset($this->template) ? $this->template : 'edit');
        }
    }

    /**
     * @desc 编辑
     * @return \think\Response|\think\response\Json|\think\response\Jsonp|\think\response\Redirect|\think\response\View|\think\response\Xml
     * @throws Exception
     * @throws HttpException
     */
    public function edit(){
        $controller = $this->request->controller();
        $module = $this->request->module();

        if ($this->request->isAjax()) {
            // 更新
            $data = $this->request->post();
            if (!$data['id']) {
                return ajax_return_adv_error("缺少参数ID");
            }

            // 验证
            if (class_exists(Loader::parseClass($module, 'validate', $controller))) {
                $validate = Loader::validate($controller);
                if (!$validate->check($data)) {
                    return ajax_return_adv_error($validate->getError());
                }
            }

            // 更新数据 开启事务
            Db::startTrans();
            try {
                // 使用模型更新，可以在模型中定义更高级的操作
                $model = Loader::model($controller);
                $model->isUpdate(true)->save($data, ['id' => $data['id']]);
                // 提交事务
                Db::commit();
                return ajax_return_adv("编辑成功");
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                return ajax_return_adv_error($e->getMessage());
            }
        } else {
            // 编辑
            $id = $this->request->param('id/d');
            if (!$id) {
                throw new Exception("缺少参数ID");
            }
            $vo = $this->getModel($controller)->find($id);
            if (!$vo) {
                throw new HttpException(404, '该记录不存在');
            }
            $this->view->assign('edit',1);
            $this->view->assign("vo", $vo);
            return $this->view->fetch();
        }
    }

    /**
     * @desc 默认删除操作
     */
    public function delete(){
        $model = $this->getModel();
        $pk = $model->getPk();
        try{
            $ids = $this->request->param($pk);

            $modelInfo = $model->find($ids);
            $tableName = $modelInfo['tableName'];
            $controller = Loader::parseName($tableName, 1);

            //删除控制器、model、view相关文件及相关数据表和字段
            // 文件路径
            $pathView = APP_PATH . 'admin' . DS . "view" . DS . $tableName . DS;//视图
            $fileName = APP_PATH . 'admin' . DS . "%NAME%" . DS . $controller . ".php";//php文件
            //删除文件
            delDirAndFile($pathView, true);
            delDirAndFile(str_replace('%NAME%', 'controller',$fileName));
            delDirAndFile(str_replace('%NAME%', 'model',$fileName));

            $sql = 'DROP TABLE IF EXISTS ' . Config::get("database.prefix") . $tableName;
            Db::execute($sql);
            //删除字段表中的相关字段和数据表
            $modelField = Loader::model('AdminModelField');
            $modelField->where('modelid', $modelInfo['id'])->delete();
            $where[$pk] = ["in", $ids];
            $model->where($where)->delete();
            return ajax_return_adv("删除成功");
        }catch (Exception $e){
            return ajax_return_adv_error($e->getMessage());
        }
    }

    /**
     * @desc 默认禁用操作
     */
    public function forbid(){
        return $this->updateField("status", 0, "禁用成功");
    }

    /**
     * @desc 默认恢复操作
     */
    public function resume(){
        return $this->updateField("status", 1, "恢复成功");
    }
}