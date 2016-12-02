<?php
/**
 * tpAdmin [a web admin based ThinkPHP5]
 *
 * @author    yuan1994 <tianpian0805@gmail.com>
 * @link      http://tpadmin.yuan1994.com/
 * @copyright 2016 yuan1994 all rights reserved.
 * @license   http://www.apache.org/licenses/LICENSE-2.0
 */

namespace app\admin;

use think\Url;
use think\View;
use think\Request;
use think\Session;
use think\Db;
use think\Response;
use think\Config;
use think\Loader;
use think\response\Redirect;
use think\Exception;
use think\exception\HttpException;
use think\exception\HttpResponseException;

class Controller
{
    // 视图类实例
    protected $view;
    // Request实例
    protected $request;
    // 黑名单方法，禁止访问某些方法
    protected static $blacklist = [];
    // 是否删除标志，0-正常|1-删除|false-不包含该字段
    protected static $isdelete = 0;

    public function __construct()
    {
        if (null === $this->view) {
            $this->view = View::instance(Config::get('template'), Config::get('view_replace_str'));
        }
        if (null === $this->request) {
            $this->request = Request::instance();
        }

        // 黑名单方法
        if ($this::$blacklist && in_array($this->request->action(), $this::$blacklist)) {
            throw new HttpException(404, 'method not exists:' . (new \ReflectionClass($this))->getName() . '->' . $this->request->action());
        }

        // 用户ID
        defined('UID') or define('UID', Session::get(Config::get('rbac.user_auth_key')));
        // 是否是管理员
        defined('ADMIN') or define('ADMIN', true === Session::get(Config::get('rbac.admin_auth_key')));

        // 检查认证识别号
        if (null === UID) {
            $this->notLogin();
        } else {
            $this->auth();
        }

        // 前置方法
        $beforeAction = "before" . $this->request->action();
        if (method_exists($this, $beforeAction)) {
            $this->$beforeAction();
        }
    }

    /**
     * 自动搜索查询字段,给模型字段过滤
     */
    protected function search($model)
    {
        $map = [];
        $table_info = $model->getTableInfo();
        foreach ($this->request->param() as $key => $val) {
            if ($val !== "" && in_array($key, $table_info['fields'])) {
                $map[$key] = $val;
            }
        }

        return $map;
    }

    /**
     * 获取模型
     * @param string $controller
     * @return mixed
     */
    protected function getModel($controller = '')
    {
        $module = $this->request->module();
        if (!$controller) {
            $controller = $this->request->controller();
        }
        if (class_exists(Loader::parseClass($module, 'model', $controller))) {
            return Loader::model($controller);
        } else {
            return Db::name($this->parseTable($controller));
        }
    }

    /**
     * 获取实际的控制器名称(应用于多层控制器的场景)
     * @param $controller
     * @return mixed
     */
    protected function getRealController($controller = '')
    {
        if (!$controller) {
            $controller = $this->request->controller();
        }
        $controllers = explode(".", $controller);
        $controller = array_pop($controllers);

        return $controller;
    }

    /**
     * 默认更新字段方法
     * @param string $field     更新的字段
     * @param string|int $value 更新的值
     * @param string $msg       操作成功提示信息
     * @param string $pk        主键，默认为主键
     * @param string $input     接收参数，默认为主键
     */
    protected function updateField($field, $value, $msg = "操作成功", $pk = "", $input = "")
    {
        $model = $this->getModel();
        if (!$pk) {
            $pk = $model->getPk();
        }
        if (!$input) {
            $input = $model->getPk();
        }
        $ids = $this->request->param($input);
        $where[$pk] = ["in", $ids];
        if ($model->where($where)->update([$field => $value]) === false) {
            return ajax_return_adv_error($model->getError());
        }

        return ajax_return_adv($msg, '');
    }

    /**
     * 格式化表名，将 /. 转为 _ ，支持多级控制器
     * @param string $name
     * @return mixed
     */
    protected function parseTable($name = '')
    {
        if (!$name) {
            $name = $this->request->controller();
        }

        return str_replace(['/', '.'], '_', $name);
    }

    /**
     * 格式化类名，将 /. 转为 \\
     * @param string $name
     * @return mixed
     */
    protected function parseClass($name = '')
    {
        if (!$name) {
            $name = $this->request->controller();
        }

        return str_replace(['/', '.'], '\\', $name);
    }

    /**
     * 未登录处理
     */
    protected function notLogin()
    {
        // 跳转到认证网关
        if ($this->request->isAjax()) {
            $response = ajax_return_adv_error("登录超时，请先登陆", 400, "", "", false, "", Url::build("Pub/loginFrame"));
            throw new HttpResponseException($response);
        } else {
            if (strtolower($this->request->controller()) == 'index' && strtolower($this->request->action()) == 'index') {
                throw new HttpResponseException(new Redirect('Pub/login'));
            } else {
                // 判断是弹出登录框还是直接跳转到登录页
                $ret = '<script>' .
                    'if(window.parent.frames.length == 0) ' .
                    'window.location = "' . Url::build('Pub/login') . '?callback=' . urlencode($this->request->url(true)) . '";' .
                    ' else ' .
                    'parent.login("' . Url::build('Pub/loginFrame') . '");' .
                    '</script>';
                throw new HttpResponseException(new Response($ret));
            }
        }
    }

    /**
     * 权限校验
     */
    protected function auth()
    {
        // 用户权限检查
        if (
            Config::get('rbac.user_auth_on') &&
            !in_array($this->request->module(), explode(',', Config::get('rbac.not_auth_module')))
        ) {
            if (!\Rbac::AccessCheck()) {
                throw new Exception("没有权限");
            }
        }
    }

    /**
     * 过滤禁止操作某些主键
     * @param $filterData
     * @param string $error
     * @param string $method
     * @param string $key
     */
    protected function filterId($filterData, $error = '该记录不能执行此操作', $method = 'in_array', $key = 'id')
    {
        $data = $this->request->param();
        if (!isset($data[$key])) {
            throw new Exception('缺少必要参数');
        }
        $ids = is_array($data[$key]) ? $data[$key] : explode(",", $data[$key]);
        foreach ($ids as $id) {
            switch ($method) {
                case '<':
                case 'lt':
                    $ret = $id < $filterData;
                    break;
                case '>':
                case 'gt':
                    $ret = $id < $filterData;
                    break;
                case '=':
                case 'eq':
                    $ret = $id == $filterData;
                    break;
                case '!=':
                case 'neq':
                    $ret = $id != $filterData;
                    break;
                default:
                    $ret = call_user_func_array($method, [$id, $filterData]);
                    break;
            }
            if ($ret) {
                throw new Exception($error);
            }
        }
    }

    /**
     * 根据表单生成查询条件
     * 进行列表过滤
     *
     * 过滤条件
     * $map['_table']       可强制设置表名前缀
     * $map['_relation']    可强制设置关联模型预载入(需在模型里定义)
     * $map['_field']       可强制设置字段
     * $map['_order_by']    可强制设置排序字段(field asc|desc[,filed2 asc|desc...]或者false)
     * $map['_paginate']    是否开启分页，传入false可以关闭分页
     *
     * @param object $model     数据对象
     * @param array $map        过滤条件
     * @param string $field     查询的字段
     * @param string $sortBy    排序
     * @param boolean $asc      是否正序
     * @param boolean $return   是否返回数据，返回数据时返回paginate对象，不返回时直接模板赋值
     * @param boolean $paginate 是否开启分页
     */
    protected function datalist($model, $map, $field = '*', $sortBy = '', $asc = false, $return = false, $paginate = true)
    {
        // 排序字段 默认为主键名
        $order = $this->request->param('_order') ?: (empty($sortBy) ? $model->getPk() : $sortBy);

        // 接受 sort参数 0 表示倒序 非0都 表示正序
        $sort = null !== $this->request->param('_sort') ?
            ($this->request->param('_sort') == 'asc' ? 'asc' : 'desc') :
            ($asc ? 'asc' : 'desc');

        // 设置关联预载入
        if (isset($map['_relation'])) {
            $model = $model::with($map['_relation']);
        }

        // 设置字段
        if (isset($map['_field'])) {
            $field = $map['_field'];
        }

        // 设置有$map['_controller']表示存在关联模型
        if (isset($map['_table'])) {
            // 给排序字段强制加上表名前缀
            if (strpos($order, ".") === false) {
                $order = $map['_table'] . "." . $order;
            }
            // 给字段强制加上表名前缀
            $_field = is_array($field) ? $field : explode(",", $field);
            foreach ($_field as &$v) {
                if (strpos($v, ".") === false) {
                    $v = preg_replace("/([^\s\(\)]*[a-z0-9\*])/", $map['_table'] . '.$1', $v, 1);
                }
            }
            $field = implode(",", $_field);
        }

        // 设置排序字段 防止表无主键报错
        $order_by = $order ? "{$order} {$sort}" : false;
        if (isset($map['_order_by'])) {
            $order_by = $map['_order_by'];
        }

        // 是否开启分页
        $paginate = isset($map['_paginate']) ? boolval($map['_paginate']) : $paginate;

        // 删除设置属性的字段
        unset($map['_table'], $map['_relation'], $map['_field'], $map['_order_by'], $map['_paginate']);

        if ($paginate) {
            // 分页查询

            // 每页数据数量
            $listRows = $this->request->param('numPerPage') ?: Config::get("paginate.list_rows");

            $list = $model->field($field)->where($map)->order($order_by)->paginate($listRows, false, ['query' => $this->request->get()]);

            if ($return) {
                // 返回值
                return $list;
            } else {
                // 模板赋值显示
                $this->view->assign('list', $list);
                $this->view->assign("count", $list->total());
                $this->view->assign("page", $list->render());
                $this->view->assign('numPerPage', $list->listRows());
            }
        } else {
            // 不开启分页查询
            $list = $model->field($field)->where($map)->order($order_by)->select();

            if ($return) {
                // 返回值
                return $list;
            } else {
                // 模板赋值显示
                $this->view->assign('list', $list);
                $this->view->assign("count", count($list));
                $this->view->assign("page", '');
                $this->view->assign('numPerPage', 0);
            }
        }
    }
}
