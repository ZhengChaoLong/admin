<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:69:"E:\www\tpAdmin\public/../application/admin\view\admin_node\index.html";i:1480493942;s:66:"E:\www\tpAdmin\public/../application/admin\view\template\base.html";i:1480493942;}*/ ?>
﻿<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="Bookmark" href="__ROOT__/favicon.ico" >
    <link rel="Shortcut Icon" href="__ROOT__/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="__LIB__/html5.js"></script>
    <script type="text/javascript" src="__LIB__/respond.min.js"></script>
    <script type="text/javascript" src="__LIB__/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="__LIB__/Hui-iconfont/1.0.7/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="__LIB__/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui.admin/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/css/app.css"/>
    <link rel="stylesheet" type="text/css" href="__LIB__/icheck/icheck.css"/>
    
<link rel="stylesheet" href="__LIB__/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<style type="text/css">
    div#rMenu {
        position: absolute;
        visibility: hidden;
        top: 0;
        background-color: #555;
        text-align: left;
        padding: 2px;
    }

    div#rMenu ul li {
        margin: 1px 0;
        padding: 0 5px;
        cursor: pointer;
        list-style: none outside none;
        background-color: #DFDFDF;
    }
</style>

    <!--[if IE 6]>
    <script type="text/javascript" src="__LIB__/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title><?php echo \think\Config::get('site.title'); ?></title>
</head>
<body>

<nav class="breadcrumb">
    <div id="nav-title"></div>
    <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:;" onclick="location.replace(location.href);" title="刷新"><i class="Hui-iconfont"></i></a>
</nav>


<!--
  ~ tpAdmin [a web admin based ThinkPHP5]
  ~
  ~ @author yuan1994 <tianpian0805@gmail.com>
  ~ @link http://tpadmin.yuan1994.com/
  ~ @copyright 2016 yuan1994 all rights reserved.
  ~ @license http://www.apache.org/licenses/LICENSE-2.0
  -->

<div class="page-container">
    <div class="cl pd-5 bg-1 bk-gray">
        <span class="l">
            <?php if (\Rbac::AccessCheck('add', 'AdminNode', 'admin')) : ?>
            <a class="btn btn-primary radius J_add" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加</a>
            <?php endif; if (\Rbac::AccessCheck('forbid', 'AdminNode', 'admin')) : ?>
            <a href="javascript:;" onclick="treeOpAll('<?php echo \think\Url::build('forbid'); ?>', '禁用')"
               class="btn btn-warning radius ml-5"><i class="Hui-iconfont">&#xe631;</i> 禁用</a>
            <?php endif; if (\Rbac::AccessCheck('resume', 'AdminNode', 'admin')) : ?>
            <a href="javascript:;" onclick="treeOpAll('<?php echo \think\Url::build('resume'); ?>', '恢复')"
               class="btn btn-success radius ml-5"><i class="Hui-iconfont">&#xe615;</i> 恢复</a>
            <?php endif; if (\Rbac::AccessCheck('delete', 'AdminNode', 'admin')) : ?>
            <a href="javascript:;" onclick="treeOpAll('<?php echo \think\Url::build('delete'); ?>', '删除')"
               class="btn btn-danger radius ml-5"><i class="Hui-iconfont">&#xe6e2;</i> 删除</a>
            <?php endif; if (\Rbac::AccessCheck('recyclebin')) : ?><a href="javascript:;" onclick="open_window('回收站','<?php echo \think\Url::build('recyclebin', []); ?>')" class="btn btn-secondary radius mr-5"><i class="Hui-iconfont">&#xe6b9;</i> 回收站</a><?php endif; if (\Rbac::AccessCheck('load', 'AdminNode', 'admin')) : ?>
            <a href="javascript:;" class="btn btn-primary radius J_load"><i class="Hui-iconfont">&#xe645;</i> 批量导入</a>
            <?php endif; ?>
        </span>
        <span class="r pt-5 pr-5">
            共有数据 ：<strong><?php echo $count; ?></strong> 条
        </span>
    </div>
    <div class="zTreeDemoBackground left">
        <ul id="tree" class="ztree"></ul>
    </div>
</div>
<div id="rMenu">
    <ul>
        <li class="J_add" onclick="hideRMenu();">添加节点</li>
        <li onclick="hideRMenu();onEditName('tree', zTree.getSelectedNodes()[0]);">编辑节点</li>
        <li onclick="hideRMenu();onRemove('tree', zTree.getSelectedNodes()[0]);">删除节点</li>
        <li onclick="checkTreeNode(true);">选中节点</li>
        <li onclick="checkTreeNode(false);">取消选择</li>
    </ul>
</div>

<script type="text/javascript" src="__LIB__/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="__LIB__/layer/2.4/layer.js"></script>
<script type="text/javascript" src="__STATIC__/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="__STATIC__/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="__STATIC__/js/app.js"></script>
<script type="text/javascript" src="__LIB__/icheck/jquery.icheck.min.js"></script>

<script type="text/javascript" src="__LIB__/zTree/js/jquery.ztree.all.js"></script>
<script type="text/javascript">
    var zTree, rMenu, treeId = 'tree';
    var setting = {
        edit: {
            drag: {
                autoExpandTrigger: true,
                prev: true,
                inner: true,
                next: true
            },
            enable: true,
            editNameSelectAll: true,
            showRemoveBtn: true,
            removeTitle: '删除节点',
            showRenameBtn: true,
            renameTitle: '编辑节点'
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onDrop: onDrop,
            onRightClick: OnRightClick,
            beforeEditName: onEditName,
            beforeRemove: onRemove
        },
        view: {
            nameIsHTML: true,
            showTitle: false,
            selectedMulti: false
        },
        check: {
            enable: true,
            chkboxType: {"Y": "", "N": ""}
        }
    };

    $(document).on('click', '.J_add', function () {
        var id = $(this).attr('data-id')
                || (zTree.getSelectedNodes()[0] ? zTree.getSelectedNodes()[0].id : undefined)
                || (zTree.getCheckedNodes()[0] ? zTree.getCheckedNodes()[0].id : undefined)
                || '0';
        layer_open('添加', '<?php echo \think\Url::build("add"); ?>?pid=' + id);
        return false;
    }).on('click', '.J_load', function () {
        var id = $(this).attr('data-id')
                || (zTree.getSelectedNodes()[0] ? zTree.getSelectedNodes()[0].id : undefined)
                || (zTree.getCheckedNodes()[0] ? zTree.getCheckedNodes()[0].id : undefined)
                || '0';
        layer_open('批量导入', '<?php echo \think\Url::build("load"); ?>?pid=' + id);
    });
    // 编辑节点
    function onEditName(treeId, treeNode) {
        layer_open('编辑', '<?php echo \think\Url::build("edit"); ?>?id=' + treeNode.id);
        return false;
    }
    // 删除节点
    function onRemove(treeId, treeNode) {
        del('', treeNode.id, '<?php echo \think\Url::build("delete"); ?>', function (data) {
            if (!data.code) {
                zTree.removeNode(treeNode);
            }
        });
        return false;
    }
    // 拖拽排序
    function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
        var data = {'id': treeNodes[0].id, 'pid': treeNodes[0].pId, 'level': parseInt(treeNodes[0].level) + 1};
        var prev = treeNodes[0].getPreNode();
        if (typeof prev == 'undefined' || typeof prev.sort == 'undefined') {
            data['sort'] = 0;
        } else {
            data['sort'] = parseInt(prev.sort) + 1;
        }
        $.post('<?php echo \think\Url::build("sort"); ?>', data, function (ret) {
            if (ret.code) {
                layer.alert(ret.msg);
            }
        }, 'json');
    }
    // 获取当前选中的节点
    function getCheckedId() {
        var id = [];
        var checked = zTree.getCheckedNodes()[0] ? zTree.getCheckedNodes() : zTree.getSelectedNodes();
        for (var i in checked) {
            id.push(checked[i].id);
        }
        return id;
    }

    // 公共操作方法
    function treeOpAll(url, desc) {
        var id = getCheckedId();
        if (id.length == 0) {
            layer.alert('请选择要操作的对象');
            return;
        }
        layer.confirm('你确定要' + desc + '选中的这些节点？', {}, function () {
            $.post(url, {'id': id.join(',')}, function (ret) {
                ajax_progress(ret, function () {
                    location.reload();
                });
            }, 'json');
        })
    }
    // 选中/取消选择当前节点
    function checkTreeNode(checked) {
        var nodes = zTree.getSelectedNodes();
        if (nodes && nodes.length > 0) {
            zTree.checkNode(nodes[0], checked, true);
        }
        hideRMenu();
    }
    // 右键菜单
    function OnRightClick(event, treeId, treeNode) {
        if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
            zTree.cancelSelectedNode();
            showRMenu("root", event.clientX, event.clientY);
        } else if (treeNode && !treeNode.noR) {
            zTree.selectNode(treeNode);
            showRMenu("node", event.clientX, event.clientY);
        }
    }
    // 显示右键菜单
    function showRMenu(type, x, y) {
        $("#rMenu ul").show();
        rMenu.css({"top": y + "px", "left": x + "px", "visibility": "visible"});
        $("body").bind("mousedown", onBodyMouseDown);
    }
    // 隐藏右键菜单
    function hideRMenu() {
        if (rMenu) rMenu.css({"visibility": "hidden"});
        $("body").unbind("mousedown", onBodyMouseDown);
    }
    function onBodyMouseDown(event) {
        if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
            rMenu.css({"visibility": "hidden"});
        }
    }
    // 初始化
    $(function () {
        var treeObj = $.fn.zTree.init($("#" + treeId), setting, <?php echo $node; ?>);
        zTree = $.fn.zTree.getZTreeObj(treeId);
        treeObj.expandAll(true);
        rMenu = $("#rMenu");
    })
</script>

</body>
</html>