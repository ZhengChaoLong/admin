<?php
/**
 * @desc 创建模型默认配置
 * @author: oyj<ouyangjun@zhanghyue.com>
 * @version: 1.0 2017/2/3 14:39
 */
return [
    'module'             => 'admin',
    'menu'               => ['add'],
    'create_config'      => true,
    'form' => [
        [
            'name' => '类别',
            'field' => 'type',
            'validate' => [
                'datatype'=>'select',
                'nullmsg' => '为空提示',
                'errormsg' => '错误提示'
            ],
            'require' => '',
            'formtype' => 'select',
            'default' => '默认值',
            'option' => '',
        ],
        [
            'name' => '标题',
            'field' => 'title',
            'validate' => [
                'datatype'=>'text',
                'nullmsg' => '为空提示',
                'errormsg' => '错误提示'
            ],
            'require' => '',
            'formtype' => 'text',
            'default' => '默认值',
            'option' => '',
        ],
        [
            'name' => '摘要',
            'field' => 'description',
            'validate' => [
                'datatype'=>'text',
                'nullmsg' => '为空提示',
                'errormsg' => '错误提示'
            ],
            'require' => '',
            'formtype' => 'textarea',
            'default' => '默认值',
            'option' => '',
        ],
    ],
    'menu' => ['add','forbid','resume','delete'],
];