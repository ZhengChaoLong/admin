<?php
/**
 * @desc    ģ�������������
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
    private $dir;
    private $namespaceSuffix;
    private $nameLower;
    private $data;

    // ������������
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

    // ���ݱ������
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
     * @desc ִ�д�������
     * @param array $data post�������
     * @throws Exception
     */
    public function run($data)
    {
        // ����Ĭ������
        $defaultConfigFile = APP_PATH . 'admin' . DS . 'extra' . DS . 'model.php';
        if (file_exists($defaultConfigFile)) {
            $data = array_merge(include $defaultConfigFile, $data);
        }
        // ���Ŀ¼�Ƿ��д
        $pathCheck = APP_PATH . $data['module'] . DS;
        if (!self::checkWritable($pathCheck)) {
            throw new Exception("Ŀ¼û��Ȩ�޲���д����ִ��һ�������޸�Ȩ�ޣ�<br>chmod -R 755 " . realpath($pathCheck), 403);
        }

        $this->data = $data;
        $this->module = 'admin';//ģ��
        $this->name = ucfirst(strtolower($data['tablename']));//������
        $this->nameLower = Loader::parseName($this->name);//��ͼ

        // ���ݱ����
        $tableName = $data['tablename'];

        //@TODO �������к����������жϣ����ں���ӵĿ������ͱ� û�в鿴�Ƿ��Ѿ�����
        //��Ҫ�Ż���������Ӧ�û�ȡ���е����ݱ���Ϣ
        // �ж��Ƿ��ں�������
        if (in_array($this->name, $this->blacklistName)) {
            throw new Exception('�ÿ�������������');
        }

        // �ж��Ƿ������ݱ��������
        if (isset($tableName) && $tableName && in_array($tableName, $this->blacklistTable)) {
            throw new Exception('�����ݱ�������');
        }

        // ���������ļ���Ҫ��Ŀ¼
        $dir_list = ["view" . DS . $this->nameLower];//��ͼ
        //����Ŀ¼
        $this->buildDir($dir_list);

        // �ļ�·��
        $pathView = APP_PATH . $this->module . DS . "view" . DS . $this->nameLower . DS;//��ͼ
        $pathTemplate = APP_PATH . $this->module . DS . "view" . DS . "generate" . DS . "template" . DS;//ģ��
        $fileName = APP_PATH . $this->module . DS . "%NAME%" . DS . $this->name . ".php";//php�ļ�
        $code = $this->parseCode();
        // ִ�з���
        $this->buildAll($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
    }

    /**
     * @desc ��鵱ǰģ��Ŀ¼�Ƿ��д ͨ��д�����ݽ��в���
     * @param string $path ·��
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
            // �������
            unlink($testFile);
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * @desc ���������ļ�
     * @param string $pathView ��ͼ·��
     * @param string $pathTemplate Ĭ��ģ��
     * @param string $fileName �ļ�����
     * @param string $tableName ����
     * @param array $code ��ʽ�����form����
     * @param array $data ������
     * @throws Exception
     */
    private function buildAll($pathView, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        // �����ļ�
        $this->buildIndex($pathView, $pathTemplate, $fileName, $tableName, $code, $data);

        if (isset($data['menu']) && in_array('recyclebin', $data['menu'])) {
            $this->buildForm($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
            $this->buildTh($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
            $this->buildTd($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
            $this->buildRecycleBin($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        }
        $this->buildEdit($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        $this->buildController($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        if (isset($data['validate']) && $data['validate']) {
            $this->buildValidate($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        }
        if (isset($data['model']) && $data['model']) {
            $this->buildModel($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        }
        if (isset($data['create_table']) && $data['create_table']) {
            $this->buildTable($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        }
        // ���������ļ�
        if (isset($data['create_config']) && $data['create_config']) {
            $this->buildConfig($pathView, $pathTemplate, $fileName, $tableName, $code, $data);
        }
    }

    /**
     * ����Ŀ¼
     */
    private function buildDir($dir_list)
    {
        foreach ($dir_list as $dir) {
            $path = APP_PATH . $this->module . DS . $dir;
            if (!is_dir($path)) {
                // ����Ŀ¼
                mkdir($path, 0755, true);
            }
        }
    }

    /**
     * ���� edit.html �ļ�
     */
    private function buildEdit($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        $template = file_get_contents($pathTemplate . "edit.tpl");
        $file = $path . "edit.html";

        return file_put_contents($file, str_replace(
            ["[ROWS]", "[SET_VALUE]", "[SCRIPT]"],
            [$code['edit'], implode("\n", array_merge($code['set_checked'], $code['set_selected'])), implode("", $code['script_edit'])],
            $template));
    }

    /**
     * ����form.html�ļ�
     */
    private function buildForm($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        $content = implode("\n", $code['search']);
        $file = $path . "form.html";

        return file_put_contents($file, $content);
    }

    /**
     * ����th.html�ļ�
     */
    private function buildTh($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        $content = implode("\n", $code['th']);
        $file = $path . "th.html";

        return file_put_contents($file, $content);
    }

    /**
     * ����td.html�ļ�
     */
    private function buildTd($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        $content = implode("\n", $code['td']);
        $file = $path . "td.html";

        return file_put_contents($file, $content);
    }

    /**
     * ���� recyclebin.html �ļ�
     */
    private function buildRecycleBin($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        // ��ҳ�˵�ѡ���˻���վ�Ŵ�������վ
        $file = $path . "recyclebin.html";

        $content = '{extend name="template/recyclebin" /}';
        if ($code['search_selected']) {
            $content .= "\n" . '{block name="script"}' . implode("", $code['script_search']) . "\n"
                . '<script>' . "\n"
                . tab(1) . '$(function () {' . "\n"
                . $code['search_selected']
                . tab(1) . '})' . "\n"
                . '</script>' . "\n"
                . '{/block}' . "\n";
        }

        // Ĭ��ֱ�Ӽ̳�ģ��
        return file_put_contents($file, $content);
    }

    /**
     * @param string $path ·��
     * @param string $pathTemplate ģ��
     * @param string $fileName �ļ�����
     * @param string $tableName ����
     * @param array $code ������
     * @param array $data form�������
     * @return int
     */
    private function buildIndex($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        $script = '';
        // �˵�ȫѡ��Ĭ��ֱ�Ӽ̳�ģ��
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
        // �л���վ
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
     * �����������ļ�
     */
    private function buildController($path, $pathTemplate, $fileName, $tableName, $code, $data)
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
     * ����ģ���ļ�
     */
    private function buildModel($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        // ֱ�����ɿ�ģ��
        $template = file_get_contents($pathTemplate . "Model.tpl");
        $file = str_replace('%NAME%', 'model', $fileName);
        $autoTimestamp = '';
        if (isset($this->data['auto_timestamp']) && $this->data['auto_timestamp']) {
            $autoTimestamp = '// �����Զ�д��ʱ����ֶ�' . "\n"
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
     * ������֤��
     */
    private function buildValidate($path, $pathTemplate, $fileName, $tableName, $code, $data)
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
     * �������ݱ�
     */
    private function buildTable($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        // һ�������Ǳ���ǰ׺
        $tableName = isset($this->data['table_name']) && $this->data['table_name'] ?
            $this->data['table_name'] :
            Config::get("database.prefix") . $tableName;
        // �� MySQL �У�DROP TABLE ����Զ��ύ��������ڴ������ڵ��κθ��Ķ����ᱻ�ع�������ʹ������
        // http://php.net/manual/zh/pdo.rollback.php
        $tableExist = false;
        // �жϱ��Ƿ����
        $ret = Db::query("SHOW TABLES LIKE '{$tableName}'");
        // �����
        if ($ret && isset($ret[0])) {
            //����ǿ�ƽ��������ʱֱ��return
            if (!isset($this->data['create_table_force']) || !$this->data['create_table_force']) {
                return true;
            }
            Db::execute("RENAME TABLE {$tableName} to {$tableName}_build_bak");
            $tableExist = true;
        }
        $auto_create_field = ['id', 'status', 'isdelete', 'create_time', 'update_time'];
        // ǿ�ƽ���Ͳ�����ԭ��ִ�н������
        $fieldAttr = [];
        $key = [];
        if (in_array('id', $auto_create_field)) {
            $fieldAttr[] = tab(1) . "`id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '{$this->data['title']}����'";
        }
        foreach ($this->data['field'] as $field) {
            if (!in_array($field['name'], $auto_create_field)) {
                // �ֶ�����
                $fieldAttr[] = tab(1) . "`{$field['name']}` {$field['type']}"
                    . ($field['extra'] ? ' ' . $field['extra'] : '')
                    . (isset($field['not_null']) && $field['not_null'] ? ' NOT NULL' : '')
                    . (strtolower($field['default']) == 'null' ? '' : " DEFAULT '{$field['default']}'")
                    . ($field['comment'] === '' ? '' : " COMMENT '{$field['comment']}'");
            }
            // ����
            if (isset($field['key']) && $field['key'] && $field['name'] != 'id') {
                $key[] = tab(1) . "KEY `{$field['name']}` (`{$field['name']}`)";
            }
        }

        if (isset($this->data['menu'])) {
            // �Զ�����status�ֶΣ���ֹresume,forbid���������������Ҫ�뵽���ݿ��Լ�ɾ��
            if (in_array("resume", $this->data['menu']) || in_array("forbid", $this->data['menu'])) {
                $fieldAttr[] = tab(1) . "`status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '״̬��1-���� | 0-����'";
            }
            // �Զ����� isdelete ��ɾ���ֶΣ���ֹ delete,recycle,deleteForever ���������������Ҫ�뵽���ݿ��Լ�ɾ��
            if (in_array("delete", $this->data['menu']) || in_array("recyclebin", $this->data['menu'])) {
                // �޸Ĺٷ����ɾ��ʹ�ü�¼ʱ����ķ�ʽ��Ч�ʽϵͣ���Ϊö�����͵� tinyint(1)����Ӧ��traits�� thinkphp/library/traits/model/FakeDelete.php��ʹ�÷����͹ٷ�һ��
                // ���ɾ����ϸ���ܼ���http://www.kancloud.cn/manual/thinkphp5/189658
                $fieldAttr[] = tab(1) . "`isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'ɾ��״̬��1-ɾ�� | 0-����'";
            }
        }

        // �������ģ�����Զ�����create_time��update_time�ֶ�
        if (isset($this->data['auto_timestamp']) && $this->data['auto_timestamp']) {
            // �Զ����� create_time �ֶΣ���Ӧ�Զ����ɵ�ģ��Ҳ�����Զ�д��create_time��update_timeʱ�䣬���ҽ�����ָ��Ϊint����
            // ʱ���ʹ�÷�������http://www.kancloud.cn/manual/thinkphp5/138668
            $fieldAttr[] = tab(1) . "`create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��'";
            $fieldAttr[] = tab(1) . "`update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��'";
        }
        // Ĭ���Զ���������Ϊid
        $fieldAttr[] = tab(1) . "PRIMARY KEY (`id`)";

        // ��ɾ��֮ǰ�ı���������ݣ����´�������������
        $sql_drop = "DROP TABLE IF EXISTS `{$tableName}`";
        // Ĭ���ַ�����Ϊutf8��������Ĭ��InnoDB����������Ĭ��
        $sql_create = "CREATE TABLE `{$tableName}` (\n"
            . implode(",\n", array_merge($fieldAttr, $key))
            . "\n)ENGINE=" . (isset($this->data['table_engine']) ? $this->data['table_engine'] : 'InnoDB')
            . " DEFAULT CHARSET=utf8 COMMENT '{$this->data['title']}'";

        // д��ִ�е�SQL����־�У����������Ҫ�ı�ṹ���뵽��־������BUILD_SQL���ҵ�ִ�е�SQL�����ݿ�GUI������޸�ִ�У��޸ı�ṹ
        Log::write("BUILD_SQL��\n{$sql_drop};\n{$sql_create};", Log::SQL);
        // execute��query��������֧�ִ���ֺ� (;)����֧��һ��ִ�ж��� SQL
        try {
            Db::execute($sql_drop);
            Db::execute($sql_create);
            Db::execute("DROP TABLE IF EXISTS `{$tableName}_build_bak`");
        } catch (\Exception $e) {
            // ģ���������������ԭ��
            if ($tableExist) {
                Db::execute("RENAME TABLE {$tableName}_build_bak to {$tableName}");
            }

            throw new Exception($e->getMessage());
        }
    }

    /**
     * ���������ļ�
     */
    private function buildConfig($path, $pathTemplate, $fileName, $tableName, $code, $data)
    {
        $content = '<?php' . "\n\n"
            . 'return ' . var_export($data, true) . ";\n";
        $file = $path . "config.php";

        return file_put_contents($file, $content);
    }


    /**
     * �����ļ��Ĵ���
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
        // ���� th.html �ļ��Ĵ���
        $th = ['<th width="25"><input type="checkbox"></th>'];
        // ���� td.html �ļ��Ĵ���
        $td = ['<td><input type="checkbox" name="id[]" value="{$vo.id}"></td>'];
        // ���� edit.html �ļ��Ĵ���
        $editField = '';
        // radio���͵ı��ؼ��༭״̬ʹ��javascript��ֵ
        $setChecked = [];
        // select���͵ı��ؼ��༭״̬ʹ��javascript��ֵ
        $setSelected = [];
        // ����ʱ��ѡ�е�ֵ
        $searchSelected = '';
        // ������������
        $filter = '';
        // ������֤���ļ��Ĵ���
        $validate = '';
        // DatePicker�ű�����
        $scriptSearch = [];
        $scriptEdit = [];
        //��ӵ��ֶ�
        if (isset($this->data['form']) && $this->data['form']) {
            foreach ($this->data['form'] as $form) {
                //ѡ��ֵ
                //@TODO
                $options = $this->parseOption($form['option']);
                // th
                $th[] = '<th width="">' . $form['title'] . "</th>";

                // ��id���ְ������ֶβ���Ҫ�Զ����ɵ��༭ҳ
                if (!in_array($form['name'], ['id', 'isdelete', 'create_time', 'update_time'])) {
                    // ʹ�� Validform ���ǰ����֤���ݸ�ʽ�������ڱ��ؼ��ϵ���֤����
                    $validateForm = '';
                    if (isset($form['validate']) && $form['validate']['datatype']) {
                        $v = $form['validate'];
                        $defaultDesc = in_array($form['type'], ['checkbox', 'radio', 'select', 'date']) ? 'ѡ��' : '��д';
                        $validateForm = ' datatype="' . $v['datatype'] . '"'
                            . (' nullmsg="' . ($v['nullmsg'] ? $v['nullmsg'] : '��' . $defaultDesc . $form['title']) . '"')
                            . ($v['errormsg'] ? ' errormsg="' . $v['errormsg'] . '"' : '')
                            . (isset($form['require']) && $form['require'] ? '' : ' ignore="ignore"');
                        $validate .= tab(2) . '"' . $form['name'] . '|' . $form['title'] . '" => "'
                            . (isset($form['require']) && $form['require'] ? 'require' : '') . '",' . "\n";
                    }
                    //�ֶ�
                    $editField .= tab(2) . '<div class="row cl">' . "\n"
                        . tab(3) . '<label class="form-label col-xs-3 col-sm-3">'
                        . (isset($form['require']) && $form['require'] ? '<span class="c-red">*</span>' : '')
                        . $form['title'] . '��</label>' . "\n"
                        . tab(3) . '<div class="formControls col-xs-6 col-sm-6'
                        . (in_array($form['type'], ['radio', 'checkbox']) ? ' skin-minimal' : '')
                        . '">' . "\n";
                    switch ($form['type']) {
                        case "radio":
                        case "checkbox":
                            if ($form['type'] == "radio") {
                                // radio���͵Ŀؼ����б༭״̬��ֵ��checkbox���Ϳؼ������и��������ֵ
                                $setChecked[] = tab(2) . '$("[name=\'' . $form['name'] . '\'][value=\'{$vo.' . $form['name'] . ' ?? \'' . $form['default'] . '\'}\']").attr("checked", true);';
                            } else {
                                $setChecked[] = tab(2) . 'var checks = \'' . $form['default'] . '\'.split(",");' . "\n"
                                    . tab(2) . 'if (checks.length > 0){' . "\n"
                                    . tab(3) . 'for (var i in checks){' . "\n"
                                    . tab(4) . '$("[name=\'' . $form['name'] . '[]\'][value=\'"+checks[i]+"\']").attr("checked", true);' . "\n"
                                    . tab(3) . '}' . "\n"
                                    . tab(2) . '}';
                            }

                            // Ĭ��ֻ����һ���յ�ʾ���ؼ��������������и��Ʊ༭
                            $name = $form['name'] . ($form['type'] == "checkbox" ? '[]' : '');

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
                            // select���͵Ŀؼ����б༭״̬��ֵ
                            $setSelected[] = tab(2) . '$("[name=\'' . $form['name'] . '\']").find("[value=\'{$vo.' . $form['name'] . ' ?? \'' . $form['default'] . '\'}\']").attr("selected", true);';
                            $editField .= tab(4) . '<div class="select-box">' . "\n"
                                . tab(5) . '<select name="' . $form['name'] . '" class="select"' . $validateForm . '>' . "\n"
                                . implode("\n", $this->getOption($options, $form, false, 6)) . "\n"
                                . tab(5) . '</select>' . "\n"
                                . tab(4) . '</div>' . "\n";
                            break;
                        case "textarea":
                            // Ĭ�����ɵ�textarea�����������ַ�����ʵʱͳ�ƣ�H-ui.admin�ٷ���textarealength���������⣬��ʹ�� tpadmin ����޸ĺ��Դ�룬Ҳ�ɿ��� H-ui.js ����Ӧ�ķ���
                            // �������Ҫ�ַ�����ʵʱͳ�ƣ��������ɴ�����ɾ��textarea�ϵ�onKeyUp�¼�������p��ǩ����
                            $editField .= tab(4) . '<textarea class="textarea" placeholder="" name="' . $form['name'] . '" '
                                . 'onKeyUp="textarealength(this, 100)"' . $validateForm . '>'
                                . '{$vo.' . $form['name'] . ' ?? \'' . $form['default'] . '\'}'
                                . '</textarea>' . "\n"
                                . tab(4) . '<p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>' . "\n";
                            break;
                        case "date":
                            $editField .= tab(4) . '<input type="text" class="input-text Wdate" '
                                . 'placeholder="' . $form['title'] . '" name="' . $form['name'] . '" '
                                . 'value="' . '{$vo.' . $form['name'] . ' ?? \'' . $form['default'] . '\'}' . '" '
                                . '{literal} onfocus="WdatePicker({dateFmt:\'yyyy-MM-dd\'})" {/literal} '
                                . $validateForm . '>' . "\n";
                            $scriptEdit['date'] = "\n" . '<script type="text/javascript" src="__LIB__/My97DatePicker/WdatePicker.js"></script>';
                            break;
                        case "text":
                        case "password":
                        case "number":
                        default:
                            $editField .= tab(4) . '<input type="' . $form['type'] . '" class="input-text" '
                                . 'placeholder="' . $form['title'] . '" name="' . $form['name'] . '" '
                                . 'value="' . '{$vo.' . $form['name'] . ' ?? \'' . $form['default'] . '\'}' . '" '
                                . $validateForm . '>' . "\n";
                            break;
                    }
                    $editField .= tab(3) . '</div>' . "\n"
                        . tab(3) . '<div class="col-xs-3 col-sm-3"></div>' . "\n"
                        . tab(2) . '</div>' . "\n";
                }
            }
        }

        if ($filter) {
            $filter = 'protected function filter(&$map)' . "\n"
                . tab(1) . '{' . "\n"
                . $filter
                . tab(1) . '}';
        }
        // �Զ����β�ѯ����isdelete�ֶ�
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
     * @desc ���ɸ�ѡ�򡢵�ѡ��
     * @param array $form Ĭ��form
     * @param string $name �ֶ����� �����ֶ�
     * @param string $validateForm input��֤����
     * @param string $title �ֶ����� ˵��
     * @param string $value ѡ��ֵ
     * @param int $key
     * @param int $tab �ո����
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
     * @desc ��ȡ�������option
     * @param array $options ѡ��
     * @param array $form form ��
     * @param bool $empty �Ƿ���ѡ�����е����
     * @param int $tab �ո�
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
                    $ret[] = tab($tab) . '<option value="">����' . $form['title'] . '</option>';
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
     * @desc ��ʽ��ѡ��ֵ
     * @param string $option ѡ��
     * @param bool $string
     * @return array
     */
    private function parseOption($option, $string = false)
    {
        if (!$option) return ['string', $option];
        // {vo.item} ���ָ�ʽ����ı���
        if (preg_match('/^\{(.*?)\}$/', $option, $match)) {
            return ['var', $match[1]];
        } else {
            if ($string) {
                return ['string', $option];
            }
            // key:val#key2:val2#val3#... ���ָ�ʽ
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