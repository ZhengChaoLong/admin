-- 主表
CREATE TABLE `$basic_table` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `type` smallint(5) unsigned NOT NULL comment '类别',
  `title` varchar(80) NOT NULL default '' comment '标题',
  `description` varchar(255) NOT NULL default '' comment '描述',
  `sort` tinyint(3) unsigned NOT NULL default '0' comment '排序',
  `status` tinyint(2) unsigned NOT NULL default '1' comment '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY  (`id`),
  KEY `status` (`status`,`sort`,`id`)
) TYPE=MyISAM;

--默认字段
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($modelid, 'type', '类别', '', '', 0, 0, '', '', 'type', 'array (\n  ''minnumber'' => '''',\n  ''defaultvalue'' => '''',\n)', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($modelid, 'title', '标题', '', '', 1, 80, '', '请输入标题', 'title', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($modelid, 'description', '摘要', '', '', 0, 255, '', '', 'textarea', 'array (\r\n  ''width'' => ''98'',\r\n  ''height'' => ''46'',\r\n  ''defaultvalue'' => '''',\r\n  ''enablehtml'' => ''0'',\r\n)', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($modelid, 'create_time', '发布时间', '', '', 0, 0, '', '', 'datetime', 'array (\n  ''fieldtype'' => ''int'',\n  ''format'' => ''Y-m-d H:i:s'',\n  ''defaulttype'' => ''0'',\n)', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($modelid, 'status', '状态', '', '', 0, 2, '', '', 'box', '', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($modelid, 'update_time', '更新时间', '', '', 0, 0, '', '', 'datetime', 'array (\r\n  ''dateformat'' => ''int'',\r\n  ''format'' => ''Y-m-d H:i:s'',\r\n  ''defaulttype'' => ''1'',\r\n  ''defaultvalue'' => '''',\r\n)', 0, 0);
