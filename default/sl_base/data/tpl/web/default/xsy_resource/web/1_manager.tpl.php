<?php defined('IN_IA') or exit('Access Denied');?>

<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/header', TEMPLATE_INCLUDEPATH)) : (include template('common/header', TEMPLATE_INCLUDEPATH));?>
<style>
	th{
		text-align: center;
	}
	li{list-style: none;}
	.progress{ height: 4px; font-size: 0; line-height: 4px; background: orange; width: 0;}
</style>
<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('web/tree', TEMPLATE_INCLUDEPATH)) : (include template('web/tree', TEMPLATE_INCLUDEPATH));?>


<?php  if($_W['role_bool']) { ?>
    <script>
        location.href="<?php  echo $this->createWebUrl('alive')?>";
    </script>
<?php  } ?>

<!-- 添加幻灯片 -->
<div id="modal-web-ad" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
<form action="<?php  echo $this->createWebUrl('manager')?>" method="post" enctype="multipart/form-data">
        <div class="modal-dialog" style="width: 800px;">
        <input type="hidden" name="op" value="setting" />
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3>脚本系统设置</h3>
                </div>
                <div class="modal-body">
					<div class="form-group">
						<label class="col-xs-12 col-sm-2 col-md-2 col-lg-4 control-label">站点维护中</label>
						<div class="">
							<label for="radio_1" class="radio-inline"><input type="radio" name="close" id="radio_1" value="0" <?php  if($_setting['close']==0) { ?>checked<?php  } ?>> 关闭</label>
							<label for="radio_0" class="radio-inline"><input type="radio" name="close" id="radio_0" value="1" <?php  if($_setting['close']==1) { ?>checked<?php  } ?>> 打开</label>
						</div>
					</div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary span2">确  认</button>
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
                </div>
            </div>
        </div>
</form>
</div>
























			<a class="btn btn-default" href="javascript:;" data-toggle="modal" data-target="#modal-web-ad" style="float:right;">
                <i class="fa fa-plus"></i>
                脚本系统设置
             </a>

<div class="panel panel-info" style="">
	<div class="panel-heading">
		筛选
	</div>
	<div class="panel-body" style="padding:10px 0 0 10px">
		<form action="<?php  echo $this->createWebUrl('manager')?>" method="get" class="form-horizontal" role="form" id="form1">
			<input type="hidden" name="c" value="site" /> 
			<input type="hidden" name="a" value="entry" /> 
			<input type="hidden" name="m" value="xsy_resource" />
			<input type="hidden" name="do" id="do" value="manager" />
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
							<a class="btn btn-default" href="<?php  echo $this->createWebUrl('manager')?>">
				首页
			</a>
			</div>
		</form>
	</div>
</div>
<div class="clearfix">
	<div class="panel panel-default">
		<div class="panel-heading">

			<button class="btn btn-default dels">批量删除</button>

			<a class="btn btn-default" href="javascript:;" data-toggle="modal" data-target="#modal-add-ad" onclick="setEdit('','')" style="float:right;">
				<i class="fa fa-plus"></i>
				添加资源文件
			</a>

		</div>
		<div class="panel-body">
			<table class="table table-hover" style="overflow: visible;">
				<thead class="navbar-inner">
					<tr>
						<th width="60px"><input type="checkbox" class="all_select">删？</th>
						<th width="50px">ID</th>
						
						<th width="15%">原始名称</th>
						<th width="20%">当前名称</th>
						<th width="5%">类型</th>
						<th width="15%">上传时间</th>
						<th width="10%">上传用户</th>
						<th style="text-align: right;">说明</th>
						<th>链接</th>
						<!-- <th>一键下载</th> -->

						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<?php  if(is_array($list)) { foreach($list as $row) { ?>
					<tr>
						<td><input type="checkbox" name="dels[]" value="<?php  echo $row['id'];?>" class="cbox"></td>
						<td><?php  echo $row['id'];?></td>
						<td align="center" title="<?php  echo $row['origin_name'];?>"><?php  echo $row['origin_name'];?></td>
						<td align="center" title="<?php  echo $row['name'];?>"><?php  echo $row['name'];?></td>
						<td align="center">
							<?php  if($row['type']=='file') { ?>
							脚本
							<?php  } else if($row['type']=='data') { ?>
							数据
							<?php  } else if($row['type']=='idle') { ?>
							空闲
							<?php  } else if($row['type']=='excel') { ?>
							模板
							<?php  } else { ?>
							未知
							<?php  } ?></td>
						<td align="center">
							<?php  echo date('Y-m-d H:i', $row['time'])?>
						</td>
						<td align="center">
							<?php  echo $this->_getmembername($row['owner_id']);?>
						</td>
						<td align="right" title="<?php  echo $row['info'];?>"><?php  echo $row['info'];?></td>
						
						<td style="overflow:visible;position:relative;" align="center">
							<input type="text"  name="" style="display:none;" value="<?php  echo $resourcepath;?>&id=<?php  echo $row['id'];?>">
							<!-- <input type="text"  name="" style="display:none;" value="<?php  echo $_W['siteroot'].'app/'.substr($this->createmobileUrl('resource', array('id' => $row['id'],'dopost'=>'download')),2)?>"> -->
							<input type="text"  name="" style="display:none;" value="<?php  echo $row['path'];?>">
							<span class="js-clip btn-default btn btn-default btn-sm" style="cursor:pointer">复制链接</span>
<!-- 							<a href="<?php  echo $_W['siteroot'].'app/'.substr($this->createmobileUrl('resource', array('id' => $row['id'],'dopost'=>'download')),2)?>" class="btn btn-default btn-sm" title="下载">
								<i class="fa" style="font-weight: bold;">↓</i>
							</a> -->
							
						</td>

						<td>
							<a href="<?php  echo $this->createWebUrl('manager', array('id' => $row['id'],'op'=>'del'))?>" onclick="return confirm('确认删除?')" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="top" title="删除">
								<i class="fa fa-remove"></i>
							</a>
							<a href="javascript:;" onclick="setreplace('<?php  echo $row['id'];?>','<?php  echo $row['info'];?>','<?php  echo $row['origin_name'];?>')" data-toggle="modal" data-target="#modal-replace-ad" class="btn btn-default btn-sm" title="修改">
								<i class="fa fa-edit"></i>
							</a>
						</td>
					</tr>
					<?php  } } ?>
				</tbody>

			</table>


			<?php  echo $pager;?>
		</div>
	</div>
</div>
<script type="text/javascript" src="./resource/js/lib/plupload.full.min.js"></script>
<!-- 添加幻灯片 -->
<div id="modal-add-ad"   class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
	<form class="form-horizontal form" action="<?php  echo $this->createWebUrl('manager',array(op=>'save'))?>" method="post"  onsubmit="return up_submit()"  enctype="multipart/form-data">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
					<h3>添加脚本</h3>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="col-xs-10 col-sm-3 col-md-3 control-label">文件说明</label>
						<div class="col-sm-6 col-xs-12">
							<input name="info" class="form-control" required id="name"/>
							<input name="id" class="form-control" id="id" type="hidden"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-10 col-sm-3 col-md-3 control-label">上传用户</label>
						<div class="col-sm-6 col-xs-12">
							<select name="owner_id"  class='form-control'>
							<option value=""> </option>
							<?php  if(is_array($_members)) { foreach($_members as $row) { ?>
								<option value="<?php  echo $row['uid'];?>"><?php  echo $row['realname'];?></option>
							<?php  } } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-10 col-sm-3 col-md-3 control-label">文件</label>
						<div class="col-sm-6 col-xs-12">

			<a class="btn btn-default" href="javascript:;"  style="float:right;" id="browse">
				<i class="fa fa-plus"></i>
				选择文件...
			</a>

						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-10 col-sm-3 col-md-3 control-label">类型</label>
						<div class="col-sm-6 col-xs-12">
							<select name="type" class='form-control' >
								<option value="file">脚本文件</option>
								<option value="data">数据文件</option>
								<option value="idle">空闲任务</option>
								<option value="excel">策略模版</option>
							</select>
						</div>
					</div>
					<ul id="file-list">

					</ul>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary span2" name="add-ad" value="yes">确  认</button>
					<a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- 添加幻灯片 -->
<div id="modal-replace-ad"   class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
	<form class="form-horizontal form" action="<?php  echo $this->createWebUrl('manager',array(op=>'replace'))?>" method="post"  enctype="multipart/form-data">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
					<h3>修改脚本</h3>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="col-xs-10 col-sm-3 col-md-3 control-label">文件说明</label>
						<div class="col-sm-6 col-xs-12">
							<input name="info" class="form-control" required id="replace_name"/>
							<input name="id" class="form-control" id="replace_id" type="hidden"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-10 col-sm-3 col-md-3 control-label">文件</label>
						<div class="col-sm-6 col-xs-12">
							<div id="old_div">
								<span id="old_file_name"></span> 
								<a href="javascript:;" onclick="tihuan()" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="top" title="替换">
									<i class="fa fa-remove"></i>
								</a>								
							</div>
							<input type="file" name="file" id="replace_file" value="">
						</div>
					</div>
					<ul id="file-list">

					</ul>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary span2" name="add-ad" value="yes">确  认</button>
					<a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
				</div>
			</div>
		</div>
	</form>
</div>












<script>

function  setreplace(id,name,old_name)
{
	$("#replace_name").val(name);
	$("#replace_id").val(id);
	$("#old_file_name").html(old_name);
	$("#old_div").css('display','');
	$("#replace_file").css('display','none');
}

function tihuan(){
	$("#old_div").css('display','none');
	$("#replace_file").css('display','');
}



$(function(){
	require(['jquery.zclip'], function(){
		$('.js-clip').each(function(){
			var copy_button = this;
			$(copy_button).zclip({
				path: './resource/components/zclip/ZeroClipboard.swf',
				copy: $(copy_button).prev().val(),
				afterCopy: function(){
					$(copy_button).text('复制成功');
					setTimeout(function(){
						$(copy_button).text('复制链接');
					}, 2000);
				}
			});
		});
	});
});


$(".dels").click(function(){
	var bool=confirm("是否确定删除？");
            if(bool){
                var ids="";
                $(".cbox").each(function(){
                    if($(this).prop("checked")){
                        ids += $(this).val()+",";
                    }
               });

               if (ids.length > 0) {
                    ids = ids.substr(0, ids.length - 1);
                }else{
                	alert('请选择要删除的文件');
                    return;
                }

                    window.location.href="<?php  echo $this->createWebUrl('manager',array(op=>'dels'))?>&ids="+ids;
				

                // $.ajax({
                //     url:"<?php  echo $this->createWebUrl('manager',array(op=>'dels'))?>",
                //     type:"get",
                //     data:"ids="+ids,
                //         success:function(){

                //             window.location.reload();
                //         }
                // });
            }
});

    $(".all_select").click(function(){
       var cbox=$(".cbox");
       var bool=$(this).prop("checked");
       $.each(cbox,function(){
            cbox.prop("checked",bool);
        })
    });







</script>


<script>
//实例化一个plupload上传对象  
    var uploader = new plupload.Uploader({  
        browse_button : 'browse', //触发文件选择对话框的按钮，为那个元素id  
        url : "<?php  echo $this->createWebUrl('manager',array(op=>'save'))?>", //服务器端的上传页面地址  
    	flash_swf_url : './resource/js/lib/Moxie.swf',
		silverlight_xap_url : './resource/js/lib/Moxie.xap',

    });      
  uploader.init(); //初始化

	//绑定文件添加进队列事件
	uploader.bind('FilesAdded',function(uploader,files){
		for(var i = 0, len = files.length; i<len; i++){
			var file_name = files[i].name; //文件名
			//构造html来更新UI
			var html = '<li id="file-' + files[i].id +'"><p class="file-name">' + file_name + '</p><p class="progress"></p></li>';
			$(html).appendTo('#file-list');
		}
	});

	//绑定文件上传进度事件
	uploader.bind('UploadProgress',function(uploader,file){
		$('#file-'+file.id+' .progress').css('width',file.percent + '%');//控制进度条
	});


	uploader.bind('BeforeUpload',function(up,file){

		var info=$("input[name=info]").val();
		var owner_id=$("select[name=owner_id]").val();
		var type=$("select[name=type]").val();
		uploader.setOption("multipart_params",{
			"info":info,
			"owner_id":owner_id,
			"type":type,
		});
	});

function up_submit(){

	uploader.start(); //开始上传


	uploader.bind('UploadComplete',function(uploader,files){
		// alert('上传成功');
		// window.location.reload();
	});


	return false;
}




</script>




<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/footer', TEMPLATE_INCLUDEPATH)) : (include template('common/footer', TEMPLATE_INCLUDEPATH));?>
