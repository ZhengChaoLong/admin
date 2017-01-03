<?php
/**
 * @copyright Created by PhpStorm.
 * @author: zy
 * @version: 1.0 2016/12/1 16:24
 */
namespace app\admin\controller;

use app\admin\Controller;

use think\Cache;

class Test extends Controller{

    public function Index(){
        config('app_debug');
        var_dump('test',config('app_debug'));
    }

    /**
     * @desc redis 测试使用
     */
    public function TestRedis(){
        $cacheConfig =[
            'host'=>'192.168.6.20',
            'port'=>6379,
            'type'=>'redis'
        ];
        $cacheObj = Cache::connect($cacheConfig);
        var_dump($cacheObj);
    }

    public function RouteRule(){
        var_dump('定义路由规则');
    }
}