-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.17 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.3.0.5111
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 zyadmin 的数据库结构
DROP DATABASE IF EXISTS `zyadmin`;
CREATE DATABASE IF NOT EXISTS `zyadmin` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `zyadmin`;

-- 导出  表 zyadmin.zy_admin_access 结构
CREATE TABLE IF NOT EXISTS `zy_admin_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `node_id` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  KEY `groupId` (`role_id`),
  KEY `nodeId` (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- 正在导出表  zyadmin.zy_admin_access 的数据：22 rows
/*!40000 ALTER TABLE `zy_admin_access` DISABLE KEYS */;
INSERT INTO `zy_admin_access` (`role_id`, `node_id`, `level`, `pid`) VALUES
	(5, 1, 1, 0),
	(5, 9, 2, 1),
	(5, 32, 3, 9),
	(5, 33, 3, 9),
	(5, 10, 2, 1),
	(5, 11, 2, 1),
	(5, 12, 2, 1),
	(5, 13, 2, 1),
	(5, 14, 2, 1),
	(5, 15, 2, 1),
	(5, 16, 2, 1),
	(5, 17, 2, 1),
	(5, 18, 2, 1),
	(5, 19, 2, 1),
	(6, 65, 3, 60),
	(6, 64, 3, 60),
	(6, 63, 3, 60),
	(6, 62, 3, 60),
	(6, 61, 3, 60),
	(6, 60, 2, 1),
	(6, 10, 2, 1),
	(6, 1, 1, 0);
/*!40000 ALTER TABLE `zy_admin_access` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_activity 结构
CREATE TABLE IF NOT EXISTS `zy_admin_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '活动主键',
  `type` smallint(6) NOT NULL COMMENT '活动类型',
  `startTime` int(11) DEFAULT NULL COMMENT '开始时间',
  `endTime` int(11) DEFAULT NULL COMMENT '结束时间',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `channelIds` varchar(255) DEFAULT NULL COMMENT '渠道',
  `rule` text COMMENT '规则',
  `ext` text COMMENT '扩展',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1-正常 | 0-禁用',
  `isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态，1-删除 | 0-正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='活动';

-- 正在导出表  zyadmin.zy_admin_activity 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `zy_admin_activity` DISABLE KEYS */;
INSERT INTO `zy_admin_activity` (`id`, `type`, `startTime`, `endTime`, `description`, `channelIds`, `rule`, `ext`, `status`, `isdelete`) VALUES
	(1, 1, 1482986003, 1483590803, 'test', '116147', '1、加油', NULL, 1, 0);
/*!40000 ALTER TABLE `zy_admin_activity` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_group 结构
CREATE TABLE IF NOT EXISTS `zy_admin_group` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `icon` varchar(255) NOT NULL COMMENT 'icon小图标',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `remark` varchar(255) NOT NULL,
  `isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- 正在导出表  zyadmin.zy_admin_group 的数据：3 rows
/*!40000 ALTER TABLE `zy_admin_group` DISABLE KEYS */;
INSERT INTO `zy_admin_group` (`id`, `name`, `icon`, `sort`, `status`, `remark`, `isdelete`, `create_time`, `update_time`) VALUES
	(1, '系统管理', '&#xe61d;', 1, 1, '', 0, 1450752856, 1475768760),
	(2, '示例', '&#xe616;', 2, 1, '', 0, 1476016712, 1476017769),
	(3, '后台管理', '&#xe63c', 3, 1, '后台管理', 0, 1480672161, 1484042080);
/*!40000 ALTER TABLE `zy_admin_group` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_model 结构
CREATE TABLE IF NOT EXISTS `zy_admin_model` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(30) NOT NULL COMMENT '模型名称',
  `description` char(100) NOT NULL COMMENT '关于模型的描述',
  `tablename` char(20) NOT NULL COMMENT '模型的表',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '模型是否启用',
  `sort` tinyint(3) NOT NULL COMMENT '排序',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态，1-删除 | 0-正常',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  zyadmin.zy_admin_model 的数据：0 rows
/*!40000 ALTER TABLE `zy_admin_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `zy_admin_model` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_node 结构
CREATE TABLE IF NOT EXISTS `zy_admin_node` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(6) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '节点类型，1-控制器 | 0-方法',
  `sort` smallint(6) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `level` (`level`),
  KEY `pid` (`pid`),
  KEY `status` (`status`),
  KEY `name` (`name`),
  KEY `isdelete` (`isdelete`),
  KEY `sort` (`sort`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- 正在导出表  zyadmin.zy_admin_node 的数据：66 rows
/*!40000 ALTER TABLE `zy_admin_node` DISABLE KEYS */;
INSERT INTO `zy_admin_node` (`id`, `pid`, `group_id`, `name`, `title`, `remark`, `level`, `type`, `sort`, `status`, `isdelete`) VALUES
	(1, 0, 1, 'Admin', '后台管理', '后台管理，不可更改', 1, 1, 1, 1, 0),
	(2, 1, 1, 'AdminGroup', '分组管理', ' ', 2, 1, 1, 1, 0),
	(3, 1, 1, 'AdminNode', '节点管理', ' ', 2, 1, 2, 1, 0),
	(4, 1, 1, 'AdminRole', '角色管理', ' ', 2, 1, 3, 1, 0),
	(5, 1, 1, 'AdminUser', '用户管理', '', 2, 1, 4, 1, 0),
	(6, 1, 0, 'Index', '首页', '', 2, 1, 50, 1, 0),
	(7, 6, 0, 'welcome', '欢迎页', '', 3, 0, 50, 1, 0),
	(8, 6, 0, 'index', '未定义', '', 3, 0, 50, 1, 0),
	(9, 1, 2, 'Generate', '代码自动生成', '', 2, 1, 50, 1, 0),
	(10, 1, 3, 'Demo/excel', 'Excel一键导出', '', 2, 0, 2, 1, 0),
	(11, 1, 2, 'Demo/download', '下载', '', 2, 0, 3, 1, 0),
	(12, 1, 2, 'Demo/downloadImage', '远程图片下载', '', 2, 0, 4, 1, 0),
	(13, 1, 2, 'Demo/mail', '邮件发送', '', 2, 0, 5, 1, 0),
	(14, 1, 2, 'Demo/qiniu', '七牛上传', '', 2, 0, 6, 1, 0),
	(15, 1, 2, 'Demo/hashids', 'ID加密', '', 2, 0, 7, 1, 0),
	(16, 1, 2, 'Demo/layer', '丰富弹层', '', 2, 0, 8, 1, 0),
	(17, 1, 2, 'Demo/tableFixed', '表格溢出', '', 2, 0, 9, 1, 0),
	(18, 1, 2, 'Demo/ueditor', '百度编辑器', '', 2, 0, 10, 1, 0),
	(19, 1, 2, 'Demo/imageUpload', '图片上传', '', 2, 0, 11, 1, 0),
	(20, 1, 2, 'Demo/qrcode', '二维码生成', '', 2, 0, 12, 1, 0),
	(21, 1, 1, 'NodeMap', '节点图', '', 2, 1, 5, 1, 0),
	(22, 1, 1, 'WebLog', '操作日志', '', 2, 1, 6, 1, 0),
	(23, 1, 1, 'LoginLog', '登录日志', '', 2, 1, 7, 1, 0),
	(24, 23, 0, 'index', '首页', '', 3, 0, 50, 1, 0),
	(25, 22, 0, 'index', '列表', '', 3, 0, 50, 1, 0),
	(26, 22, 0, 'detail', '详情', '', 3, 0, 50, 1, 0),
	(27, 21, 0, 'load', '自动导入', '', 3, 0, 50, 1, 0),
	(28, 21, 0, 'index', '首页', '', 3, 0, 50, 1, 0),
	(29, 21, 0, 'add', '添加', '', 3, 0, 50, 1, 0),
	(30, 21, 0, 'edit', '编辑', '', 3, 0, 50, 1, 0),
	(31, 21, 0, 'deleteForever', '永久删除', '', 3, 0, 50, 1, 0),
	(32, 9, 0, 'index', '首页', '', 3, 0, 50, 1, 0),
	(33, 9, 0, 'generate', '生成方法', '', 3, 0, 50, 1, 0),
	(34, 5, 0, 'password', '修改密码', '', 3, 0, 50, 1, 0),
	(35, 5, 0, 'index', '首页', '', 3, 0, 50, 1, 0),
	(36, 5, 0, 'add', '添加', '', 3, 0, 50, 1, 0),
	(37, 5, 0, 'edit', '编辑', '', 3, 0, 50, 1, 0),
	(38, 4, 0, 'user', '用户列表', '', 3, 0, 50, 1, 0),
	(39, 4, 0, 'access', '授权', '', 3, 0, 50, 1, 0),
	(40, 4, 0, 'index', '首页', '', 3, 0, 50, 1, 0),
	(41, 4, 0, 'add', '添加', '', 3, 0, 50, 1, 0),
	(42, 4, 0, 'edit', '编辑', '', 3, 0, 50, 1, 0),
	(43, 4, 0, 'forbid', '默认禁用操作', '', 3, 0, 50, 1, 0),
	(44, 4, 0, 'resume', '默认恢复操作', '', 3, 0, 50, 1, 0),
	(45, 3, 0, 'load', '节点快速导入', '', 3, 0, 50, 1, 0),
	(46, 3, 0, 'index', '首页', '', 3, 0, 50, 1, 0),
	(47, 3, 0, 'add', '添加', '', 3, 0, 50, 1, 0),
	(48, 3, 0, 'edit', '编辑', '', 3, 0, 50, 1, 0),
	(49, 3, 0, 'forbid', '默认禁用操作', '', 3, 0, 50, 1, 0),
	(50, 3, 0, 'resume', '默认恢复操作', '', 3, 0, 50, 1, 0),
	(51, 2, 0, 'index', '首页', '', 3, 0, 50, 1, 0),
	(52, 2, 0, 'add', '添加', '', 3, 0, 50, 1, 0),
	(53, 2, 0, 'edit', '编辑', '', 3, 0, 50, 1, 0),
	(54, 2, 0, 'forbid', '默认禁用操作', '', 3, 0, 50, 1, 0),
	(55, 2, 0, 'resume', '默认恢复操作', '', 3, 0, 50, 1, 0),
	(56, 1, 2, 'one', '多级菜单演示', '', 2, 1, 13, 1, 0),
	(57, 56, 2, 'two', '三级菜单', '', 3, 1, 1, 1, 0),
	(58, 57, 2, 'three', '四级菜单', '', 4, 0, 1, 1, 0),
	(59, 0, 3, 'AdminActivity', '活动管理', '', 1, 1, 50, 1, 1),
	(60, 1, 3, 'AdminActivity', '活动管理', '', 2, 1, 50, 1, 0),
	(61, 60, 0, 'index', '首页', '', 3, 1, 50, 1, 0),
	(62, 60, 0, 'add', '添加', '', 3, 1, 50, 1, 0),
	(63, 60, 0, 'edit', '编辑', '', 3, 1, 50, 1, 0),
	(64, 60, 0, 'forbid', '默认禁用操作', '', 3, 1, 50, 1, 0),
	(65, 60, 0, 'resume', '默认恢复操作', '', 3, 1, 50, 1, 0),
	(66, 1, 3, 'AdminModel', '模型管理', '', 2, 1, 50, 1, 0),
	(67, 66, 0, 'index', '首页', '', 3, 1, 50, 1, 0),
	(68, 66, 0, 'edit', '编辑', '', 3, 0, 50, 1, 0);
/*!40000 ALTER TABLE `zy_admin_node` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_node_load 结构
CREATE TABLE IF NOT EXISTS `zy_admin_node_load` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='节点快速导入';

-- 正在导出表  zyadmin.zy_admin_node_load 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `zy_admin_node_load` DISABLE KEYS */;
INSERT INTO `zy_admin_node_load` (`id`, `title`, `name`, `status`) VALUES
	(4, '编辑', 'edit', 1),
	(5, '添加', 'add', 1),
	(6, '首页', 'index', 1),
	(7, '删除', 'delete', 1);
/*!40000 ALTER TABLE `zy_admin_node_load` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_role 结构
CREATE TABLE IF NOT EXISTS `zy_admin_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(6) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`),
  KEY `isdelete` (`isdelete`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- 正在导出表  zyadmin.zy_admin_role 的数据：4 rows
/*!40000 ALTER TABLE `zy_admin_role` DISABLE KEYS */;
INSERT INTO `zy_admin_role` (`id`, `pid`, `name`, `remark`, `status`, `isdelete`, `create_time`, `update_time`) VALUES
	(1, 0, '领导组', ' ', 1, 0, 1208784792, 1254325558),
	(2, 0, '网编组', ' ', 1, 0, 1215496283, 1454049929),
	(5, 0, '运营', '运营', 1, 0, 1480670322, 1480670322),
	(6, 0, 'manager', '管理员', 1, 0, 1483580512, 1483580512);
/*!40000 ALTER TABLE `zy_admin_role` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_role_user 结构
CREATE TABLE IF NOT EXISTS `zy_admin_role_user` (
  `role_id` mediumint(9) unsigned DEFAULT NULL,
  `user_id` char(32) DEFAULT NULL,
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- 正在导出表  zyadmin.zy_admin_role_user 的数据：3 rows
/*!40000 ALTER TABLE `zy_admin_role_user` DISABLE KEYS */;
INSERT INTO `zy_admin_role_user` (`role_id`, `user_id`) VALUES
	(1, '2'),
	(5, '3'),
	(6, '4');
/*!40000 ALTER TABLE `zy_admin_role_user` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_admin_user 结构
CREATE TABLE IF NOT EXISTS `zy_admin_user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `account` char(32) NOT NULL,
  `realname` varchar(255) NOT NULL,
  `password` char(32) NOT NULL,
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_ip` char(15) NOT NULL,
  `login_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL,
  `mobile` char(11) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountpassword` (`account`,`password`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- 正在导出表  zyadmin.zy_admin_user 的数据：4 rows
/*!40000 ALTER TABLE `zy_admin_user` DISABLE KEYS */;
INSERT INTO `zy_admin_user` (`id`, `account`, `realname`, `password`, `last_login_time`, `last_login_ip`, `login_count`, `email`, `mobile`, `remark`, `status`, `isdelete`, `create_time`, `update_time`) VALUES
	(1, 'admin', '超级管理员', 'e10adc3949ba59abbe56e057f20f883e', 1484028268, '127.0.0.1', 341, 'tianpian0805@gmail.com', '13121126169', '我是超级管理员', 1, 0, 1222907803, 1451033528),
	(2, 'demo', '测试', 'e10adc3949ba59abbe56e057f20f883e', 1477404006, '127.0.0.1', 2, '', '', '', 1, 0, 1476777133, 1477399793),
	(3, 'demo1', 'demo1', 'e10adc3949ba59abbe56e057f20f883e', 1480911793, '127.0.0.1', 2, 'demo1@zhangyue.com', '', 'demo1', 1, 0, 1480670431, 1480670431),
	(4, 'ouyangjun', 'ouyangjun', 'a985e652c92c7f0065b645525449786a', 1484028238, '127.0.0.1', 2, 'ouyangjun@zhangyue.com', '', '', 1, 0, 1483580568, 1483580568);
/*!40000 ALTER TABLE `zy_admin_user` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_file 结构
CREATE TABLE IF NOT EXISTS `zy_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '文件类型，1-image | 2-file',
  `name` varchar(255) NOT NULL COMMENT '文件名',
  `original` varchar(255) NOT NULL DEFAULT '' COMMENT '原文件名',
  `domain` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `mtime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  zyadmin.zy_file 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `zy_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `zy_file` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_login_log 结构
CREATE TABLE IF NOT EXISTS `zy_login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) unsigned NOT NULL,
  `login_ip` char(15) NOT NULL,
  `login_location` varchar(255) NOT NULL,
  `login_browser` varchar(255) NOT NULL,
  `login_os` varchar(255) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=674 DEFAULT CHARSET=utf8;

-- 正在导出表  zyadmin.zy_login_log 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `zy_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zy_login_log` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_node_map 结构
CREATE TABLE IF NOT EXISTS `zy_node_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` char(6) NOT NULL COMMENT '模块',
  `map` varchar(255) NOT NULL COMMENT '节点图',
  `is_ajax` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是ajax请求',
  `comment` varchar(255) NOT NULL COMMENT '节点图描述',
  PRIMARY KEY (`id`),
  KEY `map` (`map`)
) ENGINE=InnoDB AUTO_INCREMENT=530 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点图';

-- 正在导出表  zyadmin.zy_node_map 的数据：~113 rows (大约)
/*!40000 ALTER TABLE `zy_node_map` DISABLE KEYS */;
INSERT INTO `zy_node_map` (`id`, `module`, `map`, `is_ajax`, `comment`) VALUES
	(362, 'admin', 'AdminGroup/index', 0, 'AdminGroup 首页'),
	(363, 'admin', 'AdminGroup/recycleBin', 0, 'AdminGroup 回收站'),
	(364, 'admin', 'AdminGroup/add', 0, 'AdminGroup 添加'),
	(365, 'admin', 'AdminGroup/edit', 0, '{:__user__}编辑分组管理'),
	(366, 'admin', 'AdminGroup/delete', 0, 'AdminGroup 默认删除操作'),
	(367, 'admin', 'AdminGroup/recycle', 0, 'AdminGroup 从回收站恢复'),
	(368, 'admin', 'AdminGroup/forbid', 0, 'AdminGroup 默认禁用操作'),
	(369, 'admin', 'AdminGroup/resume', 0, 'AdminGroup 默认恢复操作'),
	(370, 'admin', 'AdminGroup/deleteForever', 0, 'AdminGroup 永久删除'),
	(371, 'admin', 'AdminGroup/clear', 0, 'AdminGroup 清空回收站'),
	(377, 'admin', 'AdminNode/load', 0, 'AdminNode 节点快速导入'),
	(378, 'admin', 'AdminNode/index', 0, 'AdminNode 首页'),
	(379, 'admin', 'AdminNode/recycleBin', 0, 'AdminNode 回收站'),
	(380, 'admin', 'AdminNode/add', 0, 'AdminNode 添加'),
	(381, 'admin', 'AdminNode/edit', 0, 'AdminNode 编辑'),
	(382, 'admin', 'AdminNode/delete', 0, 'AdminNode 默认删除操作'),
	(383, 'admin', 'AdminNode/recycle', 0, 'AdminNode 从回收站恢复'),
	(384, 'admin', 'AdminNode/forbid', 0, 'AdminNode 默认禁用操作'),
	(385, 'admin', 'AdminNode/resume', 0, 'AdminNode 默认恢复操作'),
	(386, 'admin', 'AdminNode/deleteForever', 0, 'AdminNode 永久删除'),
	(387, 'admin', 'AdminNode/clear', 0, 'AdminNode 清空回收站'),
	(392, 'admin', 'AdminNodeLoad/index', 0, 'AdminNodeLoad 首页'),
	(393, 'admin', 'AdminNodeLoad/recycleBin', 0, 'AdminNodeLoad 回收站'),
	(394, 'admin', 'AdminNodeLoad/add', 0, 'AdminNodeLoad 添加'),
	(395, 'admin', 'AdminNodeLoad/edit', 0, 'AdminNodeLoad 编辑'),
	(396, 'admin', 'AdminNodeLoad/forbid', 0, 'AdminNodeLoad 默认禁用操作'),
	(397, 'admin', 'AdminNodeLoad/resume', 0, 'AdminNodeLoad 默认恢复操作'),
	(398, 'admin', 'AdminNodeLoad/deleteForever', 0, 'AdminNodeLoad 永久删除'),
	(399, 'admin', 'AdminNodeLoad/clear', 0, 'AdminNodeLoad 清空回收站'),
	(407, 'admin', 'AdminRole/user', 0, 'AdminRole 用户列表'),
	(408, 'admin', 'AdminRole/access', 0, 'AdminRole 授权'),
	(409, 'admin', 'AdminRole/index', 0, 'AdminRole 首页'),
	(410, 'admin', 'AdminRole/recycleBin', 0, 'AdminRole 回收站'),
	(411, 'admin', 'AdminRole/add', 0, 'AdminRole 添加'),
	(412, 'admin', 'AdminRole/edit', 0, 'AdminRole 编辑'),
	(413, 'admin', 'AdminRole/delete', 0, 'AdminRole 默认删除操作'),
	(414, 'admin', 'AdminRole/recycle', 0, 'AdminRole 从回收站恢复'),
	(415, 'admin', 'AdminRole/forbid', 0, 'AdminRole 默认禁用操作'),
	(416, 'admin', 'AdminRole/resume', 0, 'AdminRole 默认恢复操作'),
	(417, 'admin', 'AdminRole/deleteForever', 0, 'AdminRole 永久删除'),
	(418, 'admin', 'AdminRole/clear', 0, 'AdminRole 清空回收站'),
	(422, 'admin', 'AdminUser/password', 0, 'AdminUser 修改密码'),
	(423, 'admin', 'AdminUser/index', 0, 'AdminUser 首页'),
	(424, 'admin', 'AdminUser/recycleBin', 0, 'AdminUser 回收站'),
	(425, 'admin', 'AdminUser/add', 0, 'AdminUser 添加'),
	(426, 'admin', 'AdminUser/edit', 0, '{:__user__}编辑用户{:id}'),
	(427, 'admin', 'AdminUser/recycle', 0, 'AdminUser 从回收站恢复'),
	(428, 'admin', 'AdminUser/forbid', 0, 'AdminUser 默认禁用操作'),
	(429, 'admin', 'AdminUser/resume', 0, 'AdminUser 默认恢复操作'),
	(437, 'admin', 'Demo/excel', 0, 'Demo Excel一键导出'),
	(438, 'admin', 'Demo/download', 0, 'Demo 下载文件'),
	(439, 'admin', 'Demo/downloadImage', 0, 'Demo 下载远程图片'),
	(440, 'admin', 'Demo/mail', 0, 'Demo 发送邮件'),
	(441, 'admin', 'Demo/ueditor', 0, 'Demo 百度编辑器'),
	(442, 'admin', 'Demo/qiniu', 0, 'Demo 七牛上传'),
	(443, 'admin', 'Demo/hashids', 0, 'Demo ID加密'),
	(444, 'admin', 'Demo/layer', 0, 'Demo 丰富弹层'),
	(445, 'admin', 'Demo/tableFixed', 0, 'Demo 表格溢出'),
	(446, 'admin', 'Demo/imageUpload', 0, 'Demo 图片上传回调'),
	(452, 'admin', 'Index/index', 0, 'Index '),
	(453, 'admin', 'Index/welcome', 0, 'Index 欢迎页'),
	(455, 'admin', 'LoginLog/index', 0, 'LoginLog 首页'),
	(456, 'admin', 'LoginLog/clear', 0, 'LoginLog 清空回收站'),
	(458, 'admin', 'NodeMap/load', 0, 'NodeMap 自动导入'),
	(459, 'admin', 'NodeMap/index', 0, 'NodeMap 首页'),
	(460, 'admin', 'NodeMap/add', 0, 'NodeMap 添加'),
	(461, 'admin', 'NodeMap/edit', 0, 'NodeMap 编辑'),
	(462, 'admin', 'NodeMap/deleteForever', 0, 'NodeMap 永久删除'),
	(465, 'admin', 'Pub/login', 0, 'Pub 用户登录页面'),
	(466, 'admin', 'Pub/loginFrame', 0, 'Pub 小窗口登录页面'),
	(468, 'admin', 'Pub/logout', 0, 'Pub 用户登出'),
	(469, 'admin', 'Pub/checkLogin', 0, 'Pub 登录检测'),
	(470, 'admin', 'Pub/password', 0, 'Pub 修改密码'),
	(471, 'admin', 'Pub/profile', 0, 'Pub 查看用户信息|修改资料'),
	(472, 'admin', 'Upload/index', 0, 'Upload '),
	(473, 'admin', 'Upload/upload', 0, 'Upload 文件上传'),
	(474, 'admin', 'Upload/remote', 0, 'Upload 远程图片抓取'),
	(475, 'admin', 'Upload/listImage', 0, 'Upload 图片列表'),
	(483, 'admin', 'WebLog/index', 0, 'WebLog '),
	(484, 'admin', 'WebLog/detail', 0, 'WebLog '),
	(486, 'admin', 'Pub/index', 0, 'Pub 首页'),
	(487, 'admin', 'AdminGroup/edit', 1, '{:__user__}编辑了分组管理{:id}修改名称为{:name}'),
	(488, 'admin', 'AdminUser/edit', 1, '{:__user__}编辑了用户{:id}，修改真实名字为{:realname}'),
	(489, 'admin', 'AdminNode/sort', 0, 'AdminNode 保存排序'),
	(490, 'admin', 'AdminNode/indexOld', 0, 'AdminNode 首页'),
	(492, 'admin', 'AdminUser/delete', 0, 'AdminUser 默认删除操作'),
	(493, 'admin', 'AdminUser/deleteForever', 0, 'AdminUser 永久删除'),
	(494, 'admin', 'AdminUser/clear', 0, 'AdminUser 清空回收站'),
	(495, 'admin', 'Demo/qrcode', 0, 'Demo 二维码生成'),
	(496, 'admin', 'NodeMap/recycleBin', 0, 'NodeMap 回收站'),
	(497, 'admin', 'Test/Index', 0, 'Test '),
	(498, 'admin', 'AdminActivity/index', 0, 'AdminActivity 首页'),
	(499, 'admin', 'AdminActivity/recycleBin', 0, 'AdminActivity 回收站'),
	(500, 'admin', 'AdminActivity/add', 0, 'AdminActivity 添加'),
	(501, 'admin', 'AdminActivity/edit', 0, 'AdminActivity @desc 编辑'),
	(502, 'admin', 'AdminActivity/delete', 0, 'AdminActivity 默认删除操作'),
	(503, 'admin', 'AdminActivity/recycle', 0, 'AdminActivity 从回收站恢复'),
	(504, 'admin', 'AdminActivity/forbid', 0, 'AdminActivity 默认禁用操作'),
	(505, 'admin', 'AdminActivity/resume', 0, 'AdminActivity 默认恢复操作'),
	(506, 'admin', 'AdminActivity/deleteForever', 0, 'AdminActivity 永久删除'),
	(507, 'admin', 'AdminActivity/clear', 0, 'AdminActivity 清空回收站'),
	(513, 'admin', 'Test/TestRedis', 0, 'Test @desc redis 测试使用'),
	(514, 'admin', 'Test/RouteRule', 0, 'Test '),
	(515, 'admin', 'AdminModel/index', 0, 'AdminModel 首页'),
	(516, 'admin', 'AdminModel/recycleBin', 0, 'AdminModel 回收站'),
	(517, 'admin', 'AdminModel/add', 0, 'AdminModel 添加'),
	(518, 'admin', 'AdminModel/edit', 0, 'AdminModel @desc 编辑'),
	(519, 'admin', 'AdminModel/delete', 0, 'AdminModel 默认删除操作'),
	(520, 'admin', 'AdminModel/recycle', 0, 'AdminModel 从回收站恢复'),
	(521, 'admin', 'AdminModel/forbid', 0, 'AdminModel 默认禁用操作'),
	(522, 'admin', 'AdminModel/resume', 0, 'AdminModel 默认恢复操作'),
	(523, 'admin', 'AdminModel/deleteForever', 0, 'AdminModel 永久删除'),
	(524, 'admin', 'AdminModel/clear', 0, 'AdminModel 清空回收站');
/*!40000 ALTER TABLE `zy_node_map` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_web_log_001 结构
CREATE TABLE IF NOT EXISTS `zy_web_log_001` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `uid` smallint(5) unsigned NOT NULL COMMENT '用户id',
  `ip` char(15) NOT NULL COMMENT '访客ip',
  `location` varchar(255) NOT NULL COMMENT '访客地址',
  `os` varchar(255) NOT NULL COMMENT '操作系统',
  `browser` varchar(255) NOT NULL COMMENT '浏览器',
  `url` varchar(255) NOT NULL COMMENT 'url',
  `module` char(6) NOT NULL COMMENT '模块',
  `map` varchar(255) NOT NULL COMMENT '节点图',
  `is_ajax` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是ajax请求',
  `data` text NOT NULL COMMENT '请求的param数据，serialize后的',
  `otime` int(10) unsigned NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `ip` (`ip`),
  KEY `map` (`map`),
  KEY `otime` (`otime`)
) ENGINE=MyISAM AUTO_INCREMENT=567 DEFAULT CHARSET=utf8 COMMENT='网站日志';

-- 正在导出表  zyadmin.zy_web_log_001 的数据：37 rows
/*!40000 ALTER TABLE `zy_web_log_001` DISABLE KEYS */;
INSERT INTO `zy_web_log_001` (`id`, `uid`, `ip`, `location`, `os`, `browser`, `url`, `module`, `map`, `is_ajax`, `data`, `otime`) VALUES
	(1, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_activity/index.html', 'admin', 'AdminActivity\\index', 0, 'a:0:{}', 1484041883),
	(2, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/login_log/index.html', 'admin', 'LoginLog\\index', 0, 'a:0:{}', 1484041901),
	(3, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/web_log/index.html', 'admin', 'WebLog\\index', 0, 'a:0:{}', 1484041906),
	(4, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/node_map/index.html', 'admin', 'NodeMap\\index', 0, 'a:0:{}', 1484041907),
	(5, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_user/index.html', 'admin', 'AdminUser\\index', 0, 'a:0:{}', 1484041907),
	(6, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_user/index.html', 'admin', 'AdminUser\\index', 0, 'a:0:{}', 1484041908),
	(7, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484041910),
	(8, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484041912),
	(9, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/login_log/index.html', 'admin', 'LoginLog\\index', 0, 'a:0:{}', 1484041961),
	(10, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/web_log/index.html', 'admin', 'WebLog\\index', 0, 'a:0:{}', 1484041965),
	(11, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/node_map/index.html', 'admin', 'NodeMap\\index', 0, 'a:0:{}', 1484041972),
	(12, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_user/index.html', 'admin', 'AdminUser\\index', 0, 'a:0:{}', 1484041973),
	(13, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_role/index.html', 'admin', 'AdminRole\\index', 0, 'a:0:{}', 1484041974),
	(14, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484041974),
	(15, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484041975),
	(16, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484042019),
	(17, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/login_log/index.html', 'admin', 'LoginLog\\index', 0, 'a:0:{}', 1484042029),
	(18, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/web_log/index.html', 'admin', 'WebLog\\index', 0, 'a:0:{}', 1484042031),
	(19, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/node_map/index.html', 'admin', 'NodeMap\\index', 0, 'a:0:{}', 1484042033),
	(20, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_user/index.html', 'admin', 'AdminUser\\index', 0, 'a:0:{}', 1484042034),
	(21, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_role/index.html', 'admin', 'AdminRole\\index', 0, 'a:0:{}', 1484042037),
	(22, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042039),
	(23, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_user/index.html', 'admin', 'AdminUser\\index', 0, 'a:0:{}', 1484042053),
	(24, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484042055),
	(25, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/edit/id/3.html', 'admin', 'AdminGroup\\edit', 0, 'a:1:{s:2:"id";s:1:"3";}', 1484042057),
	(26, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/edit/id/3.html', 'admin', 'AdminGroup\\edit', 1, 'a:6:{s:2:"id";s:1:"3";s:4:"name";s:12:"后台管理";s:4:"icon";s:7:"&#xe63c";s:4:"sort";s:1:"3";s:6:"status";s:1:"1";s:6:"remark";s:12:"后台管理";}', 1484042081),
	(27, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484042081),
	(28, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_activity/index.html', 'admin', 'AdminActivity\\index', 0, 'a:0:{}', 1484042086),
	(29, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484042089),
	(30, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042091),
	(31, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484042107),
	(32, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042108),
	(33, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/edit.html?id=2', 'admin', 'AdminNode\\edit', 0, 'a:1:{s:2:"id";s:1:"2";}', 1484042113),
	(34, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/add.html?pid=1', 'admin', 'AdminNode\\add', 0, 'a:1:{s:3:"pid";s:1:"1";}', 1484042126),
	(35, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/add.html', 'admin', 'AdminNode\\add', 1, 'a:9:{s:2:"id";s:0:"";s:3:"pid";s:1:"1";s:5:"level";s:1:"2";s:8:"group_id";s:1:"3";s:5:"title";s:12:"模型管理";s:4:"name";s:10:"AdminModel";s:4:"type";s:1:"1";s:4:"sort";s:2:"50";s:6:"status";s:1:"1";}', 1484042144),
	(36, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042144),
	(37, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_model/index.html', 'admin', 'AdminModel\\index', 0, 'a:0:{}', 1484042149),
	(38, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_model/index.html', 'admin', 'AdminModel\\index', 0, 'a:0:{}', 1484042263),
	(39, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_group/index.html', 'admin', 'AdminGroup\\index', 0, 'a:0:{}', 1484042271),
	(40, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042272),
	(41, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/edit.html?id=51', 'admin', 'AdminNode\\edit', 0, 'a:1:{s:2:"id";s:2:"51";}', 1484042288),
	(42, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/add.html?pid=66', 'admin', 'AdminNode\\add', 0, 'a:1:{s:3:"pid";s:2:"66";}', 1484042294),
	(43, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/add.html', 'admin', 'AdminNode\\add', 1, 'a:9:{s:2:"id";s:0:"";s:3:"pid";s:2:"66";s:5:"level";s:1:"3";s:8:"group_id";s:1:"0";s:5:"title";s:6:"首页";s:4:"name";s:5:"index";s:4:"type";s:1:"1";s:4:"sort";s:2:"50";s:6:"status";s:1:"1";}', 1484042303),
	(44, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042303),
	(45, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/edit.html?id=53', 'admin', 'AdminNode\\edit', 0, 'a:1:{s:2:"id";s:2:"53";}', 1484042309),
	(46, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/add.html?pid=66', 'admin', 'AdminNode\\add', 0, 'a:1:{s:3:"pid";s:2:"66";}', 1484042318),
	(47, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/add.html', 'admin', 'AdminNode\\add', 1, 'a:9:{s:2:"id";s:0:"";s:3:"pid";s:2:"66";s:5:"level";s:1:"3";s:8:"group_id";s:1:"0";s:5:"title";s:6:"编辑";s:4:"name";s:4:"edit";s:4:"type";s:1:"1";s:4:"sort";s:2:"50";s:6:"status";s:1:"1";}', 1484042325),
	(48, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042326),
	(49, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/edit.html?id=32', 'admin', 'AdminNode\\edit', 0, 'a:1:{s:2:"id";s:2:"32";}', 1484042333),
	(50, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/edit.html', 'admin', 'AdminNode\\edit', 1, 'a:9:{s:2:"id";s:2:"32";s:3:"pid";s:1:"9";s:5:"level";s:1:"3";s:8:"group_id";s:1:"0";s:5:"title";s:6:"首页";s:4:"name";s:5:"index";s:4:"type";s:1:"0";s:4:"sort";s:2:"50";s:6:"status";s:1:"1";}', 1484042335),
	(51, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042336),
	(52, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/edit.html?id=68', 'admin', 'AdminNode\\edit', 0, 'a:1:{s:2:"id";s:2:"68";}', 1484042344),
	(53, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/edit.html', 'admin', 'AdminNode\\edit', 1, 'a:9:{s:2:"id";s:2:"68";s:3:"pid";s:2:"66";s:5:"level";s:1:"3";s:8:"group_id";s:1:"0";s:5:"title";s:6:"编辑";s:4:"name";s:4:"edit";s:4:"type";s:1:"0";s:4:"sort";s:2:"50";s:6:"status";s:1:"1";}', 1484042347),
	(54, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_node/index.html', 'admin', 'AdminNode\\index', 0, 'a:0:{}', 1484042347),
	(55, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_model/index.html', 'admin', 'AdminModel\\index', 0, 'a:0:{}', 1484042350),
	(56, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_model/add.html', 'admin', 'AdminModel\\add', 0, 'a:0:{}', 1484042351),
	(57, 1, '127.0.0.1', '本机地址 本机地址  ', 'Windows 7', 'Chrome(51.0.2704.84)', '/admin/public/index.php/admin/admin_model/index.html?', 'admin', 'AdminModel\\index', 0, 'a:0:{}', 1484042354);
/*!40000 ALTER TABLE `zy_web_log_001` ENABLE KEYS */;

-- 导出  表 zyadmin.zy_web_log_all 结构
CREATE TABLE IF NOT EXISTS `zy_web_log_all` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `uid` smallint(5) unsigned NOT NULL COMMENT '用户id',
  `ip` char(15) NOT NULL COMMENT '访客ip',
  `location` varchar(255) NOT NULL COMMENT '访客地址',
  `os` varchar(255) NOT NULL COMMENT '操作系统',
  `browser` varchar(255) NOT NULL COMMENT '浏览器',
  `url` varchar(255) NOT NULL COMMENT 'url',
  `module` char(6) NOT NULL COMMENT '模块',
  `map` varchar(255) NOT NULL COMMENT '节点图',
  `is_ajax` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是ajax请求',
  `data` text NOT NULL COMMENT '请求的param数据，serialize后的',
  `otime` int(10) unsigned NOT NULL COMMENT '操作时间',
  KEY `id` (`id`),
  KEY `uid` (`uid`),
  KEY `ip` (`ip`),
  KEY `map` (`map`),
  KEY `otime` (`otime`)
) ENGINE=MRG_MyISAM DEFAULT CHARSET=utf8 INSERT_METHOD=LAST UNION=(`zy_web_log_001`);

-- Table data not exported because this is MRG_MYISAM table which holds its data in separate tables.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
