<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// 以“:”开头的表示动态变量
// 以“[]”包含的变量是可选的 一般都放在最后
// 完全匹配 在规则后加“$”

use think\Route;

//注册资源路由 人生的路总归要 自己走
Route::resource('blog','index/Blog');


Route::rule('test','admin/Test/index','get');

//后缀
Route::get('route','admin/Test/RouteRule',['ext'=>'html']);

//路由到方法
Route::get('routeToMethod','index/Index/ruleToMethod');

//路由到类(任何)的方法
Route::rule('routeToClassMethod','app\index\api\test@apiRuleToClassMethod');

return [
    '__pattern__' => [
        'name' => '\w+',
    ],
    '[hello]'     => [
        ':id'   => ['index/hello', ['method' => 'get'], ['id' => '\d+']],
        ':name' => ['index/hello', ['method' => 'post']],
    ],
];
