<?php
namespace app\index\controller;

class Index
{
    public function index()
    {
        return \think\Response::create(\think\Url::build('/admin'), 'redirect');
    }

    public function ruleToMethod(){
        var_dump('路由到方法');
    }
}
