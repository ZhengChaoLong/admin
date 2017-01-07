<?php
namespace app\admin\validate;

use think\Validate;

class AdminModel extends Validate
{
    protected $rule = [
        "name|模型名称" => "require",
        "tablename|模型表键名" => "require",
    ];
}
