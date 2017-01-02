<?php
namespace app\index\controller;

use think\Controller;
use think\Request;

class Index extends controller{

    /**
     * @var array 设置当前操作的前置方法
     */
    protected $beforeActionList = [
        'first',
    ];

    public function first(){
        echo '前置方法';
    }

    /**
     * @desc 初始化
     * 需要继承 controller基类才可以使用
     */
    public function _initialize(){
        echo "<pre>";
        var_dump('初始化函数');
        parent::_initialize();
    }

    public function index(){
        return \think\Response::create(\think\Url::build('/admin'), 'redirect');
    }


    public function ruleToMethod(){
        //var_dump('路由到方法');
        $arr = ['路由到方法'];
        $request = Request::instance();
        var_dump(
            $request->url(true),
            $request->module(),
            $request->controller(),
            $request->action());

        //return json($arr,200);
    }
}
