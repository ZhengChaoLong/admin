<?php
/**
 * @desc    模型相关数据生成
 * @author    oyj<ouyangjun@zhangyue.com>
 * @version    2017-02-03 14:24
 */

use think\Exception;
use think\Log;
use think\Config;
use think\Db;
use think\Loader;

class Model
{
    private $module;
    private $name;
    private $namespaceSuffix;
    private $nameLower;
    private $data;

    // 控制器黑名单
    private $blacklistName = [
        'AdminGroup',
        'AdminNode',
        'AdminNodeLoad',
        'AdminRole',
        'AdminUser',
        'Pub',
        'Demo',
        'Generate',
        'Index',
        'LogLogin',
        'Ueditor',
        'Upload',
        'WebLog',
        'NodeMap',
        'Error',
    ];

    // 数据表黑名单
    private $blacklistTable = [
        'admin_access',
        'admin_group',
        'admin_node',
        'admin_node_load',
        'admin_role',
        'admin_role_user',
        'admin_user',
        'file',
        'log_login',
        'node_map',
        'web_log_001',
        'web_log_all',
    ];

    /**
     * @desc 执行创建函数
     * @param array $data post相关数据
     * @throws Exception
     */
    public function run($data)
    {
        // 载入默认配置
        $defaultConfigFile = APP_PATH . 'admin' . DS . 'extra' . DS . 'model.php';
        if (file_exists($defaultConfigFile)) {
            $data = array_merge(include $defaultConfigFile, $data);
        }
        // 检查目录是否可写
        $pathCheck = APP_PATH . $data['module'] . DS;
        if (!self::checkWritable($pathCheck)) {
            throw new Exception("目录没有权限不可写，请执行一下命令修改权限：<br>chmod -R 755 " . realpath($pathCheck), 403);
        }

        $this->data = $data;
        $this->module = $data['module'];
        $this->name = $data['controller'];//控制器
        $this->nameLower = Loader::parseName($this->name);//视图

        // 数据表表名
        $tableName = $data['tableName'];

        //@TODO 仅对现有黑名单进行判断，对于后添加的控制器和表 没有查看是否已经存在
        //需要优化、此数据应该获取现有的数据表信息
        // 判断是否在黑名单中
        if (in_array($this->name, $this->blacklistName)) {
            throw new Exception('该控制器不允许创建');
        }

        // 判断是否在数据表黑名单中
        if (isset($tableName) && $tableName && in_array($tableName, $this->blacklistTable)) {
            throw new Exception('该数据表不允许创建');
        }

        // 创建具体文件需要的目录
        $dir_list = ["view" . DS . $this->nameLower];//视图
        //创建目录
        $this->buildDir($dir_list);

        // 文件路径
        $pathView = APP_PATH . $this->module . DS . "view" . DS . $this->nameLower . DS;//视图
        $pathTemplate = APP_PATH . $this->module . DS . "view" . DS . "generate" . DS . "template" . DS;//模板
        $fileName = APP_PATH . $this->module . DS . "%NAME%" . DS . $this->name . ".php";//php文件
        $code = $this->parseCode();
        // 执行方法
        $this->buildAll($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
    }

    /**
     * @desc 检查当前模块目录是否可写 通过写入内容进行测试
     * @param string $path 路径
     * @return bool
     */
    public static function checkWritable($path = null)
    {
        if (null === $path) {
            $path = APP_PATH . 'admin' . DS;
        }
        try {
            $testFile = $path . "bulid.test";
            if (!file_put_contents($testFile, "test")) {
                return false;
            }
            // 解除锁定
            unlink($testFile);
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * @desc 生成所有文件
     * @param string $pathView 视图路径
     * @param string $pathTemplate 默认模板
     * @param string $fileName 文件名称
     * @param string $tableName 表名
     * @param array $code 格式化后的form数据
     * @param array $data 表单数据
     * @throws Exception
     */
    private function buildAll($pathView, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        // 创建文件
        $this->buildIndex($pathView, $pathTemplate, $code);//index.html文件

        if (isset($data['menu']) && in_array('recyclebin', $data['menu'])) {
            $this->buildTh($pathView, $code);
            $this->buildTd($pathView, $code);
        }
        $this->buildEdit($pathView, $pathTemplate, $code);
        $this->buildController($pathTemplate, $fileName, $code);
        if (isset($data['validate']) && $data['validate']) {
            $this->buildValidate($pathTemplate, $fileName, $code);
        }
        if (isset($data['model']) && $data['model']) {
            $this->buildModel($pathTemplate, $fileName,$code);
        }
        if (isset($data['create_table']) && $data['create_table']) {
            $this->buildTable($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        }
        // 建立配置文件
        if (isset($data['create_config']) && $data['create_config']) {
            $this->buildConfig($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        }
    }

    /**
     * 创建目录
     */
    private function buildDir($dir_list)
    {
        foreach ($dir_list as $dir) {
            $path = APP_PATH . $this->module . DS . $dir;
            if (!is_dir($path)) {
                // 创建目录
                mkdir($path, 0755, true);
            }
        }
    }

    /**
     * @desc 创建 edit.html 文件
     * @param string $path 路径
     * @param string $pathTemplate 模板
     * @param array $code 模板数据
     * @return int
     */
    private function buildEdit($path, $pathTemplate, $code)
    {
        $template = file_get_contents($pathTemplate . "edit.tpl");
        $file = $path . "edit.html";

        return file_put_contents($file, str_replace(
            ["[ROWS]", "[SET_VALUE]", "[SCRIPT]"],
            [$code['edit'], implode("\n", array_merge($code['set_checked'], $code['set_selected'])), implode("", $code['script_edit'])],
            $template));
    }

    /**
     * @desc 创建th.html文件
     * @param string $path 创建文件的路径
     * @param array $code 模板详细内容
     * @return int
     */
    private function buildTh($path, $code)
    {
        $content = implode("\n", $code['th']);
        $file = $path . "th.html";

        return file_put_contents($file, $content);
    }

    /**
     * @desc 创建td.html文件
     * @param string $path 创建文件的路径
     * @param array $code 模板的详细内容
     * @return int
     */
    private function buildTd($path, $code)
    {
        $content = implode("\n", $code['td']);
        $file = $path . "td.html";

        return file_put_contents($file, $content);
    }

    /**
     * @param string $path 路径
     * @param string $pathTemplate 模板
     * @param array $code 表单数据
     * @return int
     */
    private function buildIndex($path, $pathTemplate, $code)
    {
        $script = '';
        // 菜单全选的默认直接继承模板
        $menuArr = isset($this->data['menu']) ? $this->data['menu'] : [];
        $menu = '';
        if ($menuArr) {
            $menu = '{tp:menu menu="' . implode(",", $menuArr) . '" /}';
        }
        $tdMenu = '';
        if (in_array("resume", $menuArr) || in_array("forbid", $menuArr)) {
            $tdMenu .= tab(4) . '{$vo.status|show_status=$vo.id}' . "\n";
        }
        $tdMenu .= tab(4) . '{tp:menu menu=\'sedit\' /}' . "\n";
        // 有回收站
        if (in_array('recyclebin', $menuArr)) {
            $form = '{include file="form" /}';
            $th = '{include file="th" /}';
            $td = '{include file="td" /}';
            $tdMenu .= tab(4) . '{tp:menu menu=\'sdelete\' /}';
        } else {
            $form = implode("\n" . tab(1), $code['search']);
            $th = implode("\n" . tab(3), $code['th']);
            $td = implode("\n" . tab(3), $code['td']);
            $tdMenu .= tab(4) . '{tp:menu menu=\'sdeleteforever\' /}';
        }

        $template = file_get_contents($pathTemplate . "index.tpl");
        $file = $path . "index.html";

        return file_put_contents($file, str_replace(
                ["[FORM]", "[MENU]", "[TH]", "[TD]", "[TD_MENU]", "[SCRIPT]"],
                [$form, $menu, $th, $td, $tdMenu, $script],
                $template
            )
        );
    }

    /**
     * @desc 创建控制器文件
     * @param string $pathTemplate 模板路径
     * @param string $fileName 目标控制器名称
     * @param array $code 控制器相关数据
     * @return int
     */
    private function buildController($pathTemplate, $fileName, $code)
    {
        $template = file_get_contents($pathTemplate . "Controller.tpl");
        $file = str_replace('%NAME%', 'controller', $fileName);

        return file_put_contents($file, str_replace(
                ["[TITLE]", "[NAME]", "[FILTER]", "[NAMESPACE]"],
                [$this->data['title'], $this->name, $code['filter'], $this->namespaceSuffix],
                $template
            )
        );
    }

    /**
     * @desc 创建模型文件
     * @param string $pathTemplate 模板位置
     * @param string $fileName 生成的model名称
     * @param array $code model所需要的参数
     * @return int
     */
    private function buildModel($pathTemplate, $fileName, $code)
    {
        // 直接生成空模板
        $template = file_get_contents($pathTemplate . "Model.tpl");
        $file = str_replace('%NAME%', 'model', $fileName);
        $autoTimestamp = '';
        if (isset($this->data['auto_timestamp']) && $this->data['auto_timestamp']) {
            $autoTimestamp = '// 开启自动写入时间戳字段' . "\n"
                . tab(1) . 'protected $autoWriteTimestamp = \'int\';';
        }

        return file_put_contents($file, str_replace(
                ["[TITLE]", "[NAME]", "[NAMESPACE]", "[TABLE]", "[AUTO_TIMESTAMP]"],
                [$this->data['title'], $this->name, $this->namespaceSuffix, $tableName, $autoTimestamp],
                $template
            )
        );
    }

    /**
     * @desc 创建验证器
     * @param string $pathTemplate 模板名称
     * @param string $fileName 验证器文件
     * @param array $code 验证器具体数据
     * @return int
     */
    private function buildValidate($pathTemplate, $fileName, $code)
    {
        $template = file_get_contents($pathTemplate . "Validate.tpl");
        $file = str_replace('%NAME%', 'validate', $fileName);

        return file_put_contents($file, str_replace(
                ["[TITLE]", "[NAME]", "[NAMESPACE]", "[RULE]"],
                [$this->data['title'], $this->name, $this->namespaceSuffix, $code['validate']],
                $template
            )
        );
    }

    /**
     * @desc 创建数据表
     * @param string $tableName 数据表名称
     * @return bool
     * @throws Exception
     */
    private function buildTable($tableName)
    {
        // 一定别忘记表名前缀
        $tableName = isset($this->data['table_name']) && $this->data['table_name'] ?
            $this->data['table_name'] :
            Config::get("database.prefix") . $tableName;
        // 在 MySQL 中，DROP TABLE 语句自动提交事务，因此在此事务内的任何更改都不会被回滚，不能使用事务
        // http://php.net/manual/zh/pdo.rollback.php
        $tableExist = false;
        // 判断表是否存在
        $ret = Db::query("SHOW TABLES LIKE '{$tableName}'");
        // 表存在
        if ($ret && isset($ret[0])) {
            //不是强制建表但表存在时直接return
            /*
            if (!isset($this->data['create_table_force']) || !$this->data['create_table_force']) {
                return true;
            }
            Db::execute("RENAME TABLE {$tableName} to {$tableName}_build_bak");
            */
            //@TODO return 表存在的情况应该直接return
            $tableExist = true;
        }
        $auto_create_field = ['id', 'status', 'isdelete', 'create_time', 'update_time'];
        // 强制建表和不存在原表执行建表操作
        $fieldAttr = [];
        $key = [];
        if (in_array('id', $auto_create_field)) {
            $fieldAttr[] = tab(1) . "`id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '{$this->data['title']}主键'";
        }
        foreach ($this->data['field'] as $field) {
            if (!in_array($field['name'], $auto_create_field)) {
                // 字段属性
                $fieldAttr[] = tab(1) . "`{$field['name']}` {$field['type']}"
                    . ($field['extra'] ? ' ' . $field['extra'] : '')
                    . (isset($field['not_null']) && $field['not_null'] ? ' NOT NULL' : '')
                    . (strtolower($field['default']) == 'null' ? '' : " DEFAULT '{$field['default']}'")
                    . ($field['comment'] === '' ? '' : " COMMENT '{$field['comment']}'");
            }
            // 索引
            if (isset($field['key']) && $field['key'] && $field['name'] != 'id') {
                $key[] = tab(1) . "KEY `{$field['name']}` (`{$field['name']}`)";
            }
        }

        if (isset($this->data['menu'])) {
            // 自动生成status字段，防止resume,forbid方法报错，如果不需要请到数据库自己删除
            if (in_array("resume", $this->data['menu']) || in_array("forbid", $this->data['menu'])) {
                $fieldAttr[] = tab(1) . "`status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1-正常 | 0-禁用'";
            }
            // 自动生成 isdelete 软删除字段，防止 delete,recycle,deleteForever 方法报错，如果不需要请到数据库自己删除
            if (in_array("delete", $this->data['menu']) || in_array("recyclebin", $this->data['menu'])) {
                // 修改官方软件删除使用记录时间戳的方式，效率较低，改为枚举类型的 tinyint(1)，相应的traits见 thinkphp/library/traits/model/FakeDelete.php，使用方法和官方一样
                // 软件删除详细介绍见：http://www.kancloud.cn/manual/thinkphp5/189658
                $fieldAttr[] = tab(1) . "`isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态，1-删除 | 0-正常'";
            }
        }

        // 如果创建模型则自动生成create_time，update_time字段
        if (isset($this->data['auto_timestamp']) && $this->data['auto_timestamp']) {
            // 自动生成 create_time 字段，相应自动生成的模型也开启自动写入create_time和update_time时间，并且将类型指定为int类型
            // 时间戳使用方法见：http://www.kancloud.cn/manual/thinkphp5/138668
            $fieldAttr[] = tab(1) . "`create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间'";
            $fieldAttr[] = tab(1) . "`update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'";
        }
        // 默认自动创建主键为id
        $fieldAttr[] = tab(1) . "PRIMARY KEY (`id`)";

        // 会删除之前的表，会清空数据，重新创建表，谨慎操作
        $sql_drop = "DROP TABLE IF EXISTS `{$tableName}`";
        // 默认字符编码为utf8，表引擎默认InnoDB，其他都是默认
        $sql_create = "CREATE TABLE `{$tableName}` (\n"
            . implode(",\n", array_merge($fieldAttr, $key))
            . "\n)ENGINE=" . (isset($this->data['table_engine']) ? $this->data['table_engine'] : 'InnoDB')
            . " DEFAULT CHARSET=utf8 COMMENT '{$this->data['title']}'";

        // 写入执行的SQL到日志中，如果不是想要的表结构，请到日志中搜索BUILD_SQL，找到执行的SQL到数据库GUI软件中修改执行，修改表结构
        Log::write("BUILD_SQL：\n{$sql_drop};\n{$sql_create};", Log::SQL);
        // execute和query方法都不支持传入分号 (;)，不支持一次执行多条 SQL
        try {
            Db::execute($sql_drop);
            Db::execute($sql_create);
            Db::execute("DROP TABLE IF EXISTS `{$tableName}_build_bak`");
        } catch (\Exception $e) {
            // 模拟事务操作，滚回原表
            if ($tableExist) {
                Db::execute("RENAME TABLE {$tableName}_build_bak to {$tableName}");
            }

            throw new Exception($e->getMessage());
        }
    }

    /**
     * 创建配置文件
     */
    private function buildConfig($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        $content = '<?php' . "\n\n"
            . 'return ' . var_export($data, true) . ";\n";
        $file = $path . "config.php";

        return file_put_contents($file, $content);
    }


    /**
     * 创建文件的代码
     * @return array
     * return [
     * 'search'          => $search,
     * 'th'              => $th,
     * 'td'              => $td,
     * 'edit'            => $editField,
     * 'set_checked'     => $setChecked,
     * 'set_selected'    => $setSelected,
     * 'search_selected' => $searchSelected,
     * 'filter'          => $filter,
     * 'validate'        => $validate,
     * ];
     */
    private function parseCode()
    {
        // 生成 th.html 文件的代码
        $th = ['<th width="25"><input type="checkbox"></th>'];
        // 生成 td.html 文件的代码
        $td = ['<td><input type="checkbox" name="id[]" value="{$vo.id}"></td>'];
        // 生成 edit.html 文件的代码
        $editField = '';
        // radio类型的表单控件编辑状态使用javascript赋值
        $setChecked = [];
        // select类型的表单控件编辑状态使用javascript赋值
        $setSelected = [];
        // 搜索时被选中的值
        $searchSelected = '';
        // 控制器过滤器
        $filter = '';
        // 生成验证器文件的代码
        $validate = '';
        // DatePicker脚本引入
        $scriptSearch = [];
        $scriptEdit = [];
        //添加的字段
        if (isset($this->data['form']) && $this->data['form']) {
            foreach ($this->data['form'] as $form) {
                //选项值
                //@TODO
                $options = $this->parseOption($form['option']);
                // th
                $th[] = '<th width="">' . $form['name'] . "</th>";

                // 像id这种白名单字段不需要自动生成到编辑页
                if (!in_array($form['field'], ['id', 'isdelete', 'create_time', 'update_time'])) {
                    // 使用 Validform 插件前端验证数据格式，生成在表单控件上的验证规则
                    $validateForm = '';
                    if (isset($form['validate']) && $form['validate']['datatype']) {
                        $v = $form['validate'];
                        $defaultDesc = in_array($form['field'], ['checkbox', 'radio', 'select', 'date']) ? '选择' : '填写';
                        //validform 验证
                        $validateForm = ' datatype="' . $v['datatype'] . '"'
                            . (' nullmsg="' . ($v['nullmsg'] ? $v['nullmsg'] : '请' . $defaultDesc . $form['title']) . '"')
                            . ($v['errormsg'] ? ' errormsg="' . $v['errormsg'] . '"' : '')
                            . (isset($form['require']) && $form['require'] ? '' : ' ignore="ignore"');
                        //php 验证
                        $validate .= tab(2) . '"' . $form['field'] . '|' . $form['name'] . '" => "'
                            . (isset($form['require']) && $form['require'] ? 'require' : '') . '",' . "\n";
                    }
                    //字段
                    $editField .= tab(2) . '<div class="row cl">' . "\n"
                        . tab(3) . '<label class="form-label col-xs-3 col-sm-3">'
                        . (isset($form['require']) && $form['require'] ? '<span class="c-red">*</span>' : '')
                        . $form['name'] . '：</label>' . "\n"
                        . tab(3) . '<div class="formControls col-xs-6 col-sm-6'
                        . (in_array($form['formtype'], ['radio', 'checkbox']) ? ' skin-minimal' : '')
                        . '">' . "\n";
                    switch ($form['formtype']) {
                        case "radio":
                        case "checkbox":
                            if ($form['formtype'] == "radio") {
                                // radio类型的控件进行编辑状态赋值，checkbox类型控件请自行根据情况赋值
                                $setChecked[] = tab(2) . '$("[name=\'' . $form['field'] . '\'][value=\'{$vo.' . $form['field'] . ' ?? \'' . $form['default'] . '\'}\']").attr("checked", true);';
                            } else {
                                $setChecked[] = tab(2) . 'var checks = \'' . $form['default'] . '\'.split(",");' . "\n"
                                    . tab(2) . 'if (checks.length > 0){' . "\n"
                                    . tab(3) . 'for (var i in checks){' . "\n"
                                    . tab(4) . '$("[name=\'' . $form['field'] . '[]\'][value=\'"+checks[i]+"\']").attr("checked", true);' . "\n"
                                    . tab(3) . '}' . "\n"
                                    . tab(2) . '}';
                            }

                            // 默认只生成一个空的示例控件，请根据情况自行复制编辑
                            $name = $form['field'] . ($form['formtype'] == "checkbox" ? '[]' : '');

                            switch ($options[0]) {
                                case 'string':
                                    $editField .= $this->getCheckbox($form, $name, $validateForm, $options[1], '', 0);
                                    break;
                                case 'var':
                                    $editField .= tab(4) . '{foreach name="$Think.config.conf.' . $options[1] . '" item=\'v\' key=\'k\'}' . "\n"
                                        . $this->getCheckbox($form, $name, $validateForm, '{$v}', '{$k}', '{$k}')
                                        . tab(4) . '{/foreach}' . "\n";
                                    break;
                                case 'array':
                                    foreach ($options[1] as $option) {
                                        $editField .= $this->getCheckbox($form, $name, $validateForm, $option[1], $option[0], $option[0]);
                                    }
                                    break;
                            }
                            break;
                        case "select":
                            // select类型的控件进行编辑状态赋值
                            $setSelected[] = tab(2) . '$("[name=\'' . $form['field'] . '\']").find("[value=\'{$vo.' . $form['field'] . ' ?? \'' . $form['default'] . '\'}\']").attr("selected", true);';
                            $editField .= tab(4) . '<div class="select-box">' . "\n"
                                . tab(5) . '<select name="' . $form['field'] . '" class="select"' . $validateForm . '>' . "\n"
                                . implode("\n", $this->getOption($options, $form, false, 6)) . "\n"
                                . tab(5) . '</select>' . "\n"
                                . tab(4) . '</div>' . "\n";
                            break;
                        case "textarea":
                            // 默认生成的textarea加入了输入字符长度实时统计，H-ui.admin官方的textarealength方法有问题，请使用 tpadmin 框架修改后的源码，也可拷贝 H-ui.js 里相应的方法
                            // 如果不需要字符长度实时统计，请在生成代码中删除textarea上的onKeyUp事件和下面p标签那行
                            $editField .= tab(4) . '<textarea class="textarea" placeholder="" name="' . $form['field'] . '" '
                                . 'onKeyUp="textarealength(this, 100)"' . $validateForm . '>'
                                . '{$vo.' . $form['field'] . ' ?? \'' . $form['default'] . '\'}'
                                . '</textarea>' . "\n"
                                . tab(4) . '<p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>' . "\n";
                            break;
                        case "date":
                            $editField .= tab(4) . '<input type="text" class="input-text Wdate" '
                                . 'placeholder="' . $form['name'] . '" name="' . $form['field'] . '" '
                                . 'value="' . '{$vo.' . $form['field'] . ' ?? \'' . $form['default'] . '\'}' . '" '
                                . '{literal} onfocus="WdatePicker({dateFmt:\'yyyy-MM-dd\'})" {/literal} '
                                . $validateForm . '>' . "\n";
                            $scriptEdit['date'] = "\n" . '<script type="text/javascript" src="__LIB__/My97DatePicker/WdatePicker.js"></script>';
                            break;
                        case "text":
                        case "password":
                        case "number":
                        default:
                            $editField .= tab(4) . '<input type="' . $form['formtype'] . '" class="input-text" '
                                . 'placeholder="' . $form['name'] . '" name="' . $form['field'] . '" '
                                . 'value="' . '{$vo.' . $form['field'] . ' ?? \'' . $form['default'] . '\'}' . '" '
                                . $validateForm . '>' . "\n";
                            break;
                    }
                    $editField .= tab(3) . '</div>' . "\n"
                        . tab(3) . '<div class="col-xs-3 col-sm-3"></div>' . "\n"
                        . tab(2) . '</div>' . "\n";
                }
            }
        }

        //@TODO form 提交过滤
        if ($filter) {
            $filter = 'protected function filter(&$map)' . "\n"
                . tab(1) . '{' . "\n"
                . $filter
                . tab(1) . '}';
        }
        // 自动屏蔽查询条件isdelete字段
        if (!isset($this->data['menu']) ||
            (isset($this->data['menu']) &&
                !in_array("delete", $this->data['menu']) &&
                !in_array("recyclebin", $this->data['menu'])
            )
        ) {
            $filter = 'protected static $isdelete = false;' . "\n\n" . tab(1) . $filter;
        }
        if ($validate) {
            $validate = 'protected $rule = [' . "\n" . $validate . '    ];';
        }

        return [
            'th'              => $th,
            'td'              => $td,
            'edit'            => $editField,
            'set_checked'     => $setChecked,
            'set_selected'    => $setSelected,
            'search_selected' => $searchSelected,
            'filter'          => $filter,
            'validate'        => $validate,
            'script_edit'     => $scriptEdit,
            'script_search'   => $scriptSearch,
        ];
    }

    /**
     * @desc 生成复选框、单选框
     * @param array $form 默认form
     * @param string $name 字段名称 数据字段
     * @param string $validateForm input验证规则
     * @param string $title 字段名称 说明
     * @param string $value 选项值
     * @param int $key
     * @param int $tab 空格个数
     * @return string
     */
    private function getCheckbox($form, $name, $validateForm, $title, $value = '', $key = 0, $tab = 4)
    {
        return tab($tab) . '<div class="radio-box">' . "\n"
        . tab($tab + 1) . '<input type="' . $form['type'] . '" name="' . $name . '" '
        . 'id="' . $form['name'] . '-' . $key . '" value="' . $value . '"' . $validateForm . '>' . "\n"
        . tab($tab + 1) . '<label for="' . $form['name'] . '-' . $key . '">' . $title . '</label>' . "\n"
        . tab($tab) . '</div>' . "\n";
    }

    /**
     * @desc 获取下拉框的option
     * @param array $options 选项
     * @param array $form form 表单
     * @param bool $empty 是否有选择所有的情况
     * @param int $tab 空格
     * @return array
     */
    private function getOption($options, $form, $empty = true, $tab = 3)
    {
        switch ($options[0]) {
            case 'string':
                return [tab($tab) . '<option value="">' . $options[1] . '</option>'];
                break;
            case 'var':
                $ret = [];
                if ($empty) {
                    $ret[] = tab($tab) . '<option value="">所有' . $form['title'] . '</option>';
                }
                $ret[] = tab($tab) . '{foreach name="$Think.config.conf.' . $options[1] . '" item=\'v\' key=\'k\'}';
                $ret[] = tab($tab + 1) . '<option value="{$k}">{$v}</option>';
                $ret[] = tab($tab) . '{/foreach}';

                return $ret;
                break;
            case 'array':
                $ret = [];
                foreach ($options[1] as $option) {
                    $ret[] = tab($tab) . '<option value="' . $option[0] . '">' . $option[1] . '</option>';
                }
                return $ret;
                break;
        }
    }

    /**
     * @desc 格式化选项值
     * @param string $option 选项
     * @param bool $string
     * @return array
     */
    private function parseOption($option, $string = false)
    {
        if (!$option) return ['string', $option];
        // {vo.item} 这种格式传入的变量
        if (preg_match('/^\{(.*?)\}$/', $option, $match)) {
            return ['var', $match[1]];
        } else {
            if ($string) {
                return ['string', $option];
            }
            // key:val#key2:val2#val3#... 这种格式
            $ret = [];
            $arrVal = explode('#', $option);
            foreach ($arrVal as $val) {
                $keyVal = explode(':', $val, 2);
                if (count($keyVal) == 1) {
                    $ret[] = ['', $keyVal[0]];
                } else {
                    $ret[] = [$keyVal[0], $keyVal[1]];
                }
            }
            return ['array', $ret];
        }
    }
}