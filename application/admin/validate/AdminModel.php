<?php
namespace app\admin\validate;

use think\Validate;

class AdminModel extends Validate
{
    protected $rule = [
        "name|模型名称" => "require",
        "tableName|模型表键名" => "require",
    ];
}
