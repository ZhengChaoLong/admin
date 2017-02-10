<?php
/**
 * @desc 模型字段类控制器
 * @author oyj <ouyangjun@zhangyue.com>
 * @version 2017/02/06 00:02
 */
namespace app\admin\controller;

use think\Db;
use think\Loader;
use app\admin\Controller;

class AdminModelField extends Controller
{
    // 方法黑名单
    protected static $blacklist = [];

    /**
     * 首页
     * @return mixed
     */
    public function index(){
        $model = $this->getModel();
        // 列表过滤器，生成查询Map对象
        $map = $this->search($model);
        $map['isdelete'] = $this::$isdelete; //显示未删除的字段
        $this->datalist($model, $map, '', '' ,true);
        $this->view->assign('modelid', $this->request->param('modelid/d',0));
        return $this->view->fetch();
    }

    /**
     * 回收站
     * @return mixed
     */
    public function recycleBin(){
        $this::$isdelete = 1;
        return $this->index();
    }

    /**
     * 添加
     * @return mixed
     */
    public function add(){
        $controller = $this->request->controller();
        $module = $this->request->module();
        if ($this->request->isAjax()) {
            // 插入
            $data = $this->request->post();
            unset($data['id']);
            // 验证
            if (class_exists(Loader::parseClass($module, 'validate', $controller))) {
                $validate = Loader::validate($controller);
                if (!$validate->check($data)) {
                    return ajax_return_adv_error($validate->getError());
                }
            }

            // 写入数据
            Db::startTrans();
            try {
                //使用模型写入，可以在模型中定义更高级的操作
                $model = Loader::model($controller);
                $data['setting'] = json_encode($data['setting']);
                $model->allowField(true)->save($data);
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
            include APP_PATH.'common/fields/fields.php';
            $this->view->assign('fileType', $fileType);
            $this->view->assign('dataType', $dataType);
            return $this->view->fetch(isset($this->template) ? $this->template : 'edit');
        }
    }

    /**
     *@desc 编辑
     * @return \think\Response|\think\response\Json|\think\response\Jsonp|\think\response\Redirect|\think\response\View|\think\response\Xml
     * @throws Exception
     * @throws HttpException
     */
    public function edit()
    {
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

            // 更新数据
            Db::startTrans();
            try {
                $model = Loader::model($controller);
                $data['setting'] = json_encode($data['setting']);
                $model->isUpdate(true)->allowField(true)->save($data, ['id' => $data['id']]);
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
            $id = $this->request->param('id');
            if (!$id) {
                throw new Exception("缺少参数ID");
            }
            $vo = $this->getModel($controller)->find($id);
            if (!$vo) {
                throw new HttpException(404, '该记录不存在');
            }
            $setting = json_decode($vo['setting'],true);
            $this->view->assign("setting", $setting);
            $this->view->assign("vo", $vo);
            //字段类型
            include APP_PATH.'common/fields/fields.php';
            $this->view->assign('fileType', $fileType);
            $this->view->assign('dataType', $dataType);
            return $this->view->fetch();
        }
    }

    /**
     * 默认删除操作
     */
    public function delete(){
        return $this->updateField("isdelete", 1, "移动到回收站成功");
    }

    /**
     * 从回收站恢复
     */
    public function recycle(){
        return $this->updateField("isdelete", 0, "恢复成功");
    }

    /**
     * 默认禁用操作
     */
    public function forbid(){
        return $this->updateField("status", 0, "禁用成功");
    }


    /**
     * 默认恢复操作
     */
    public function resume(){
        return $this->updateField("status", 1, "恢复成功");
    }


    /**
     * 永久删除
     */
    public function deleteForever()
    {
        $model = $this->getModel();
        $pk = $model->getPk();
        $ids = $this->request->param($pk);
        $where[$pk] = ["in", $ids];
        if (false === $model->where($where)->delete()) {
            return ajax_return_adv_error($model->getError());
        }

        return ajax_return_adv("删除成功");
    }

    /**
     * 清空回收站
     */
    public function clear()
    {
        $model = $this->getModel();
        $where["isdelete"] = 1;
        if (false === $model->where($where)->delete()) {
            return ajax_return_adv_error($model->getError());
        }
        return ajax_return_adv("清空回收站成功");
    }

    /**
     * @desc 预览
     */
    public function preview() {
        $modelId = $this->request->param('modelid/d',0);
        $model = new \Model();
        $formInfo = $model->get($modelId);
        $this->view->assign('formInfo', $formInfo);
        return $this->view->fetch();
    }
}