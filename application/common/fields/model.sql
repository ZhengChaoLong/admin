-- 主表
CREATE TABLE `$basic_table` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `type` smallint(5) unsigned NOT NULL COMMENT '类别',
  `title` varchar(80) NOT NULL default '' COMMENT '标题',
  `description` varchar(255) NOT NULL default '' COMMENT '描述',
  `sort` tinyint(3) unsigned NOT NULL default '0' COMMENT '排序',
  `status` tinyint(2) unsigned NOT NULL default '1' COMMENT '状态',
  `isdelete` tinyint(1) unsigned NOT NULL default '0' COMMENT '删除状态，1-删除 | 0-正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY  (`id`),
  KEY `status` (`status`,`sort`,`id`)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($model_id, 'type', '类别', '', '', 0, 0, '', '', 'type', '{"required":"1"}', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($model_id, 'title', '标题', '', '', 1, 80, '', '请输入标题', 'title','', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($model_id, 'description', '摘要', '', '', 0, 255, '', '', 'textarea', '', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($model_id, 'create_time', '发布时间', '', '', 0, 0, '', '', 'datetime', '', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($model_id, 'status', '状态', '', '', 0, 2, '', '', 'box', '', 0, 0);
INSERT INTO `$table_model_field` (`modelid`, `field`, `name`, `tips`, `css`, `minlength`, `maxlength`, `pattern`, `errortips`, `formtype`, `setting`, `isunique`, `disabled`) VALUES($model_id, 'update_time', '更新时间', '', '', 0, 0, '', '', 'datetime', '', 0, 0);