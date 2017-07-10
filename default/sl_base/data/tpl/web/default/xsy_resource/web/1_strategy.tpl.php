<?php defined('IN_IA') or exit('Access Denied');?><?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/header', TEMPLATE_INCLUDEPATH)) : (include template('common/header', TEMPLATE_INCLUDEPATH));?>
<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('web/tree', TEMPLATE_INCLUDEPATH)) : (include template('web/tree', TEMPLATE_INCLUDEPATH));?>
<style>
    .form-control{
        display:inline;
        width:50%;
    }
    .task_box{
        width:20px;
        height:20px;
    }
    .data_select{
        width:100%;
    }

</style>
<div class="clearfix">
    <div class="panel panel-default">
        <div class="panel-heading">

            <a class="btn btn-default" href="javascript:;" data-toggle="modal" data-target="#modal-strategy-ad" onclick="setEdit('','')">
                <i class="fa fa-plus"></i>
                新增策略
            </a>

        </div>
        <div class="panel-body">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>

                                    <th width="5%">id</th>
                                    <th>名称</th>
                                    <th>制定者</th>
                                    <th>总时间</th>
                                    <th>扣点</th>
                                    <th>随机</th>
                                    <th>空闲任务</th>
                                    <th>模板</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php  if(is_array($strategy)) { foreach($strategy as $row) { ?>
                                <tr>
                                    <td><?php  echo $row['id'];?></td>
                                    <td><?php  echo $row['name'];?></td>
                                    <td><?php  echo $this->_getusername($row['owner'])?></td>
                                    <td><?php  echo $row['full_time'];?> 秒</td>
                                    <td><?php  echo $row['cost'];?> 点</td>
                                    <td><?php  if($row['is_ramd']==1) { ?>是<?php  } else { ?>否<?php  } ?></td>
                                    <td><?php  echo $this->_gettaskname($row['idle']);?></td>
                                    <td><?php  echo $this->_gettaskname($row['temple_name']);?></td>
                                    <td>
                                        <a href="javascript:;" onclick="show_task('<?php  echo $row['name'];?>','<?php  echo $row['info'];?>',<?php  echo $row['id'];?>)" data-toggle="modal" data-target="#modal-see-ad" class="btn btn-default btn-sm">查看</a>
                                        <a href="javascript:;" onclick="edit_task('<?php  echo $row['name'];?>',<?php  echo $row['id'];?>)" data-toggle="modal" data-target="#modal-strategy-ad" class="btn btn-default btn-sm">编辑</a>
                                        <a href="<?php  echo $this->createWebUrl('strategy',array('dopost'=>'del','id'=>$row['id']))?>" onclick="return confirm('确认删除?')" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="top" title="删除">
                                            <i class="fa fa-remove"></i>
                                        </a>
                                    </td>
                                </tr>
                                <?php  } } ?>
                            </tbody>
                        </table>
        </div>
    </div>
</div>




<script>

function edit_task(name,id){
    $("#strategy_name").html(name);
    $("#id").val(id);
    var data="id="+id;
    $.getJSON("<?php  echo $this->createWebUrl('strategy',array('dopost'=>'get_edit','op'=>'tasklist'))?>",data, function(json){

        $("#task_list").html('');
        $.each(json,function(i,result){
            var count=10;
            var sort="<option value='"+result['task_pri']+"'>"+result['task_pri']+"</option><option value='0'>优先级</option>";
            for (var i=1;i<=count;i++){
              sort=sort + '<option value="'+i+'">'+i+'</option>';
            }
            var str='<input name="task_time[]" type="text" class="form-control task_time" required style="width:70px;" value="'+result['task_time']+'"/> 秒 <input name="task_num[]" type="text" class="form-control task_num" required style="width:50px;" value="'+result['task_num']+'"/> 次 '+'<select name="task_pri[]" class="form-control task_pri" style="width:80px;padding-right:0px;">'+sort+'</select>';

            $("#task_list").append("<tr><td align='center'><input type='hidden' name='ms_task_index[]' value='"+result['id']+"'>"+result['id']+"</td><td title='"+result['origin_name']+"'>"+result['origin_name']+"</td><td title='"+result['info']+"'>"+result['info']+"</td><td style='align:center;'>"+str+"</td><td align='center'><select name='task_d_id[]'  class='form-control data_select'><option value='"+result['task_d_id']+"'  title='"+result['task_d_info']+"'>"+result['task_d_name']+"</option><option value='0'></option><?php  if(is_array($data_list)) { foreach($data_list as $d_row) { ?><option value='<?php  echo $d_row['id'];?>' title='<?php  echo $d_row['info'];?>'><?php  echo $d_row['origin_name'];?></option><?php  } } ?></select></td><td><a href='javascript:;' class='btn btn-default btn-sm' onclick='del_task(this)' title='删除'><i class='fa fa-remove'></i></a></td></tr>");
        });

    }); 

    $.ajax({
        url:"<?php  echo $this->createWebUrl('strategy',array('dopost'=>'get_edit','op'=>'strategyinfo'))?>",
        dataType:'json',
        data:{
          id:id
        },
        success:function(data){
            $("#full_time").val(data.full_time);
            $("#cost").val(data.cost);
            $("#form-name").val(data.name);
            $("#form-info").val(data.info);  
            if(data.is_ramd==1){
                $("#form-is_ramd").attr('checked',true);  
            }else{
                $("#form-not_ramd").attr('checked',true);  
            }
        }
    })

    $("#form-idle").hide();
    $("#form-excel").hide();


}













    function show_task(name,info,id){
        

       // $.ajax({//获取
       //       url:"<?php  echo $this->createWebUrl('strategy')?>",
       //       type:'post',
       //       data:{
       //          id:id,
       //         dopost:'get_strategy_name',
       //       },success:function(msg){
       //          $(".strategy_name").html(msg);
       //       }
       // })

            


        $(".strategy_name").html(name);
        $(".strategy_info").html(info);
        $("#allot").html("");
        var data="id="+id;  
            $.getJSON("<?php  echo $this->createWebUrl('strategy',array('dopost'=>'show_task'))?>",data, function(json){
                    $.each(json,function(i,result){

                            item = "<tr><td>"+result['task_pri']+"</td><td>"+result['task_id']+"</td><td>"+result['task_d_id']+"</td><td>"+result['task_num']+"</td><td>"+result['task_time']+" s</td></tr>"; 
                        $('#allot').append(item); 
                    });

            });
        /*传递值到弹出框 by kobe*/
        $(".class_download_strategy").attr("strage-id", id);
        alert("id = " + $id );

    }
    //kobe add some info
     $(".class_download_strategy").click(function(){
             var id = $(this).attr("strage-id");
             console.log("click_id = " + id );
             $.ajax({
                url:"<?php   echo $this->createWebUrl('strategy',array('dopost'=>'download_strategy'))?>",
                dataType:'json',
                data:{
                  id:id
            },
            success:function(data){
                 window.location.href=data;
            }
        })
            //alert(ip);
       
        });
     /*       $('.class_download_strategy').click(function(){
             var id = $(this).attr("strage-id");
            $.post("<?php   echo url('mc/member/download');?>", {uid: uid}, function(data){
                if(data == 'error'){
                    alert('下载失败，用户未绑定策略或该策略无模板');
                }else if(data == 'othererror') {
                    alert('未知错误');
                }else{
                    window.location.href=data;
                }
            }); 
        });*/
function dl_strategy(){
    var id = $(".class_download_strategy").attr("strage-id");
             console.log("click_tttid = " + id );
              var data="id="+id;  
            $.getJSON("<?php   echo $this->createWebUrl('strategy',array('dopost'=>'download_strategy'))?>",data, function(json){
               window.location.href=json;            
            });
}

</script>




<!-- 添加幻灯片 -->
<div id="modal-strategy-ad" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
    <form class="form-horizontal form" onsubmit="return check()" action="<?php  echo $this->createWebUrl('strategy',array('dopost'=>'add'))?>" method="post" enctype="multipart/form-data">
        <div class="modal-dialog" style="width: 1200px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3 id="strategy_name"></h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" id="id" value="">
                    <div class="form-group">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>
                                    <th width="100px" style="text-align: center;">脚本编号</th>
                                    <th width="20%">任务原始名称</th>
                                    <th width="20%">说明</th>
                                    <th width="20%"></th>
                                    <th width="20%"style="text-align: center;">添加数据</th>
                                    <th width="50px"></th>
                                </tr>
                            </thead>
                            <tbody id="task_list">
<!--                                 <?php  if(is_array($task_list)) { foreach($task_list as $row) { ?>
                                <tr>
                                    <td style="align:center;">
                                        <input type="checkbox" class="form-control task_box" name="ms_task_index[]" value="<?php  echo $row['id'];?>">
                                        <span class="time_box"></span>
                                    </td>
                                    <td align="center"><?php  echo $row['id'];?></td>
                                    <td title="<?php  echo $row['origin_name'];?>"><?php  echo $row['origin_name'];?></td>
                                    <td title="<?php  echo $row['info'];?>"><?php  echo $row['info'];?></td>
                                    <td align="center">            
                                        <select name="task_d_id[]"  class="form-control data_select">
                                            <option value="0"></option>
                                            <?php  if(is_array($data_list)) { foreach($data_list as $d_row) { ?>
                                            <option value="<?php  echo $d_row['id'];?>"><?php  echo $d_row['origin_name'];?></option>
                                            <?php  } } ?>
                                        </select>
                                    </td>
                                </tr>
                                <?php  } } ?> -->
                            </tbody>
                        </table>
                        <div style="text-align:center;">
                            <a class="btn btn-default" href="javascript:;" data-toggle="modal" data-target="#modal-task-ad">
                                <i class="fa fa-plus"></i>
                                添加任务
                            </a>                            
                        </div>

                        <div class="form-group" id="form-idle">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">空闲任务</label>
                            <div class="col-sm-3 col-xs-12">
                                <a class="btn btn-default" href="javascript:;" data-toggle="modal" data-target="#modal-idle-ad" style="display:inline-block;float:left;">
                                    <i class="fa fa-plus"></i>
                                    选择
                                </a>
                                <span id="idle" style="margin-left: 10px;line-height: 35px;">
                                    
                                </span>
                                <input type="hidden" name="idle" value=""/>
                                
                            </div>
                        </div>

                        <div class="form-group" id="form-excel">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">数据模板</label>
                            <div class="col-sm-3 col-xs-12">
                                <a class="btn btn-default" href="javascript:;" data-toggle="modal" data-target="#modal-excel-ad" style="display:inline-block;float:left;">
                                    <i class="fa fa-plus"></i>
                                    选择
                                </a>
                                <span id="excel" style="margin-left: 10px;line-height: 35px;">
                                </span>
                                <input type="hidden" name="excel" value=""/>
                                
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">执行一轮时间</label>
                            <div class="col-sm-3 col-xs-12">
                                <input name="full_time" class="form-control" required id="full_time"/> 秒
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">扣点数</label>
                            <div class="col-sm-6 col-xs-12">
                                <input name="cost" class="form-control" required id="cost"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">是否随机</label>
                            <div class="col-sm-6 col-xs-12">
                                <input type="radio" name="is_ramd" class="form-control" required style="height:15px;width:20px" checked value="1" id="form-is_ramd"/> 是
                                <input type="radio" name="is_ramd" class="form-control" required style="height:15px;width:20px"  value="0" id="form-not_ramd"/> 否
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">名称</label>
                            <div class="col-sm-6 col-xs-12">
                                <input name="name" id="form-name" class="form-control" required id="name" style="width:50%"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">说明</label>
                            <div class="col-sm-6 col-xs-12">
                                <input name="info" id="form-info" class="form-control" required id="info" style="width:100%"/>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary span2" name="add-ad" value="yes" id="is_ok">确  认</button>
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
                </div>
            </div>
        </div>
    </form>
</div>


<!-- 查看策略 -->
<div id="modal-see-ad" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
        <div class="modal-dialog" style="width: 80%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3 class="strategy_name"></h3>
                    <!-- <h5 class="strategy_info"></h5> -->
                    <label class="strategy_info"></label>
                    <!-- "<?php   echo $row['ip'];?>" -->
                    <button class="class_download_strategy" style="float:right;" strage-id=0  onclick="dl_strategy()" >下载</button>
                </div>
                <div class="modal-body">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>
                                  <th>优先级</th>
                                  <th>脚本id</th>
                                  <th>数据id</th>
                                  <th>运行次数</th>
                                  <th>任务运行时间</th>
                                </tr>
                            </thead>
                            <tbody id="allot">
                                
                            </tbody>
                        </table>


                </div>
                <div class="modal-footer">
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
                </div>
            </div>
        </div>
</div>






<!-- 添加幻灯片 -->
<div id="modal-task-ad" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
        <div class="modal-dialog" style="width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3>脚本列表</h3>
                </div>
                <div class="modal-body">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>
                                    <th width="100px" style="text-align: center;">脚本编号</th>
                                    <th width="30%">任务原始名称</th>
                                    <th width="30%">说明</th>
                                    <th width="100px"></th>

                                </tr>
                            </thead>
                            <tbody>
                                <?php  if(is_array($task_list)) { foreach($task_list as $row) { ?>
                                
                                <tr>
                                    <td align="center">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['id'];?></label>
                                    </td>
                                    <td title="<?php  echo $row['origin_name'];?>">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['origin_name'];?></label>
                                    </td>
                                    <td title="<?php  echo $row['info'];?>">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['info'];?></label>
                                    </td>
                                    <td>
                                        <input type="radio" name="task-radio" id="<?php  echo $row['id'];?>"  value="<?php  echo $row['id'];?>" style="width:20px;height:20px">
                                    </td>
                                </tr>
                                
                                <?php  } } ?>
                            </tbody>
                        </table>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary span2" onclick="choose()" >确  认</button>
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
                </div>
            </div>
        </div>
</div>


<!-- 添加幻灯片 -->
<div id="modal-idle-ad" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
        <div class="modal-dialog" style="width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3>空闲任务列表</h3>
                </div>
                <div class="modal-body">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>
                                    <th width="100px" style="text-align: center;">脚本编号</th>
                                    <th width="30%">任务原始名称</th>
                                    <th width="30%">说明</th>
                                    <th width="100px"></th>

                                </tr>
                            </thead>
                            <tbody>
                                <?php  if(is_array($idle_list)) { foreach($idle_list as $row) { ?>
                                
                                <tr>
                                    <td align="center">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['id'];?></label>
                                    </td>
                                    <td title="<?php  echo $row['origin_name'];?>">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['origin_name'];?></label>
                                    </td>
                                    <td title="<?php  echo $row['info'];?>">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['info'];?></label>
                                    </td>
                                    <td>
                                        <input type="radio" name="idle-radio" id="<?php  echo $row['id'];?>"  value="<?php  echo $row['id'];?>" style="width:20px;height:20px">
                                    </td>
                                </tr>
                                
                                <?php  } } ?>
                            </tbody>
                        </table>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary span2" onclick="choose_idle()"  data-dismiss="modal" aria-hidden="true">确  认</button>
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
                </div>
            </div>
        </div>
</div>

<!-- 添加幻灯片 -->
<div id="modal-excel-ad" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="width: 100%; margin: 0px auto;">
        <div class="modal-dialog" style="width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3>数据模板列表</h3>
                </div>
                <div class="modal-body">
                        <table class="table table-hover" style="overflow: visible;">
                            <thead class="navbar-inner">
                                <tr>
                                    <th width="100px" style="text-align: center;">编号</th>
                                    <th width="30%">原始名称</th>
                                    <th width="30%">说明</th>
                                    <th width="100px"></th>

                                </tr>
                            </thead>
                            <tbody>
                                <?php  if(is_array($excel_list)) { foreach($excel_list as $row) { ?>
                                
                                <tr>
                                    <td align="center">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['id'];?></label>
                                    </td>
                                    <td title="<?php  echo $row['origin_name'];?>">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['origin_name'];?></label>
                                    </td>
                                    <td title="<?php  echo $row['info'];?>">
                                        <label for="<?php  echo $row['id'];?>"><?php  echo $row['info'];?></label>
                                    </td>
                                    <td>
                                        <input type="radio" name="excel-radio" id="<?php  echo $row['id'];?>"  value="<?php  echo $row['id'];?>" style="width:20px;height:20px">
                                    </td>
                                </tr>
                                
                                <?php  } } ?>
                            </tbody>
                        </table>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary span2" onclick="choose_excel()"  data-dismiss="modal" aria-hidden="true">确  认</button>
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关  闭</a>
                </div>
            </div>
        </div>
</div>


<script>

function choose(){
    var id = $('input:radio[name="task-radio"]:checked').val();
    
    $.ajax({
        url:"<?php  echo $this->createWebUrl('strategy',array('dopost'=>'select'))?>",
        dataType:'json',
        data:{
          id:id
        },
        success:function(data){
            // var count=<?php  echo $count;?>;
            var count=10;
            var sort='<option value="0">优先级</option>';
            for (var i=1;i<=count;i++){
              sort=sort + '<option value="'+i+'">'+i+'</option>';
            }


            var str='<input name="task_time[]" type="text" class="form-control task_time" required style="width:70px;"/> 秒 <input name="task_num[]" type="text" class="form-control task_num" required style="width:50px;"/> 次 '+'<select name="task_pri[]" class="form-control task_pri" style="width:80px;padding-right:0px;">'+sort+'</select>';

            $("#task_list").append("<tr><td align='center'><input type='hidden' name='ms_task_index[]' value='"+data.id+"'>"+data.id+"</td><td title='"+data.origin_name+"'>"+data.origin_name+"</td><td title='"+data.info+"'>"+data.info+"</td><td style='align:center;'>"+str+"</td><td align='center'><select name='task_d_id[]'  class='form-control data_select'><option value='0'></option><?php  if(is_array($data_list)) { foreach($data_list as $d_row) { ?><option value='<?php  echo $d_row['id'];?>' title='<?php  echo $d_row['info'];?>'><?php  echo $d_row['origin_name'];?></option><?php  } } ?></select></td><td><a href='javascript:;' class='btn btn-default btn-sm' onclick='del_task(this)' title='删除'><i class='fa fa-remove'></i></a></td></tr>");
        }
    })
    $('#modal-strategy-ad').css('overflow-y','auto');
}

function del_task(d){
    $(d).parent().parent().remove();
}

function choose_idle(){
    var id = $('input:radio[name="idle-radio"]:checked').val();
    $.ajax({
        url:"<?php  echo $this->createWebUrl('strategy',array('dopost'=>'select'))?>",
        dataType:'json',
        data:{
          id:id
        },
        success:function(data){
            $("#idle").html(data.origin_name+" - "+data.info);
            $('input[name=idle]').val(id);
        }
    })

}


function choose_excel(){
    var id = $('input:radio[name="excel-radio"]:checked').val();
    $.ajax({
        url:"<?php  echo $this->createWebUrl('strategy',array('dopost'=>'select'))?>",
        dataType:'json',
        data:{
          id:id
        },
        success:function(data){
            $("#excel").html(data.origin_name+" - "+data.info);
            $('input[name=excel]').val(id);
        }
    })

}

function  setEdit(id,name)
{
    $("#strategy_name").html('新增策略');
    $("#id").val('');
    $("#task_list").html('');
    $("#full_time").val('');
    $("#cost").val('');
    $("#form-name").val('');
    $("#form-info").val('');  
    $("#form-idle").show();
    $("#form-excel").show();
    $("#edit_name").val(name);
    $("#edit_id").val(id);
}

function  check(){
   var task_time= $(".task_time");
  for(var i=0;i<task_time.length;i++){
    if(isNaN(task_time[i].value)){
        alert("第"+(i+1)+"个脚本时间需填 数字");
        return false;
    }
  }

   var task_pri= $(".task_pri");
  for(var i=0;i<task_pri.length;i++){
    if(task_pri[i].value==0){
        alert("第"+(i+1)+"个排序不能为空");
        return false; 
    }
  }

    // if($('input[name=idle]').val()==""){
    //     alert("请选择一个空闲任务");
    //     return false; 
    // }



 if(isNaN($("#full_time").val())){
        alert("执行一轮时间需填 数字");
        return false; 
 }

 if(isNaN($("#cost").val())){
        alert("扣点数时间需填 数字");
        return false; 
 }


}


</script>

<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/footer', TEMPLATE_INCLUDEPATH)) : (include template('common/footer', TEMPLATE_INCLUDEPATH));?>
