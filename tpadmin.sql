/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50631
Source Host           : localhost:3306
Source Database       : tpadmin

Target Server Type    : MYSQL
Target Server Version : 50631
File Encoding         : 65001

Date: 2016-10-27 15:43:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for zy_admin_access
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_access`;
CREATE TABLE `zy_admin_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `node_id` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  KEY `groupId` (`role_id`),
  KEY `nodeId` (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of zy_admin_access
-- ----------------------------

-- ----------------------------
-- Table structure for zy_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_group`;
CREATE TABLE `zy_admin_group` (
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of zy_admin_group
-- ----------------------------
INSERT INTO `zy_admin_group` VALUES ('1', '系统管理', '&#xe61d;', '1', '1', '', '0', '1450752856', '1475768760');
INSERT INTO `zy_admin_group` VALUES ('2', '示例', '&#xe616;', '2', '1', '', '0', '1476016712', '1476017769');

-- ----------------------------
-- Table structure for zy_admin_node
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_node`;
CREATE TABLE `zy_admin_node` (
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
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of zy_admin_node
-- ----------------------------
INSERT INTO `zy_admin_node` VALUES ('1', '0', '1', 'Admin', '后台管理', '后台管理，不可更改', '1', '1', '1', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('2', '1', '1', 'AdminGroup', '分组管理', ' ', '2', '1', '1', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('3', '1', '1', 'AdminNode', '节点管理', ' ', '2', '1', '2', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('4', '1', '1', 'AdminRole', '角色管理', ' ', '2', '1', '3', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('5', '1', '1', 'AdminUser', '用户管理', '', '2', '1', '4', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('6', '1', '0', 'Index', '首页', '', '2', '1', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('7', '6', '0', 'welcome', '欢迎页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('8', '6', '0', 'index', '未定义', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('9', '1', '2', 'Generate', '代码自动生成', '', '2', '1', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('10', '1', '2', 'Demo/excel', 'Excel一键导出', '', '2', '0', '2', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('11', '1', '2', 'Demo/download', '下载', '', '2', '0', '3', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('12', '1', '2', 'Demo/downloadImage', '远程图片下载', '', '2', '0', '4', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('13', '1', '2', 'Demo/mail', '邮件发送', '', '2', '0', '5', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('14', '1', '2', 'Demo/qiniu', '七牛上传', '', '2', '0', '6', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('15', '1', '2', 'Demo/hashids', 'ID加密', '', '2', '0', '7', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('16', '1', '2', 'Demo/layer', '丰富弹层', '', '2', '0', '8', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('17', '1', '2', 'Demo/tableFixed', '表格溢出', '', '2', '0', '9', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('18', '1', '2', 'Demo/ueditor', '百度编辑器', '', '2', '0', '10', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('19', '1', '2', 'Demo/imageUpload', '图片上传', '', '2', '0', '11', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('20', '1', '2', 'Demo/qrcode', '二维码生成', '', '2', '0', '12', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('21', '1', '1', 'NodeMap', '节点图', '', '2', '1', '5', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('22', '1', '1', 'WebLog', '操作日志', '', '2', '1', '6', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('23', '1', '1', 'LoginLog', '登录日志', '', '2', '1', '7', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('24', '23', '0', 'index', '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('25', '22', '0', 'index', '列表', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('26', '22', '0', 'detail', '详情', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('27', '21', '0', 'load', '自动导入', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('28', '21', '0', 'index', '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('29', '21', '0', 'add', '添加', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('30', '21', '0', 'edit', '编辑', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('31', '21', '0', 'deleteForever', '永久删除', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('32', '9', '0', 'index', '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('33', '9', '0', 'generate', '生成方法', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('34', '5', '0', 'password', '修改密码', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('35', '5', '0', 'index', '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('36', '5', '0', 'add', '添加', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('37', '5', '0', 'edit', '编辑', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('38', '4', '0', 'user', '用户列表', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('39', '4', '0', 'access', '授权', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('40', '4', '0', 'index', '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('41', '4', '0', 'add', '添加', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('42', '4', '0', 'edit', '编辑', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('43', '4', '0', 'forbid', '默认禁用操作', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('44', '4', '0', 'resume', '默认恢复操作', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('45', '3', '0', 'load', '节点快速导入', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('46', '3', '0', 'index', '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('47', '3', '0', 'add', '添加', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('48', '3', '0', 'edit', '编辑', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('49', '3', '0', 'forbid', '默认禁用操作', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('50', '3', '0', 'resume', '默认恢复操作', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('51', '2', '0', 'index', '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('52', '2', '0', 'add', '添加', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('53', '2', '0', 'edit', '编辑', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('54', '2', '0', 'forbid', '默认禁用操作', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('55', '2', '0', 'resume', '默认恢复操作', '', '3', '0', '50', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('56', '1', '2', 'one', '多级菜单演示', '', '2', '1', '13', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('57', '56', '2', 'two', '三级菜单', '', '3', '1', '1', '1', '0');
INSERT INTO `zy_admin_node` VALUES ('58', '57', '2', 'three', '四级菜单', '', '4', '0', '1', '1', '0');

-- ----------------------------
-- Table structure for zy_admin_node_load
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_node_load`;
CREATE TABLE `zy_admin_node_load` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='节点快速导入';

-- ----------------------------
-- Records of zy_admin_node_load
-- ----------------------------
INSERT INTO `zy_admin_node_load` VALUES ('4', '编辑', 'edit', '1');
INSERT INTO `zy_admin_node_load` VALUES ('5', '添加', 'add', '1');
INSERT INTO `zy_admin_node_load` VALUES ('6', '首页', 'index', '1');
INSERT INTO `zy_admin_node_load` VALUES ('7', '删除', 'delete', '1');

-- ----------------------------
-- Table structure for zy_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_role`;
CREATE TABLE `zy_admin_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(6) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态0禁用',
  `isdelete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`),
  KEY `isdelete` (`isdelete`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of zy_admin_role
-- ----------------------------
INSERT INTO `zy_admin_role` VALUES ('1', '0', '领导组', ' ', '1', '0', '1208784792', '1254325558');
INSERT INTO `zy_admin_role` VALUES ('2', '0', '网编组', ' ', '1', '0', '1215496283', '1454049929');

-- ----------------------------
-- Table structure for zy_admin_role_user
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_role_user`;
CREATE TABLE `zy_admin_role_user` (
  `role_id` mediumint(9) unsigned DEFAULT NULL,
  `user_id` char(32) DEFAULT NULL,
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of zy_admin_role_user
-- ----------------------------
INSERT INTO `zy_admin_role_user` VALUES ('1', '2');

-- ----------------------------
-- Table structure for zy_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_user`;
CREATE TABLE `zy_admin_user` (
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of zy_admin_user
-- ----------------------------
INSERT INTO `zy_admin_user` VALUES ('1', 'admin', '超级管理员', 'e10adc3949ba59abbe56e057f20f883e', '1477535788', '127.0.0.1', '330', 'tianpian0805@gmail.com', '13121126169', '我是超级管理员', '1', '0', '1222907803', '1451033528');
INSERT INTO `zy_admin_user` VALUES ('2', 'demo', '测试', 'e10adc3949ba59abbe56e057f20f883e', '1477404006', '127.0.0.1', '2', '', '', '', '1', '0', '1476777133', '1477399793');

-- ----------------------------
-- Table structure for zy_file
-- ----------------------------
DROP TABLE IF EXISTS `zy_file`;
CREATE TABLE `zy_file` (
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

-- ----------------------------
-- Records of zy_file
-- ----------------------------

-- ----------------------------
-- Table structure for zy_login_log
-- ----------------------------
DROP TABLE IF EXISTS `zy_login_log`;
CREATE TABLE `zy_login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) unsigned NOT NULL,
  `login_ip` char(15) NOT NULL,
  `login_location` varchar(255) NOT NULL,
  `login_browser` varchar(255) NOT NULL,
  `login_os` varchar(255) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=659 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zy_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for zy_node_map
-- ----------------------------
DROP TABLE IF EXISTS `zy_node_map`;
CREATE TABLE `zy_node_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` char(6) NOT NULL COMMENT '模块',
  `map` varchar(255) NOT NULL COMMENT '节点图',
  `is_ajax` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是ajax请求',
  `comment` varchar(255) NOT NULL COMMENT '节点图描述',
  PRIMARY KEY (`id`),
  KEY `map` (`map`)
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点图';

-- ----------------------------
-- Records of zy_node_map
-- ----------------------------
INSERT INTO `zy_node_map` VALUES ('362', 'admin', 'AdminGroup/index', '0', 'AdminGroup 首页');
INSERT INTO `zy_node_map` VALUES ('363', 'admin', 'AdminGroup/recycleBin', '0', 'AdminGroup 回收站');
INSERT INTO `zy_node_map` VALUES ('364', 'admin', 'AdminGroup/add', '0', 'AdminGroup 添加');
INSERT INTO `zy_node_map` VALUES ('365', 'admin', 'AdminGroup/edit', '0', '{:__user__}编辑分组管理');
INSERT INTO `zy_node_map` VALUES ('366', 'admin', 'AdminGroup/delete', '0', 'AdminGroup 默认删除操作');
INSERT INTO `zy_node_map` VALUES ('367', 'admin', 'AdminGroup/recycle', '0', 'AdminGroup 从回收站恢复');
INSERT INTO `zy_node_map` VALUES ('368', 'admin', 'AdminGroup/forbid', '0', 'AdminGroup 默认禁用操作');
INSERT INTO `zy_node_map` VALUES ('369', 'admin', 'AdminGroup/resume', '0', 'AdminGroup 默认恢复操作');
INSERT INTO `zy_node_map` VALUES ('370', 'admin', 'AdminGroup/deleteForever', '0', 'AdminGroup 永久删除');
INSERT INTO `zy_node_map` VALUES ('371', 'admin', 'AdminGroup/clear', '0', 'AdminGroup 清空回收站');
INSERT INTO `zy_node_map` VALUES ('377', 'admin', 'AdminNode/load', '0', 'AdminNode 节点快速导入');
INSERT INTO `zy_node_map` VALUES ('378', 'admin', 'AdminNode/index', '0', 'AdminNode 首页');
INSERT INTO `zy_node_map` VALUES ('379', 'admin', 'AdminNode/recycleBin', '0', 'AdminNode 回收站');
INSERT INTO `zy_node_map` VALUES ('380', 'admin', 'AdminNode/add', '0', 'AdminNode 添加');
INSERT INTO `zy_node_map` VALUES ('381', 'admin', 'AdminNode/edit', '0', 'AdminNode 编辑');
INSERT INTO `zy_node_map` VALUES ('382', 'admin', 'AdminNode/delete', '0', 'AdminNode 默认删除操作');
INSERT INTO `zy_node_map` VALUES ('383', 'admin', 'AdminNode/recycle', '0', 'AdminNode 从回收站恢复');
INSERT INTO `zy_node_map` VALUES ('384', 'admin', 'AdminNode/forbid', '0', 'AdminNode 默认禁用操作');
INSERT INTO `zy_node_map` VALUES ('385', 'admin', 'AdminNode/resume', '0', 'AdminNode 默认恢复操作');
INSERT INTO `zy_node_map` VALUES ('386', 'admin', 'AdminNode/deleteForever', '0', 'AdminNode 永久删除');
INSERT INTO `zy_node_map` VALUES ('387', 'admin', 'AdminNode/clear', '0', 'AdminNode 清空回收站');
INSERT INTO `zy_node_map` VALUES ('392', 'admin', 'AdminNodeLoad/index', '0', 'AdminNodeLoad 首页');
INSERT INTO `zy_node_map` VALUES ('393', 'admin', 'AdminNodeLoad/recycleBin', '0', 'AdminNodeLoad 回收站');
INSERT INTO `zy_node_map` VALUES ('394', 'admin', 'AdminNodeLoad/add', '0', 'AdminNodeLoad 添加');
INSERT INTO `zy_node_map` VALUES ('395', 'admin', 'AdminNodeLoad/edit', '0', 'AdminNodeLoad 编辑');
INSERT INTO `zy_node_map` VALUES ('396', 'admin', 'AdminNodeLoad/forbid', '0', 'AdminNodeLoad 默认禁用操作');
INSERT INTO `zy_node_map` VALUES ('397', 'admin', 'AdminNodeLoad/resume', '0', 'AdminNodeLoad 默认恢复操作');
INSERT INTO `zy_node_map` VALUES ('398', 'admin', 'AdminNodeLoad/deleteForever', '0', 'AdminNodeLoad 永久删除');
INSERT INTO `zy_node_map` VALUES ('399', 'admin', 'AdminNodeLoad/clear', '0', 'AdminNodeLoad 清空回收站');
INSERT INTO `zy_node_map` VALUES ('407', 'admin', 'AdminRole/user', '0', 'AdminRole 用户列表');
INSERT INTO `zy_node_map` VALUES ('408', 'admin', 'AdminRole/access', '0', 'AdminRole 授权');
INSERT INTO `zy_node_map` VALUES ('409', 'admin', 'AdminRole/index', '0', 'AdminRole 首页');
INSERT INTO `zy_node_map` VALUES ('410', 'admin', 'AdminRole/recycleBin', '0', 'AdminRole 回收站');
INSERT INTO `zy_node_map` VALUES ('411', 'admin', 'AdminRole/add', '0', 'AdminRole 添加');
INSERT INTO `zy_node_map` VALUES ('412', 'admin', 'AdminRole/edit', '0', 'AdminRole 编辑');
INSERT INTO `zy_node_map` VALUES ('413', 'admin', 'AdminRole/delete', '0', 'AdminRole 默认删除操作');
INSERT INTO `zy_node_map` VALUES ('414', 'admin', 'AdminRole/recycle', '0', 'AdminRole 从回收站恢复');
INSERT INTO `zy_node_map` VALUES ('415', 'admin', 'AdminRole/forbid', '0', 'AdminRole 默认禁用操作');
INSERT INTO `zy_node_map` VALUES ('416', 'admin', 'AdminRole/resume', '0', 'AdminRole 默认恢复操作');
INSERT INTO `zy_node_map` VALUES ('417', 'admin', 'AdminRole/deleteForever', '0', 'AdminRole 永久删除');
INSERT INTO `zy_node_map` VALUES ('418', 'admin', 'AdminRole/clear', '0', 'AdminRole 清空回收站');
INSERT INTO `zy_node_map` VALUES ('422', 'admin', 'AdminUser/password', '0', 'AdminUser 修改密码');
INSERT INTO `zy_node_map` VALUES ('423', 'admin', 'AdminUser/index', '0', 'AdminUser 首页');
INSERT INTO `zy_node_map` VALUES ('424', 'admin', 'AdminUser/recycleBin', '0', 'AdminUser 回收站');
INSERT INTO `zy_node_map` VALUES ('425', 'admin', 'AdminUser/add', '0', 'AdminUser 添加');
INSERT INTO `zy_node_map` VALUES ('426', 'admin', 'AdminUser/edit', '0', '{:__user__}编辑用户{:id}');
INSERT INTO `zy_node_map` VALUES ('427', 'admin', 'AdminUser/recycle', '0', 'AdminUser 从回收站恢复');
INSERT INTO `zy_node_map` VALUES ('428', 'admin', 'AdminUser/forbid', '0', 'AdminUser 默认禁用操作');
INSERT INTO `zy_node_map` VALUES ('429', 'admin', 'AdminUser/resume', '0', 'AdminUser 默认恢复操作');
INSERT INTO `zy_node_map` VALUES ('437', 'admin', 'Demo/excel', '0', 'Demo Excel一键导出');
INSERT INTO `zy_node_map` VALUES ('438', 'admin', 'Demo/download', '0', 'Demo 下载文件');
INSERT INTO `zy_node_map` VALUES ('439', 'admin', 'Demo/downloadImage', '0', 'Demo 下载远程图片');
INSERT INTO `zy_node_map` VALUES ('440', 'admin', 'Demo/mail', '0', 'Demo 发送邮件');
INSERT INTO `zy_node_map` VALUES ('441', 'admin', 'Demo/ueditor', '0', 'Demo 百度编辑器');
INSERT INTO `zy_node_map` VALUES ('442', 'admin', 'Demo/qiniu', '0', 'Demo 七牛上传');
INSERT INTO `zy_node_map` VALUES ('443', 'admin', 'Demo/hashids', '0', 'Demo ID加密');
INSERT INTO `zy_node_map` VALUES ('444', 'admin', 'Demo/layer', '0', 'Demo 丰富弹层');
INSERT INTO `zy_node_map` VALUES ('445', 'admin', 'Demo/tableFixed', '0', 'Demo 表格溢出');
INSERT INTO `zy_node_map` VALUES ('446', 'admin', 'Demo/imageUpload', '0', 'Demo 图片上传回调');
INSERT INTO `zy_node_map` VALUES ('452', 'admin', 'Index/index', '0', 'Index ');
INSERT INTO `zy_node_map` VALUES ('453', 'admin', 'Index/welcome', '0', 'Index 欢迎页');
INSERT INTO `zy_node_map` VALUES ('455', 'admin', 'LoginLog/index', '0', 'LoginLog 首页');
INSERT INTO `zy_node_map` VALUES ('456', 'admin', 'LoginLog/clear', '0', 'LoginLog 清空回收站');
INSERT INTO `zy_node_map` VALUES ('458', 'admin', 'NodeMap/load', '0', 'NodeMap 自动导入');
INSERT INTO `zy_node_map` VALUES ('459', 'admin', 'NodeMap/index', '0', 'NodeMap 首页');
INSERT INTO `zy_node_map` VALUES ('460', 'admin', 'NodeMap/add', '0', 'NodeMap 添加');
INSERT INTO `zy_node_map` VALUES ('461', 'admin', 'NodeMap/edit', '0', 'NodeMap 编辑');
INSERT INTO `zy_node_map` VALUES ('462', 'admin', 'NodeMap/deleteForever', '0', 'NodeMap 永久删除');
INSERT INTO `zy_node_map` VALUES ('465', 'admin', 'Pub/login', '0', 'Pub 用户登录页面');
INSERT INTO `zy_node_map` VALUES ('466', 'admin', 'Pub/loginFrame', '0', 'Pub 小窗口登录页面');
INSERT INTO `zy_node_map` VALUES ('468', 'admin', 'Pub/logout', '0', 'Pub 用户登出');
INSERT INTO `zy_node_map` VALUES ('469', 'admin', 'Pub/checkLogin', '0', 'Pub 登录检测');
INSERT INTO `zy_node_map` VALUES ('470', 'admin', 'Pub/password', '0', 'Pub 修改密码');
INSERT INTO `zy_node_map` VALUES ('471', 'admin', 'Pub/profile', '0', 'Pub 查看用户信息|修改资料');
INSERT INTO `zy_node_map` VALUES ('472', 'admin', 'Upload/index', '0', 'Upload ');
INSERT INTO `zy_node_map` VALUES ('473', 'admin', 'Upload/upload', '0', 'Upload 文件上传');
INSERT INTO `zy_node_map` VALUES ('474', 'admin', 'Upload/remote', '0', 'Upload 远程图片抓取');
INSERT INTO `zy_node_map` VALUES ('475', 'admin', 'Upload/listImage', '0', 'Upload 图片列表');
INSERT INTO `zy_node_map` VALUES ('483', 'admin', 'WebLog/index', '0', 'WebLog ');
INSERT INTO `zy_node_map` VALUES ('484', 'admin', 'WebLog/detail', '0', 'WebLog ');
INSERT INTO `zy_node_map` VALUES ('486', 'admin', 'Pub/index', '0', 'Pub 首页');
INSERT INTO `zy_node_map` VALUES ('487', 'admin', 'AdminGroup/edit', '1', '{:__user__}编辑了分组管理{:id}修改名称为{:name}');
INSERT INTO `zy_node_map` VALUES ('488', 'admin', 'AdminUser/edit', '1', '{:__user__}编辑了用户{:id}，修改真实名字为{:realname}');

-- ----------------------------
-- Table structure for zy_web_log_001
-- ----------------------------
DROP TABLE IF EXISTS `zy_web_log_001`;
CREATE TABLE `zy_web_log_001` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='网站日志';

-- ----------------------------
-- Records of zy_web_log_001
-- ----------------------------

-- ----------------------------
-- Table structure for zy_web_log_all
-- ----------------------------
DROP TABLE IF EXISTS `zy_web_log_all`;
CREATE TABLE `zy_web_log_all` (
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

-- ----------------------------
-- Records of zy_web_log_all
-- ----------------------------

-- ----------------------------
-- Table structure for zy_admin_activity
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_activity`;
CREATE TABLE `zy_admin_activity` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动'

-- ----------------------------
-- Records of zy_admin_activity
-- ----------------------------

-- ----------------------------
-- Table structure for zy_admin_model
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_model`;
CREATE TABLE `zy_admin_model` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(30) NOT NULL COMMENT '模型名称',
  `description` char(100) NOT NULL COMMENT '关于模型的描述',
  `tablename` char(20) NOT NULL COMMENT '模型的表',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '模型是否启用',
  `sort` tinyint(3) NOT NULL COMMENT '排序',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
CREATE TABLE `zy_admin_model` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT comment '模型ID 自增',
  `name` varchar(30) NOT NULL comment '名称',
  `description` varchar(100) NOT NULL comment '描述',
  `tablename` varchar(30) NOT NULL comment '表名称',
  `setting` text NOT NULL comment '设置相关信息',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' comment '是否可用',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' comment '添加时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' comment '更新时间',
  PRIMARY KEY (`id`), 
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
-- ----------------------------
-- Records of zy_admin_model
-- ----------------------------

-- ----------------------------
-- Table structure for zy_admin_model_field
-- ----------------------------
DROP TABLE IF EXISTS `zy_admin_model_field`;
CREATE TABLE `zy_admin_model_field` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT comment 'Primary key',
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0' comment '模型ID',
  `field` varchar(20) NOT NULL comment '字段',
  `name` varchar(30) NOT NULL comment '名称',
  `tips` text NOT NULL comment '描述',
  `css` varchar(30) NOT NULL comment '样式',
  `minlength` int(10) unsigned NOT NULL DEFAULT '0' comment '最小长度',
  `maxlength` int(10) unsigned NOT NULL DEFAULT '0' comment '最大长度',
  `pattern` varchar(255) NOT NULL comment '正则过滤',
  `errortips` varchar(255) NOT NULL comment '错误提示',
  `formtype` varchar(20) NOT NULL comment '显示格式字段类型',
  `setting` mediumtext NOT NULL,
  `formattribute` varchar(255) NOT NULL,
  `unsetgroupids` varchar(255) NOT NULL,
  `unsetroleids` varchar(255) NOT NULL,
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issystem` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isunique` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isbase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isfulltext` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isposition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `listorder` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' comment '是否可用',
  PRIMARY KEY (`id`),
  KEY `modelid` (`modelid`,`disabled`),
  KEY `field` (`field`,`modelid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
-- ----------------------------
-- Records of zy_admin_model_field
-- ----------------------------
