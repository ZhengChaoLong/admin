<?php
/**
 * @desc 字段类型
 * @author: oyj <ouyangjun@zhangyue.com>
 * @version: 1.0 2017/2/6 11:58
 */
$fileType =  [
    'text'  =>  '单行文本',
    'textarea'  =>  '多行文本',
    'editor'    =>  '编辑器',
    'radio' =>  '单选',
    'checkbox'  =>  '多选',
    'number'    =>  '数字',
    'datetime'  =>  '日期和时间',
    'select'    =>  '下拉列表',
    'password'  =>  '密码',
];
/**
 * @desc ValidForm 验证
 * @author: oyj <ouyangjun@zhangyue.com>
 * @version: 1.0 2017/2/10 15:09
 * 内置基本的dataType类型有： * | *6-16 | n | n6-16 | s | s6-18 | p | m | e | url
 */
 $dataType = [
    '*' => '任意字符不为空',
    'n' => '数字类型',
    's' => '字符串类型',
    'p' => '邮政编码',
    'm' => '手机号码格式',
    'e' => 'email格式',
    'url' => '验证字符串是否为网址',
];