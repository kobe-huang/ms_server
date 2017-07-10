<?php defined('IN_IA') or exit('Access Denied');?><?php (!empty($this) && $this instanceof WeModuleSite || 0) ? (include $this->template('common/header', TEMPLATE_INCLUDEPATH)) : (include template('common/header', TEMPLATE_INCLUDEPATH));?>
<style>
	.label{line-height: 1.8;}
    .caret{
        float:right;
        margin-top:8px;
    }

    .select-strategy{
    	display:inline-block;
    	color:#f0334e;
    	width:200px;
    	line-height:15px;
    	white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
    }


	th{
		text-align: center;
	}
	li{list-style: none;}
	.progress{ height: 4px; font-size: 0; line-height: 4px; background: orange; width: 0;}



</style>
<?php  if($do != 'credit_record' && $do != 'credit_stat') { ?>
<ul class="nav nav-tabs">
    <li <?php  if($_GPC['a']=='member' && $do == 'display') { ?>class="active"<?php  } ?>><a href="<?php  echo url('mc/member/display')?>">会员列表</a></li>


<?php  if(!$_W['role_bool']) { ?>

    <?php  if($_GPC['a']=='member' && $do == 'post') { ?><li class="active"><a href="<?php  echo url('mc/member/post', array('uid' => $uid));?>">编辑会员资料</a></li><?php  } ?>
    <li <?php  if($_GPC['a']=='member' && $do == 'add') { ?>class="active"<?php  } ?>><a href="<?php  echo url('mc/member/add');?>">添加会员</a></li>

    <li <?php  if($_GPC['a']=='group' && $do == 'display') { ?>class="active"<?php  } ?>><a href="<?php  echo url('mc/group/display');?>">会员组列表</a></li>

    <li <?php  if($_GPC['a']=='group' && $do == 'post' && empty($groupid)) { ?>class="active"<?php  } ?>><a href="<?php  echo url('mc/group/post');?>">添加会员组</a></li>

<?php  } ?>



    <?php  if($_GPC['a']=='group' && $do == 'post' && !empty($groupid)) { ?><li class="active"><a href="<?php  echo url('mc/group/post', array('id' => $groupid));?>">编辑会员组</a></li><?php  } ?>
</ul>
<?php  } else { ?>
<ul class="nav nav-tabs">
	<li <?php  if($do  == 'credit_stat') { ?> class="active"<?php  } ?>><a href="<?php  echo url('mc/member/credit_stat', array('type' => 1, 'uid' => $uid));?>">数据概况</a></li>
	<li <?php  if($do  == 'credit_record' &&  $type == 'credit1') { ?> class="active"<?php  } ?>><a href="<?php  echo url('mc/member/credit_record', array('type' => 'credit1', 'uid' => $uid));?>">积分日志</a></li>
	<li <?php  if($do  == 'credit_record' &&  $type == 'credit2') { ?> class="active"<?php  } ?>><a href="<?php  echo url('mc/member/credit_record', array('type' => 'credit2', 'uid' => $uid));?>">余额日志</a></li>
</ul>
<?php  } ?>

<?php  if($do=='display') { ?>
<!-- <div class="panel panel-info">
	<div class="panel-heading">筛选</div>
	<div class="panel-body">
		<form action="./index.php" method="get" class="form-horizontal" role="form">
		<input type="hidden" name="c" value="mc">
		<input type="hidden" name="a" value="member">
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">注册时间</label>
				<div class="col-sm-6 col-md-8 col-lg-8 col-xs-12">
					<?php  echo tpl_form_field_daterange('createtime', array('starttime' => date('Y-m-d', $starttime), 'endtime' => date('Y-m-d', $endtime),));?>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">昵称/用户名/手机号码/openid</label>
				<div class="col-sm-6 col-md-8 col-lg-8 col-xs-12">
					<input type="text" class="form-control" name="username" value="<?php  echo $_GPC['username'];?>" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">uid</label>
				<div class="col-sm-6 col-md-8 col-lg-8 col-xs-12">
					<input type="text" class="form-control" name="uid" value="<?php  echo $_GPC['uid'];?>" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">所属用户组</label>
				<div class="col-sm-6 col-md-8 col-lg-8 col-xs-12">
					<select name="groupid" class="form-control">
						<option value="" selected="selected">不限</option>
						<?php  if(is_array($groups)) { foreach($groups as $group) { ?>
						<option value="<?php  echo $group['groupid'];?>"<?php  if($group['groupid'] == $_GPC['groupid']) { ?> selected="selected"<?php  } ?>><?php  echo $group['title'];?></option>
						<?php  } } ?>
					</select>
				</div>
				<div class="pull-right col-xs-12 col-sm-3 col-md-2 col-lg-2">
					<button class="btn btn-default"><i class="fa fa-search"></i> 搜索</button>
					<input type="hidden" name="token" value="<?php  echo $_W['token'];?>"/>
					<input class="btn btn-primary" type="submit" name="export_submit" id="export_submit" value="导出">
				</div>
			</div>
		</form>
	</div>
</div> -->
<?php  if(!$_W['role_bool']) { ?>
<div class="alert alert-info">
	<i class="fa fa-info-circle"></i> 当前会员总数:<strong class="text-danger"><?php  echo $stat['total'];?></strong>。今日新增会员:<strong class="text-danger"><?php  echo $stat['today'];?></strong>。昨日新增会员:<strong class="text-danger"><?php  echo $stat['yesterday'];?></strong>。<br>
	<strong class="text-danger">
		<i class="fa fa-info-circle"></i> 会员的总积分 = 账户积分 + 账户贡献. 会员所在的会员组是根据 "总积分的多少" 和 "会员组的变更规则" (<根据总积分多少自动升价> 或 <根据总积分多少只升不降>) 自动匹配.<br>
	</strong>
</div>
<?php  } ?>
<form method="post" class="form-horizontal" id="form1">
<div class="panel panel-default ">
	<div class="table-responsive panel-body" style="min-height: 600px;">
	<table class="table table-hover">
		<input type="hidden" name="do" value="del" />
		<thead class="navbar-inner">
			<tr>
				<?php  if(!$_W['role_bool']) { ?>
				<th style="width:44px;">删?</th>
				<?php  } ?>
				<th style="width:50px;">ID</th>
				<th style="width:150px;">用户名</th>
				<th style="width:12%;">手机</th>
				<!-- <th style="min-width:100px;">邮箱</th> -->
				<th style="width:10%;">余额/积分</th>
				<th style="width:12%;">注册时间</th>
				<th style="width:70%;text-align:right">操作</th>
			</tr>
		</thead>
		<tbody>
		<?php  if(is_array($list)) { foreach($list as $li) { ?>
			<tr>
				<?php  if(!$_W['role_bool']) { ?>
				<td><input type="checkbox" name="uid[]" value="<?php  echo $li['uid'];?>" class=""></td>
				<?php  } ?>
				<td><?php  echo $li['uid'];?></td>
				<td>
					<?php  if($li['realname']) { ?><?php  echo $li['realname'];?><?php  } else { ?>未完善<?php  } ?>
				</td>
				<td><?php  if($li['mobile']) { ?><?php  echo $li['mobile'];?><?php  } else { ?>未完善<?php  } ?></td>
				<!-- <td><?php  if($li['email_effective'] == 1) { ?><?php  echo $li['email'];?><?php  } else { ?>未完善<?php  } ?></td> -->
				<td>
					<span class="label label-primary">余额：<?php  echo $li['credit2'];?></span>
					<br>
					<span class="label label-warning">积分：<?php  echo $li['credit1'];?></span>
				</td>
				<td><?php  echo date('y-m-d H:i',$li['createtime'])?></td>
				<td class="text-right" style="overflow:visible;">
					<div class="btn-group">


					<?php  if(!$_W['role_bool']) { ?>
					<a href="javascript:;" title="积分" class="btn btn-default modal-trade-credit1" data-type="credit1" data-uid="<?php  echo $li['uid'];?>">积分</a>
					<a href="javascript:;" title="余额" class="btn btn-default modal-trade-credit2" data-type="credit2" data-uid="<?php  echo $li['uid'];?>">余额</a>
					<a href="javascript:;" title="消费" class="btn btn-default modal-trade-consume" data-type="consume" data-uid="<?php  echo $li['uid'];?>">消费</a>
					
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<?php  echo $_W['account']['groups'][$li['groupid']]['title'];?>
						<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<?php  if(is_array($_W['account']['groups'])) { foreach($_W['account']['groups'] as $group) { ?>
									<li class="user-group" data-id="<?php  echo $group['groupid'];?>" data-uid="<?php  echo $li['uid'];?>"><a href="javascript:;"><?php  echo $group['title'];?></a></li>
							<?php  } } ?>
						</ul>
					</div>
					
					<?php  } ?>

                    <div class="btn-group">
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="select-strategy">
                        <?php  if(is_array($strategy)) { foreach($strategy as $row) { ?>
                            <?php  if($row['id']==$li['strategy_id']) { ?>
                                <?php  echo $row['name'];?>
                            <?php  } ?>
                        <?php  } } ?>
                        </span>
                        <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <?php  if(is_array($strategy)) { foreach($strategy as $row) { ?>
                                    <li class="user-str" data-id="<?php  echo $row['id'];?>" data-uid="<?php  echo $li['uid'];?>"><a href="javascript:;" ><?php  echo $row['name'];?></a></li>
                            <?php  } } ?>
                        </ul>
                    </div>

					<?php  if($_W['role_bool']) { ?>
						<!-- <a href="javascript:;"  data-uid="<?php  echo $li['uid'];?>" title="下载" class="btn btn-warning download_excel">下载模板</a> -->
						<a href="javascript:;" data-toggle="modal" data-target="#modal-up-ad" onclick="setEdit(<?php  echo $li['uid'];?>)"  title="上传" class="btn btn-success">设置模板</a>
						<a href="javascript:;" data-toggle="modal" data-target="#modal-strategy-ad" onclick="show_list(<?php  echo $li['uid'];?>)"  class="btn btn-primary">我的模板</a>
					<?php  } ?>

<!-- href="<?php  echo url('mc/member/download',array('uid' => $li['uid']))?>" -->



					
					<a href="<?php  echo url('mc/member/post',array('uid' => $li['uid']))?>" title="编辑" class="btn btn-default">编辑</a>
					<a href="<?php  echo url('mc/member/credit_stat',array('uid' => $li['uid'], 'type' => 1))?>" title="日志" class="btn btn-success">日志</a>
					</div>
				</td>
			</tr>
		<?php  } } ?>
		<?php  if(!$_W['role_bool']) { ?>
		<tr>
			<td><input type="checkbox" name="" onclick="var ck = this.checked;$(':checkbox').each(function(){this.checked = ck});"></td>
			<input name="token" type="hidden" value="<?php  echo $_W['token'];?>" />
			<td colspan="7"><input type="submit" name="submit" class="btn btn-primary" value="删除"></td>
		</tr>
		<?php  } ?>
		</tbody>
	</table>
</div>
</div>


	<?php  echo $pager;?>
</form>

<!-- <script type="text/javascript" src="./resource/js/lib/plupload.full.min.js"></script> -->
<!-- 添加幻灯片 -->
<div id="modal-up-ad"  class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
	<form class="form-horizontal form"action="<?php  echo url('mc/member/user_excel_form')?>" method="post"  enctype="multipart/form-data">
		<div class="modal-dialog"  style="width: 800px;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
					<h3>设置模板</h3>
                    <h5 style="color:green;">提示：以 <span style="color:red;">回车</span> 区分每条数据</h5>
				</div>
				<div class="modal-body">
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">模板名称</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" class="form-control" name="name" value="" />
                        </div>
                    </div>
                    <?php  echo $tem_str;?>
				</div>
				<div class="modal-footer">
                    <input type="hidden" name="uid" value="<?php  echo $_W['uid'];?>">
					<button type="submit" class="btn btn-primary span2" name="add-ad" value="yes">确  认</button>
					<a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
				</div>
			</div>
		</div>
	</form>
</div>














<!-- 添加幻灯片 -->
<div id="modal-strategy-ad" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
        <div class="modal-dialog" style="width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3>我的模板</h3>
                </div>
                <div class="modal-body">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>
                                    <th width="100px" style="text-align: center;">模板名称</th>
                                    <th width="100px">策略名称</th>
                                    <th width="50px"></th>
                                </tr>
                            </thead>
                            <tbody id="my_list">

                            </tbody>
                        </table>


                </div>
            </div>
        </div>
</div>

<!-- 添加幻灯片 -->
<div id="modal-strategy-tpl" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
        <div class="modal-dialog" style="width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3>我的模板</h3>
                </div>
                <div class="modal-body">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>
                                    <th width="100px" style="text-align: center;">模板名称</th>
                                    <th width="100px">策略名称</th>
                                    <th width="50px"></th>
                                </tr>
                            </thead>
                            <tbody id="my_tpl">

                            </tbody>
                        </table>


                </div>
            </div>
        </div>
</div>
















<script>

function  setEdit(uid)
{
	// $.getJSON("<?php  echo url('mc/member/show_list')?>", {uid: uid}, function(data){
 //        $.each(data,function(i,result){
 //            item = "<tr><td>"+result['name']+"</td><td>"+result['info']+"</td></tr>";
 //            $('#my_list').append(item); 
 //        });
 //    });




}


function  show_list(uid)
{
	$('#my_list').html("");
		$.getJSON("<?php  echo url('mc/member/show_list')?>", {uid: uid}, function(data){
			$.each(data,function(i,result){
				item = "<tr><td>"+result['name']+"</td><td>"+result['strategyname']+"</td><td><a href='javascript:;' class='btn btn-default btn-primary'  data-toggle='modal' data-target='#modal-strategy-tpl' onclick='show_tpl("+result['id']+")'>预览模板</a></td></tr>";
	            $('#my_list').append(item); 
	        });
        }); 
 
}

function show_tpl(id){

        $.getJSON("<?php  echo url('mc/member/show_tpl')?>", {id: id}, function(data){
            $.each(data,function(i,result){
                item = "";
                $('#my_tpl').append(item); 
            });
        });

}

	require(['trade', 'bootstrap'], function(trade){
		trade.init();

		$('#form1').submit(function(){
			if($(":checkbox[name='uid[]']:checked").size() > 0){
				return confirm('删除后不可恢复，您确定删除吗？');
			}
			util.message('没有选择会员', '', 'error');
			return false;
		});

		$('.user-group').click(function(){
			if(!confirm('确定更改会员组吗')) return false;
			var id = $(this).data('id');
			var uid = $(this).data('uid');
			$.post("<?php  echo url('mc/member/group');?>", {uid: uid, id: id}, function(data){
				if(data != 'success') {
					util.message(data, '', 'error');
				} else {
					location.reload();
				}
			});
		});

        $('.user-str').click(function(){
            if(!confirm('确定更改策略吗')) {
               return false; 
           }else{
            var strategy_id = $(this).data('id');
            var uid = $(this).data('uid');
                $.post("<?php  echo url('mc/member/strategy');?>", {uid: uid, strategy_id: strategy_id}, function(data){
                if(data != 'success') {
                    util.message(data, '', 'error');
                } else {
                    location.reload();
                }
            });     
           }

        });

        /*原下载模板*/
        //      $('.download_excel').click(function(){
	  //       var uid = $(this).data('uid');
			// $.post("<?php  echo url('mc/member/download');?>", {uid: uid}, function(data){
			// 	if(data == 'error'){
			// 		alert('下载失败，用户未绑定策略或该策略无模板');
			// 	}else if(data == 'othererror') {
			// 		alert('未知错误');
			// 	}else{
			// 		window.location.href=data;
			// 	}
			// }); 
   //      });
	});
</script>
<?php  } ?>

<?php  if($do=='post') { ?>
<div class="main">
<form action="" class="form-horizontal form" method="post" enctype="multipart/form-data">
<?php  if(!empty($profile)) { ?>
<div class="panel panel-default">
	<div class="panel-heading">修改密码</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">新密码</label>
			<div class="col-sm-9 col-xs-12">
				<input type="password" class="form-control" name="newpwd" value="" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">重复新密码</label>
			<div class="col-sm-9 col-xs-12">
				<input type="password" class="form-control" name="rnewpwd" value="" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label"></label>
			<div class="col-sm-9 col-xs-12">
				<a href="javascript:;" id="updatepwd" class="btn btn-primary">修改密码</a>
				<span class="label"></span>
			</div>	
		</div>
	</div>
</div>
<?php  } ?>

<div class="panel panel-default">
	<div class="panel-heading">对应策略</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">分配策略</label>
			<div class="col-sm-9 col-xs-12">
				<select name="strategy_id" id="strategy_id" class="form-control">
					<option value=""></option>
					<?php  if(is_array($strategy)) { foreach($strategy as $row) { ?>
						
						<option value="<?php  echo $row['id'];?>"<?php  if($profile['strategy_id']==$row['id']) { ?>selected<?php  } ?>><?php  echo $row['name'];?></option>
						
					<?php  } } ?>
				</select>
			</div>
		</div>
					<div class="form-group">
						<label class="col-xs-12 col-sm-3 col-md-2 control-label"></label>
						<div class="col-sm-9 col-xs-12">
							<a href="javascript:"  id="updatestrategy" data-id="" data-op="updatestrategy" class="btn btn-default btn-primary">保存策略</a>
						</div>
					</div>

	</div>
</div>


<div class="panel panel-default">
	<input type="hidden" name="uid" value="<?php  echo $uid;?>" />
	<input type="hidden" name="fanid" value="<?php  echo $_GPC['fanid'];?>" />
	<input type="hidden" name="email_effective" value="<?php  echo $profile['email_effective'];?>" />
	<div class="panel-heading">
		基本资料
	</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">头像</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('avatar', $profile['avatar']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">用户UID</label>
			<div class="col-sm-9 col-xs-12">
				<input type="text" class="form-control" name="" value="<?php  echo $uid;?>" readonly="readonly">
			</div>
		</div>
		<div class="form-group hide">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">所在会员组</label>
			<div class="col-sm-9 col-xs-12">
				<select name="groupid" class="form-control" disabled>
					<?php  if(is_array($groups)) { foreach($groups as $group) { ?>
					<option value="<?php  echo $group['groupid'];?>" <?php  if($profile['groupid'] == $group['groupid']) { ?>selected<?php  } ?>><?php  echo $group['title'];?></option>
					<?php  } } ?>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">昵称</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('nickname',$profile['nickname']);?>
			</div>
		</div>
		<?php  if(!$_W['role_bool']) { ?>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">用户名</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('realname',$profile['realname']);?>
			</div>
		</div>
		<?php  } ?>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">性别</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('gender',$profile['gender']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">生日</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('birth',array('year' => $profile['birthyear'],'month' => $profile['birthmonth'],'day' => $profile['birthday']));?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">户籍</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('reside',array('province' => $profile['resideprovince'],'city' => $profile['residecity'],'district' => $profile['residedist']));?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">详细地址</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('address',$profile['address']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">手机</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('mobile',$profile['mobile']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">QQ</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('qq',$profile['qq']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">Email</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('email',$profile['email']);?>
			</div>
		</div>
	</div>
</div>

<div class="panel panel-default">
	<div class="panel-heading">联系方式</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">固定电话</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('telephone',$profile['telephone']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">MSN</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('msn',$profile['msn']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">阿里旺旺</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('taobao',$profile['taobao']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">支付宝帐号</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('alipay',$profile['alipay']);?>
			</div>
		</div>
	</div>
</div>

<div class="panel panel-default" id="tip">
	<div class="panel-heading">收货地址</div>
	<div class="panel-body">
		<div id="address">
		<?php  if(is_array($addresss)) { foreach($addresss as $address) { ?>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label"></label>
			<div class="col-sm-9 col-xs-12">
				<label  data-id="<?php  echo $address['id'];?>"><?php  echo $address['province'];?>-<?php  echo $address['city'];?>-<?php  echo $address['district'];?>-<?php  echo $address['address'];?><?php  if(!empty($address['isdefault'])) { ?><span id="default">【默认收货地址】</span><?php  } ?></label>
				<span class="help-block">
					<a href="javascript:" id="" class="isdefault" data-id="<?php  echo $address['id'];?>"><?php  if(!$address['isdefault']) { ?>设为默认<?php  } ?></a>
					<a href="javascript:" data-toggle="modal" data-target="#myModal" class="editaddr" data-id="<?php  echo $address['id'];?>" data-username="<?php  echo $address['username'];?>" data-mobile="<?php  echo $address['mobile'];?>" data-zipcode="<?php  echo $address['zipcode'];?>" data-province="<?php  echo $address['province'];?>" data-city="<?php  echo $address['city'];?>" data-district="<?php  echo $address['district'];?>" data-address="<?php  echo $address['address'];?>">编辑</a>
					<a href="javascript:" class="deleteaddr" data-id="<?php  echo $address['id'];?>">删除</a>
				</span>
			</div>
		</div>
		<?php  } } ?>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label"></label>
			<div class="col-sm-9 col-xs-12">
				<button type="button" id="add" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
					添加收货地址
				</button>
			</div>
		</div>
		</div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">添加收货地址</h4>
			</div>
			<div class="modal-body">
				<div class="addaddress">
					<div class="form-group">
						<label class="col-xs-12 col-sm-3 col-md-2 control-label">姓名</label>
						<div class="col-sm-9 col-xs-12">
							<input class="form-control" name="name" value="<?php  echo $_GPC['record']['username'];?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-12 col-sm-3 col-md-2 control-label">手机号</label>
						<div class="col-sm-9 col-xs-12">
							<input class="form-control" name="phone" value="<?php  echo $_GPC['record']['mobile'];?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-12 col-sm-3 col-md-2 control-label">邮编</label>
						<div class="col-sm-9 col-xs-12">
							<input class="form-control" name="code" value="<?php  echo $_GPC['record']['zipcode'];?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-12 col-sm-3 col-md-2 control-label">收货地址</label>
						<div class="col-sm-9 col-xs-12">
							<?php  echo tpl_form_field_district("addaddress", array('province' => $_GPC['record']['province'], 'city' => $_GPC['record']['city'], 'district' => $_GPC['record']['district']));?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-12 col-sm-3 col-md-2 control-label">详细地址</label>
						<div class="col-sm-9 col-xs-12">
							<input class="form-control" name="detail" value="<?php  echo $_GPC['record']['address'];?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-12 col-sm-3 col-md-2 control-label"></label>
						<div class="col-sm-9 col-xs-12">
							<a href="javascript:"  id="submitaddr" data-id="" data-op="" class="btn btn-default btn-primary">提交</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
		$('#add').click(function () {
			$('#myModalLabel').html('添加收货地址');
			$('[name="name"]').val('');
			$('[name="addaddress[province]"]').val('');
			$('[name="addaddress[city]"]').val('');
			$('[name="addaddress[district]"]').val('');
			$('[name="detail"]').val('');
			$('[name="code"]').val('');
			$('[name="phone"]').val('');
			$('#submitaddr').data('op', 'addaddress');
		});
		$('#address').on('click', ".editaddr", function() {
			$('#myModalLabel').html('修改收货地址');
			$('#submitaddr').data('op', 'editaddress');
			$('#edit').prop('id', '');
			$(this).prop('id', 'edit');
			$('[name="name"]').val($(this).data('username'));
			$('[name="addaddress[province]"]').val($(this).data('province'));
			$('[name="addaddress[province]"]').trigger('change');
			$('[name="addaddress[city]"]').val($(this).data('city'));
			$('[name="addaddress[city]"]').trigger('change');
			$('[name="addaddress[district]"]').val($(this).data('district'));

			$('[name="detail"]').val($(this).data('address'));
			$('[name="code"]').val($(this).data('zipcode'));
			$('[name="phone"]').val($(this).data('mobile'));
			$('#submitaddr').data('id', $(this).data('id'));
		});
		$('#address').on('click', ".isdefault",function () {
			var uid = <?php  echo $_GPC['uid'];?>;
			var id = $(this).data('id');
			var obj = $(this);
			$.post("<?php  echo url('mc/member/post' ,array('op' => 'isdefault'))?>", {uid : uid, id: id}, function(data) {
				if (data.message.errno) {
					$('#default').parent().next().children(':first').html('设为默认');
					$('#default').remove();
					obj.parent().prev().html(obj.parent().prev().html()+'<span id="default">【默认收货地址】</span>');
					obj.html('');
				}
			},'json');
		});
		$('#address').on('click', '.deleteaddr', function () {
			if (!confirm('确认删除收货地址')) {
				return false;
			}
			var id = $(this).data('id');
			var obj = $(this);
			$.post("<?php  echo url('mc/member/post', array('op' => 'del'));?>", {id : id}, function(data) {
				if (data.message.errno) {
					obj.parent().parent().remove();
				}
			}, 'json');
		});
		$('#submitaddr').click(function () {
			var name = $('[name="name"]').val();
			if (name == '') {
				util.message('请填写收货人姓名');
				return false;
			}
			var province = $('[name="addaddress[province]"]').val();
			var city = $('[name="addaddress[city]"]').val();
			var district = $('[name="addaddress[district]"]').val();
			var detail = $('[name="detail"]').val();
			var uid = <?php  echo $_GPC['uid'];?>;
			var code = $('[name="code"]').val();
			var phone = $('[name="phone"]').val();
			if (phone == '') {
				 util.message('请填写收货人手机号');
				return false;
			}
			var reg = /^1\d{10}$/;
			if (!reg.test(phone)) {
				util.message('请填写正确的手机号码');
				return false;
			}
			if (city == '') {
				util.message('请填写收货地址');
				return false;
			}
			if (detail == '') {
				util.message('请填写详细收货地址');
				return false;
			}
			$('#myModal').modal('hide');
			var id = $(this).data('id');
			var op = $(this).data('op');
			$.post("./index.php?c=mc&a=member&do=post&op="+op, {province : province, city : city, district : district, detail : detail, uid : uid, name : name, code : code, phone : phone, id : id}, function(data) {
				var post = data.message.message;
				if (data.message.errno) {
					if (op == 'editaddress') {
						$('#edit').data({'username' : post.username, 'id' : post.id, 'mobile' : post.mobile, 'zipcode' : post.zipcode, 'province' : post.province, 'city' : post.city, 'district' : post.district, 'address' : post.address});
						var html = $('#edit').parent().prev().html();
						var edithtml = post.province + ' - ' + post.city + ' - ' + post.district + ' - '+ post.address;
						if (html.indexOf('默认收货地址') > -1) {
							edithtml += '<span id="default">【默认收货地址】</span>';
						}
						$('#edit').parent().prev().html(edithtml);
						util.message('修改成功');
					} else{
						var isdefault = '';
						if (post.isdefault == 1) {
							isdefault += '<span id="default">【默认收货地址】</span>';
						}
						$('#address').append(
							'<div class="form-group">' +
							'   <label class="col-xs-12 col-sm-3 col-md-2 control-label"></label>' +
							'   <div class="col-sm-9 col-xs-12">'+
							'<label  data-id='+post.id+'>'+post.province+'-'+post.city+'-'+post.district+'-'+post.address+isdefault+'</label>'+
							'       <span class="help-block">' +
							'           <a href="javascript:" class="isdefault" data-id="'+post.id+'">设为默认</a>'+
							'           <a href="javascript:" class="editaddr" data-toggle="modal" data-target="#myModal" data-id="'+post.id+'" data-username="'+post.username+'" data-mobile="'+post.mobile+'" data-zipcode="'+post.zipcode+'" data-province="'+post.province+'" data-city="'+post.city+'" data-district="'+post.district+'" data-address="'+post.address+'">编辑</a>'+
							'           <a href="javascript:" class="deleteaddr" data-id="'+post.id+'">删除</a>'+
							'       </span>'+
							'   </div>'+
							'</div>'
					);
					util.message('添加成功');
					}
				}
			}, 'json');
		});
	});
</script>

<div class="panel panel-default">
	<div class="panel-heading">教育情况</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">学号</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('studentid',$profile['studentid']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">班级</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('grade',$profile['grade']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">毕业学校</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('graduateschool',$profile['graduateschool']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">学历</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('education',$profile['education']);?>
			</div>
		</div>
	</div>
</div>

<div class="panel panel-default">
	<div class="panel-heading">工作情况</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">公司</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('company',$profile['company']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">职业</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('occupation',$profile['occupation']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">职位</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('position',$profile['position']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">年收入</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('revenue',$profile['revenue']);?>
			</div>
		</div>
	</div>
</div>

<div class="panel panel-default">
	<div class="panel-heading">个人情况</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">星座</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('constellation',$profile['constellation']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">生肖</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('zodiac',$profile['zodiac']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">国籍</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('nationality',$profile['nationality']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">身高</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('height',$profile['height']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">体重</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('weight',$profile['weight']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">血型</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('bloodtype',$profile['bloodtype']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">身份证号</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('idcard',$profile['idcard']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">邮编</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('zipcode',$profile['zipcode']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">个人主页</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('site',$profile['site']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">情感状态</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('affectivestatus',$profile['affectivestatus']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">交友目的</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('lookingfor',$profile['lookingfor']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">自我介绍</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('bio',$profile['bio']);?>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label">兴趣爱好</label>
			<div class="col-sm-9 col-xs-12">
				<?php  echo tpl_fans_form('interest',$profile['interest']);?>
			</div>
		</div>
	</div>
</div>
<div class="panel panel-default">
	<div class="panel-heading">其他信息</div>
	<div class="panel-body">
		<?php  if(is_array($custom_fields)) { foreach($custom_fields as $field) { ?>
		<div class="form-group">
			<label class="col-xs-12 col-sm-3 col-md-2 control-label"><?php  echo $all_fields[$field];?></label>
			<div class="col-sm-9 col-xs-12">
				<input name="<?php  echo $field;?>" class="form-control" value="<?php  echo $profile[$field];?>">
			</div>
		</div>
		<?php  } } ?>
	</div>
</div>
	<div class="form-group">
		<div class="col-sm-12">
			<button type="submit" class="btn btn-primary col-lg-1" name="submit" value="提交">提交</button>
			<input type="hidden" name="token" value="<?php  echo $_W['token'];?>" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
	$('#updatepwd').click(function(){
		var newpwd = $("input[name='newpwd']").val();
		var rnewpwd = $("input[name='rnewpwd']").val();
		if (newpwd.length < 6) {
			util.message('密码不得少于6个字符');
			return false;
		}
		if (newpwd != rnewpwd) {
			util.message('两次输入的密码不一致');
			return false;
		}
		var uid = window.location.href.substr(window.location.href.lastIndexOf('=') + 1);
		$.post(location.href, {uid:uid, password:newpwd}, function(resp){
			if(resp == 'success') {
				$('#updatepwd').next().removeClass().addClass('label label-success').text('密码修改成功');
				$("input[name='newpwd']").val('');
				$("input[name='rnewpwd']").val('');
				setTimeout(function() {$('#updatepwd').next().empty();}, 2000);
			} else if (resp == 'error') {
				$('#updatepwd').next().removeClass().addClass('label label-danger').text('会员不存在或已删除');
			} else {
				$('#updatepwd').next().removeClass().addClass('label label-danger').text('网络错误，请稍后重试');
			}
		});

	});


$('#updatestrategy').click(function () {
		var strategy_id = $("#strategy_id").val();
		if (strategy_id =="") {
			util.message('请选择一个策略');
			return false;
		}
			var uid = <?php  echo $_GPC['uid'];?>;
			var op = $(this).data('op');
			$.post("./index.php?c=mc&a=member&do=post&op="+op, {uid : uid, strategy_id : strategy_id}, function(data) {
				var post = data.message.message;
				if (data.message.errno) {
					util.message('设置成功');
				}
			}, 'json');
		});
</script>
<?php  } ?>

<?php  if($do == 'add') { ?>
<form action="./index.php?c=mc&a=member&do=add" method="post" class="form-horizontal" role="form" id="form1">
	<div class="panel panel-info">
		<div class="panel-heading">添加会员</div>
		<div class="panel-body">
<!-- 			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">手机序号</label>
				<div class="col-sm-9 col-xs-12">
					<input type="text" name="ms_code" value="" class="form-control"/>
				</div>
			</div> -->

			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">会员用户名</label>
				<div class="col-sm-9 col-xs-12">
					<input type="text" name="realname" value="" class="form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">手机号</label>
				<div class="col-sm-9 col-xs-12">
					<input type="text" name="mobile" value="" class="form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">登陆密码</label>
				<div class="col-sm-9 col-xs-12">
					<input type="password" name="password" value="" class="form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">邮箱</label>
				<div class="col-sm-9 col-xs-12">
					<input type="text" name="email" value="" class="form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">积分</label>
				<div class="col-sm-9 col-xs-12">
					<input type="text" name="credit1" value="0" class="form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">余额</label>
				<div class="col-sm-9 col-xs-12">
					<input type="text" name="credit2" value="0" class="form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">会员组</label>
				<div class="col-sm-9 col-xs-12">
					<select name="groupid" class="form-control">
						<?php  if(is_array($_W['account']['groups'])) { foreach($_W['account']['groups'] as $group) { ?>
						<option value="<?php  echo $group['groupid'];?>"><?php  echo $group['title'];?></option>
						<?php  } } ?>
					</select>
				</div>
			</div>

<!-- 			<div class="form-group">
				<label class="col-xs-12 col-sm-3 col-md-2 control-label">分配策略</label>
				<div class="col-sm-9 col-xs-12">
					<select name="strategy_id" class="form-control">
						<option value=""></option>
						<?php  if(is_array($strategy)) { foreach($strategy as $row) { ?>
						<option value="<?php  echo $row['id'];?>"><?php  echo $row['info'];?></option>
						<?php  } } ?>
					</select>
				</div>
			</div> -->
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-9 col-xs-12">
			<input type="hidden" name="token" value="<?php  echo $_W['token'];?>"/>
			<input type="hidden" name="form" value="<?php  echo $_W['token'];?>"/>
			<input type="submit" value="提交" class="btn btn-primary"/>
		</div>
	</div>
</form>
<script>
	require(['validator'], function($){
		$(function(){
			$('#form1').bootstrapValidator({
				fields: {
					// ms_code: {
					// 	validators: {
					// 		notEmpty: {
					// 			message: '手机序号不能为空'
					// 		},
					// 		remote: {
					// 			url: "<?php  echo url('mc/member/add');?>",
					// 			data: function(validator) {
					// 				return {
					// 					type: 'ms_code',
					// 					data: validator.getFieldElements('ms_code').val()
					// 				};
					// 			},
					// 			message: '手机序号已经存在'
					// 		}
					// 	}
					// },
					realname: {
						validators: {
							notEmpty: {
								message: '用户名不能为空'
							}
						}
					},
					mobile: {
						validators: {
							notEmpty: {
								message: '手机不能为空'
							},
							regexp: {
								regexp: /1\d{10}/,
								message: '手机号格式不正确'
							},
							remote: {
								url: "<?php  echo url('mc/member/add');?>",
								data: function(validator) {
									return {
										type: 'mobile',
										data: validator.getFieldElements('mobile').val()
									};
								},
								message: '手机号已经被占用'
							}
						}
					},

					email: {
						validators: {
							regexp: {
								regexp: /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
								message: '邮箱格式不正确'
							},
							remote: {
								url: "<?php  echo url('mc/member/add');?>",
								data: function(validator) {
									return {
										type: 'email',
										data: validator.getFieldElements('email').val()
									};
								},
								message: '邮箱已经被占用'
							}
						}
					},
					password: {
						validators: {
							notEmpty: {
								message: '密码不能为空'
							},
							stringLength: {
								min: 8,
								max: 15,
								message: '密码最少为8位'
							}
						}
					},
					credit1: {
						validators: {
							regexp: {
								regexp: /^[0-9]\d*$/i,
								message: '积分格式不正确'
							}
						}
					},
					credit2: {
						validators: {
							regexp: {
								regexp: /^[0-9]\d*$/i,
								message: '余额格式不正确'
							}
						}
					}
				}
			});
		});
	});
</script>
<?php  } ?>

<?php  if($do == 'credit_record') { ?>
<div class="panel panel-default">
	<div class=" panel-body table-responsive">
		<table class="table table-hover">
			<thead>
			<tr>
				<th style="width:100px">账户类型</th>
				<th style="width:100px">操作员</th>
				<?php  if($type == 'credit2') { ?>
				<th style="width:100px">消费金额</th>
				<th style="width:100px">实收金额</th>
				<?php  } ?>
				<th style="width:100px">数量</th>
				<th style="width:100px">模块</th>
				<th style="width:200px">操作时间</th>
				<th>备注</th>
			</tr>
			</thead>
			<tbody>
			<?php  if(is_array($data)) { foreach($data as $da) { ?>
			<tr>
				<td><?php  echo $credits[$type];?></td>
				<td><?php  if($da['username']) { ?><?php  echo $da['username'];?><?php  } else { ?>系统操作<?php  } ?></td>
				<?php  if($type == 'credit2') { ?>
				<td><?php  echo abs($da['num'])?>元</td>
				<td><?php  echo abs($da['final_num'])?>元</td>
				<?php  } ?>
				<td><?php  echo $da['num'];?></td>
				<td>
					<?php  if(!empty($da['module']) && !empty($modules[$da['module']]['title'])) { ?>
					<?php  echo $modules[$da['module']]['title'];?>
					<?php  } else { ?>
					未知
					<?php  } ?>
				</td>
				<td><?php  echo date('Y-m-d H:i:s', $da['createtime'])?></td>
				<td style="white-space:normal"><?php  echo $da['remark'];?></td>
			</tr>
			<?php  } } ?>
			</tbody>
		</table>
	</div>
</div>
<?php  echo $pager;?>
<?php  } ?>

<?php  if($do == 'credit_stat') { ?>
<style>
	.account-stat{overflow:hidden; color:#666;}
	.account-stat .account-stat-btn{width:100%; overflow:hidden;}
	.account-stat .account-stat-btn > div{text-align:center; margin-bottom:5px;margin-right:2%; float:left;width:48%; padding-top:10px;font-size:16px; border-left:1px #DDD solid;}
	.account-stat .account-stat-btn > div:first-child{border-left:0;}
	.account-stat .account-stat-btn .stat{width:80%;margin:10px auto;font-size:15px}
</style>
<div class="panel panel-default" style="padding:1em">
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin: -1em -1em 1em -1em;">
		<div class="navbar-header">
			<a class="navbar-brand" href="javascript:;">数据统计</a>
			<ul class="nav navbar-nav navbar-right">
				<li <?php  if($_GPC['type'] == 1) { ?>class="active"<?php  } ?>><a href="<?php  echo url('mc/member/credit_stat', array('uid' => $uid, type => 1));?>">今日</a></li>
				<li <?php  if($_GPC['type'] == -1) { ?>class="active"<?php  } ?>><a href="<?php  echo url('mc/member/credit_stat', array('uid' => $uid, type => -1));?>">昨日</a></li>
				<form class="navbar-form navbar-left" role="search" id="form1">
					<input name="c" value="mc" type="hidden" />
					<input name="a" value="member" type="hidden" />
					<input name="do" value="credit_stat" type="hidden" />
					<input name="uid" value="<?php  echo $uid;?>" type="hidden" />
					<?php  echo tpl_form_field_daterange('datelimit', array('start' => date('Y-m-d', $starttime),'end' => date('Y-m-d', $endtime)), '')?>
				</form>
			</ul>
		</div>
	</nav>
	<div class="account-stat">
		<div class="account-stat-btn">
			<?php  if(is_array($credits)) { foreach($credits as $key => $li) { ?>
			<div>
				<strong><?php  echo $li;?></strong>
				<div id="rule" class="stat">
					<div>增加 <strong><span class="text-success"><?php  echo $data[$key]['add'];?></span></strong></div>
					<div>减少 <strong><span class="text-danger"><?php  echo $data[$key]['del'];?></span></strong></div>
				</div>
			</div>
			<?php  } } ?>
		</div>
	</div>
</div>
<script>
	require(['chart', 'daterangepicker'], function(c) {
		$('.daterange').on('apply.daterangepicker', function(ev, picker) {
			$('#form1')[0].submit();
		});
	});
</script>
<?php  } ?>
<?php (!empty($this) && $this instanceof WeModuleSite || 0) ? (include $this->template('common/footer', TEMPLATE_INCLUDEPATH)) : (include template('common/footer', TEMPLATE_INCLUDEPATH));?>
