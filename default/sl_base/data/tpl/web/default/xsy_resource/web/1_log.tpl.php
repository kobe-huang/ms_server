<?php defined('IN_IA') or exit('Access Denied');?><?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/header', TEMPLATE_INCLUDEPATH)) : (include template('common/header', TEMPLATE_INCLUDEPATH));?>
<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('web/tree', TEMPLATE_INCLUDEPATH)) : (include template('web/tree', TEMPLATE_INCLUDEPATH));?>
<!-- <div class="panel panel-info" style="">
    <div class="panel-heading">筛选</div>
    <div class="panel-body" style="padding:10px 0 0 10px">
        <form action="<?php  echo $this->createWebUrl('log')?>" method="get" class="form-horizontal" role="form" id="form1">
            <input type="hidden" name="c" value="site" /> 
            <input type="hidden" name="a" value="entry" /> 
            <input type="hidden" name="m" value="xsy_resource" />
            <input type="hidden" name="do" id="do" value="log" />
            <input type="hidden" name="op" id="op" value="search" />
            <div class="form-group">
                <label class="col-xs-12 col-sm-1 col-md-1 col-lg-1 control-label">查询</label>
                <div class="col-sm-5 col-lg-5 col-xs-12">
                    <input type="text" class="form-control" name="name" value="<?php  echo $_GPC['name'];?>" placeholder="原始名称" />
                </div>
                <div class="col-sm-1 col-lg-1 col-xs-12">
                    <button class="btn btn-default">
                        <i class="fa fa-search"></i>
                        搜索
                    </button>
                </div>
            </div>
        </form>
    </div>
</div> -->
<div class="clearfix">
    <div class="panel panel-default">

        <div class="panel-body">
            <table class="table table-hover" style="overflow: visible;">
                <thead class="navbar-inner">
                    <tr>
                        <th>ID</th>
                        
                        <th>用户</th>
                        <th>操作</th>
                        <th>脚本ID</th>
                        <th>脚本名称</th>
                        <th>时间</th>

                        
                    </tr>
                </thead>
                <tbody>
                    <?php  if(is_array($list)) { foreach($list as $row) { ?>
                    <tr>
                        <td><?php  echo $row['id'];?></td>
                        <td><?php  echo $row['realname'];?></td>
                        <td>
                        <?php  if($row['action']=='insert') { ?>
                            上传
                        <?php  } else if($row['action']=='update') { ?>
                            修改
                        <?php  } else if($row['action']=='del') { ?>
                            删除
                        <?php  } ?>
                        </td>
                        <td><?php  echo $row['script_id'];?></td>
                        <td><?php  echo $row['file_name'];?></td>
                        <td><?php  echo date('Y-m-d H:i', $row['time'])?></td>
                        
                    </tr>
                    <?php  } } ?>
                </tbody>
            </table>
            <?php  echo $pager;?>
        </div>
    </div>
</div>


<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/footer', TEMPLATE_INCLUDEPATH)) : (include template('common/footer', TEMPLATE_INCLUDEPATH));?>
