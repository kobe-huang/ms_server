<?php defined('IN_IA') or exit('Access Denied');?><?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/header', TEMPLATE_INCLUDEPATH)) : (include template('common/header', TEMPLATE_INCLUDEPATH));?>
<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('web/tree', TEMPLATE_INCLUDEPATH)) : (include template('web/tree', TEMPLATE_INCLUDEPATH));?>
<style>

.graph{
position:relative;
background-color:#F0EFEF;
border:1px solid #cccccc;
padding:2px;
font-size:13px;
font-weight:700;
}
.graph span{
    text-align: right;
    color:#333;
}
.graph .orange, .green, .blue, .red, .black{
position:relative;
text-align:left;
color:#ffffff;
height:18px;
line-height:18px;
font-family:Arial;
display:block;
}
.graph .orange{background-color:#ff6600;}
.graph .green{background-color:#66CC33;}
.graph .blue{background-color:#3399CC;}
.graph .red{background-color:red;}
.graph .black{background-color:#555;}
</style>
<div class="clearfix">
    <div class="panel panel-default">
    <div class="panel-heading">
        <button class="btn btn-default task_dels">批量重置</button>
        <button class="btn btn-default down_alive" style='float:right;'>导出状态</button>
    </div>   
        <div class="panel-body">
            <table class="table table-hover" style="overflow: visible;">
                <thead class="navbar-inner">
                    <tr>
                        <th width="4%"><input type="checkbox" class="all_select">全选</th>
                        <th width="3%">ID</th>
                        <th width="7%">用户</th>
                        <th width="10%">序号</th>
                        <th width="4%">型号</th>
                        <th width="9%">IP</th>
                        <th>脚本</th>
                        <th>策略</th>
                        <th width="8%">执行时间</th>
                        <th width="12%">进度</th>
                        <th width="6%" style="text-align: center;">操作</th>
                        <th width="4%" style="text-align: center;">统计</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <?php  if(is_array($list)) { foreach($list as $row) { ?>
                    <tr>
                        <td><input type="checkbox" name="task_dels[]" value="<?php  echo $row['ms_id'];?>" class="cbox"></td>
                        <td><?php  echo $row['id'];?></td>
                        <td><?php  echo $row['account'];?></td>
                        <td><?php  echo $row['ms_id'];?></td>
                        <td><?php  echo $row['ms_type'];?></td>
                        <td>
                            <span class="ip_address" data = "<?php  echo $row['ip'];?>" >
                                <?php   echo $row['ip'];?>
                            </span>
                        </td>

                        <td><?php  echo $row['task_name'];?></td>
                        <td><?php  echo $row['strategy_name'];?></td>
                        <td><?php  echo date('m-d H:i:s', $row['time'])?></td>
                        <td>
                            <div class="graph">
                                <span class="blue" style="width:<?php  echo intval(intval($row['task_index'])/intval($row['task_num'])*100) ?>%;">&nbsp;<?php  echo $row['task_index']?></span>
                            </div>
                        </td>
                        <td style="text-align: center;">
                            <span class="btn-default btn btn-default btn-sm"  onclick="return showinfo('<?php  echo $row['ms_id'];?>')">查看任务</span>
                            <!-- <span class="btn-default btn btn-default btn-sm"  onclick="reset('<?php  echo $row['ms_id'];?>')">重置</span> -->
                        </td> 
                        <td style="text-align: center;">
                            <span class="btn-default btn btn-default btn-sm"  onclick="return show_track_info('<?php  echo $row['ms_id'];?>')">统计</span>
                            <!-- <span class="btn-default btn btn-default btn-sm"  onclick="reset('<?php  echo $row['ms_id'];?>')">重置</span> -->
                        </td>                      
                    </tr>
                    <?php  } } ?>
                    <?php  if(empty($list)) { ?>
                    <tr><td colspan="9" align="center">暂无运行中的终端</td></tr>
                    <?php  } ?>
                </tbody>
            </table>
            <?php  echo $pager;?>
        </div>
    </div>
</div>

<style type="text/css">
        #bg{ display: none;  position: fixed;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);}
        #bg_track{ display: none;  position: fixed;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);}
        #show{display: none;  position: absolute; width: 80%; top:10px;  padding: 8px;  border: 8px solid #E8E9F7;  background-color: white;float: left;  z-index:1002;  overflow: auto;}
        #show_track_info{display: none;  position: absolute; width: 80%; top:10px;  padding: 8px;  border: 8px solid #E8E9F7;  background-color: white;float: left;  z-index:1002;  overflow: auto;}
        #showinfo tr th,#showinfo tr td,#loadfahuo tr th{text-align: center;}
</style>

<div id="bg"></div>
<div id="show">
    <table class="table table-striped table-bordered table-condensed" id="showinfo">
        <tr>
            <th width="5%">排序</th>
          <th width="5%">优先级</th>
          <th width="25%">脚本id</th>
          <th width="10%">数据id</th>
          <th width="12%">任务运行时间</th>
          <th width="12%">运行时间</th>
        </tr>


    </table>

      <button type="reset" class="btn btn-xs btn-success" onclick="hidediv();" style="float:right;">关闭</button>

</div>

<div id="bg_track"></div>
<div id="show_track_info">
    <table class="table table-striped table-bordered table-condensed" id="show_track">
<!--         <tr>
    <th width="5%">排序</th>
  <th width="5%">优先级</th>
  <th width="25%">脚本id</th>
  <th width="10%">数据id</th>
  <th width="12%">任务运行时间</th>
  <th width="12%">运行时间</th>
</tr> -->
    </table>
      <button type="reset" class="btn btn-xs btn-success" onclick="hidediv_track();" style="float:right;">关闭</button>
</div>


<script language="javascript" type="text/javascript">

      function showinfo(id) {
        $("#showinfo tr").eq(0).nextAll().remove();
        var data="ms_id="+id;
          $.getJSON("<?php  echo $this->createWebUrl('alive',array(op=>'showinfo'))?>",data, function(json){
                    $.each(json,function(i,result){

                            item = "<tr><td>"+(i+1)+"</td><td>"+result['task_pri']+"</td><td>"+result['task_id']+"</td><td>"+result['task_data_id']+"</td><td>"+result['task_time']+" s</td><td>"+result['time']+" s</td></tr>"; 
                        $('#showinfo').append(item); 
                        $('#showinfo').css('display','');
                    });

          }); 
            document.getElementById("bg").style.display ="block";
            document.getElementById("show").style.display ="block";
            $('body,html').animate({ scrollTop: 0 }, 200);
      }

    function show_track_info(id) {
        $("#show_track tr").eq(0).nextAll().remove();
        var data="ms_id="+id;
          $.getJSON("<?php  echo $this->createWebUrl('alive',array(op=>'show_track_info'))?>",data, function(json){
                    $.each(json,function(i,result){
                        item = "<tr><td>"+(i+1)+"</td><td>"+result['track_key']+"</td><td>"+result['track_value']+" s</td></tr>"; 
                        $('#show_track').append(item); 
                        $('#show_track').css('display','');
                    });

          }); 
            document.getElementById("bg_track").style.display ="block";
            document.getElementById("show_track_info").style.display ="block";
            $('body,html').animate({ scrollTop: 0 }, 200);
      }

      function hidediv() {
            document.getElementById("bg").style.display ='none';
            document.getElementById("show").style.display ='none';
            $("#showinfo tr").eq(0).nextAll().remove();
            $('#showinfo').css('display','none'); 

      }
       function hidediv_track() {
            document.getElementById("bg_track").style.display ='none';
            document.getElementById("show_track_info").style.display ='none';
            $("#show_track_info tr").eq(0).nextAll().remove();
            $('#show_track_info').css('display','none'); 
      }

    $(".task_dels").click(function(){
        var bool=confirm("是否确定重置？");
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
                alert('请选择要重置的任务');
                return;
            }
            window.location.href="<?php  echo $this->createWebUrl('alive',array(op=>'task_list_dels'))?>&ids="+ids;
        }
    });


    $(".all_select").click(function(){
       var cbox=$(".cbox");
       var bool=$(this).prop("checked");
       $.each(cbox,function(){
            cbox.prop("checked",bool);
        })
    });

    $(".down_alive").click(function(){
        window.location.href="<?php  echo $this->createWebUrl('alive',array(op=>'down_alive'))?>";
    });

    $(".ip_address").mouseover(function(e){
        var ip = $(this).attr("data");
        var province = '' ;  
        var city = '' ;  

        $.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=' + ip, function(_result) {
            if (remote_ip_info.ret == '1') {
                /*alert('国家：' + remote_ip_info.country + "\r\n省：" + remote_ip_info.province + "\r\n市：" + remote_ip_info.city + '区：' + remote_ip_info.district + 'ISP：' + remote_ip_info.isp + '类型：' + remote_ip_info.type + '其他：' + remote_ip_info.desc);*/
                province = remote_ip_info.province;
                city = remote_ip_info.city;
            } else {
                /*alert('没有找到匹配的IP地址信息！');*/
                province = 'none'; 
                city = 'none';
            }
            var mydiv = document.createElement("div"); 
            mydiv.setAttribute("id","hint"); 
           // mydiv.style.position="absolute"; 
            mydiv.style.position   ="absolute"; 
            mydiv.style.lineHeight ="15px"; 
            mydiv.style.width      ="130px"; 
 /*           mydiv.style.borderStyle="solid"; 
            mydiv.style.borderColor="#000000"; 
            mydiv.style.borderWidth="1px";   */
            mydiv.style.height  ="20px"; 
            mydiv.style.display ="none"; 
            document.body.appendChild(mydiv); 
           
            var myhint = document.getElementById("hint");
            myhint.style.display= "block";
            myhint.style.left= e.clientX+"px";
            myhint.style.top = e.clientY+"px";
            myhint.style.color = "#F10F20";
            myhint.innerHTML= province + city;          
        });   
        //alert(ip);      
    });

    $(".ip_address").mouseout(function(){
         var ip = $(this).attr("data");
        //alert(ip);
         document.removeEventListener("mousemove");
         document.getElementById("hint").innerHTML = ""; 
         document.getElementById("hint").style.display ='none';
    });
   

</script>
<?php (!empty($this) && $this instanceof WeModuleSite || 1) ? (include $this->template('common/footer', TEMPLATE_INCLUDEPATH)) : (include template('common/footer', TEMPLATE_INCLUDEPATH));?>
