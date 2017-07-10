<?php
require_once IA_ROOT . '/addons/xsy_resource/device_inc/misc.inc.php';

/*function print_n_array($contact1, $i = 0)
{	
	return;
    //for($row=0; $row<count($contact1); $row++)
    foreach ($contact1 as $key1 => $value1) {   
        //error_log($key1);
        //使用内层循环遍历数组$contact1 中 子数组的每个元素,使用count()函数控制循环次数
        $my_i = $i;
        if ( true == is_array($contact1[$key1]) ){
            $my_i++;
            $my_blank = str_repeat("  ", $i);
            error_log($my_blank . $key1 . "->");
            print_n_array($contact1[$key1], $my_i);
        } 
        else{
            $my_blank = str_repeat("  ", $my_i); 
            error_log( $my_blank . $key1 . " => " . $contact1[$key1]);
        }
        
    }
    //error_log("  ");
}*/

function memc_get_task_list($ms_id){
	return cache_read($ms_id.'_dev_task_list');
}

function memc_get_dev_info($ms_id){
	return cache_read($ms_id.'_dev_info');
}

function memc_get_dev_track_info($ms_id){
	return cache_read($ms_id.'_dev_track_info');
}

function memc_get_user_info($ms_act){	
	return cache_read($ms_act.'_user_info');
}


/*$sql ="select * from ".tablename ( 'ms_alive_table' ).$w."order by id desc";
$count_sql = "select count(*) from " . tablename ( "ms_alive_table" ).$w;
pdo_fetchcolumn ( $count_sql, $params );*/
function del_memc_task_list($ms_id){
	log_info('++++delete '. $ms_id);
	cache_delete($ms_id . '_dev_task_list');
	cache_delete($ms_id . '_dev_info');
	cache_delete($ms_id . '_dev_track_info');
	//kobe add 重置用户内序号 0607
	$ms_id=pdo_fetchcolumn ("SELECT ms_id FROM " .tablename('ms_alive_table') . " WHERE ms_id='".$ms_id."'");
	if(!empty($ms_id)){
		pdo_update("ms_alive_table", 
                    array('ms_index' => 0 ),               
                array("ms_id"=>$ms_id)              
                );
	}
}


//用户更新策略的时候调用清除缓存
function update_user_strategy($ms_act){
	log_info('update_user_strategy: ' . $ms_act);
	cache_delete($ms_act . "_user_info"); //删除用户的cache
	$sql = "select ms_id from ".tablename ( 'ms_alive_table' )." where account='".$ms_act."'";
	$dev_list = pdo_fetchall($sql);
	if (!empty($dev_list))
	{
		foreach ($dev_list as $key => $value) {
			if(!empty($value['ms_id']))
			{
				del_memc_task_list($value['ms_id']);
			}
			# code...
		}
	}
}

//返回设备列表
function get_total_device_list($sql){
	//$sql ="select * from ".tablename ( 'ms_alive_table' ).$w."order by id desc"; //找出alive的table中
	$ms_act_device_list = pdo_fetchall($sql);
	log_info("++++++++++++++");
	log_info($sql);
	print_n_array($ms_act_device_list);
	$act_device_num	= count($ms_act_device_list);
	for ($i=0;  $i < $act_device_num;  $i++) {
		$dev_info = cache_read($ms_act_device_list[$i]['ms_id'].'_dev_info');
		if( empty($dev_info)  ){ continue;}
		else{
			$ms_alive_device_list[] = $ms_act_device_list[$i];
		}
	}
	return $ms_alive_device_list;  
}

/*//$list = pdo_fetchall ( "$sql limit " . (($pindex - 1) * $psize) . ",$psize", $params );
function get_task_list($ms_act_list){
	$act_num		= count($ms_act_list);
	$task_list 		= array();
	for ($i=0; $i < $act_num; $i++) {
		$my_task_list = cache_read($ms_act_list[$i].'_dev_task_list');
		$task_count = count($my_task_list); 
		for ($m=0; $m <$task_count; $m++) { 
			# code...
			$task_list[] = $my_task_list[$m];
		}
		# code...
	}
	return $task_list;
		# code...
}*/

//得到page内容
function get_task_list_by_page($ms_act_device_list, $page_size, $page_index){ //
	$act_device_num	= count($ms_act_device_list); //总设备的数量
	$task_list 		= array();
	$begin_index	= $page_size * ($page_index - 1); //index 必须比1大
	$end_index      = $begin_index + $page_size -1; 
	$task_index     = 0;
	//$m = 0;
	
	log_info("++++".$page_size."_______". $page_index);
	//print_n_array($ms_act_device_list);
	for ($i=0;  $i < $act_device_num;  $i++) {
		if($i >= $begin_index && $i <= $end_index)
		{
			$dev_info 		= cache_read($ms_act_device_list[$i]['ms_id'].'_dev_info');
			$dev_task_list 	= cache_read($ms_act_device_list[$i]['ms_id'].'_dev_task_list');
			$user_info 		= cache_read($ms_act_device_list[$i]['account'].'_user_info');
			# code...		
			$my_task_list[$i]['id'] = $i +1 ;
			//$my_task_list[$m]['user'] = $ms_act_list[$i]['account'];
			
			$strategy_name = pdo_fetchcolumn ("SELECT name FROM " .tablename('ms_strategy') . 
				" WHERE id= '".$user_info['strategy_id']."'");
			$my_task_list[$i]['strategy_name'] = $strategy_name;

			//$task_id = $dev_task_list[$m]['task_id'];
			$task_name = pdo_fetchcolumn ("SELECT origin_name FROM " .tablename('xsy_resource_file') . 
				" WHERE id= '".$dev_task_list[$i]['task_id']."'" );
			$my_task_list[$i]['task_name'] 	= $task_name;
			$my_task_list[$i]['account']    = $ms_act_device_list[$i]['account'];
			$my_task_list[$i]['ms_id']    	= $ms_act_device_list[$i]['ms_id'];
			$my_task_list[$i]['ms_type']    = $ms_act_device_list[$i]['ms_type'];

			$my_task_list[$i]['time']     	= $dev_info['time'];
			$my_task_list[$i]['task_index'] = $dev_info['task_index'];
			$my_task_list[$i]['task_num']	= $user_info['task_num'];
			$my_task_list[$i]['ip'] 		= $dev_info['ip'];
			$task_list[] = $my_task_list[$i];
			
		}
		//$m++;
	}	
	print_n_array($task_list);
	log_info("++++".$page_size."-------". $page_index);
	return $task_list;
}




function get_task_list_by_all($ms_act_device_list){ //
	$act_device_num	= count($ms_act_device_list); //总设备的数量
	$task_list 		= array();

	for ($i=0;  $i < $act_device_num;  $i++) {

			$dev_info 		= cache_read($ms_act_device_list[$i]['ms_id'].'_dev_info');
			$dev_task_list 	= cache_read($ms_act_device_list[$i]['ms_id'].'_dev_task_list');
			$user_info 		= cache_read($ms_act_device_list[$i]['account'].'_user_info');
			# code...		
			$my_task_list[$i]['id'] = $i +1 ;
			//$my_task_list[$m]['user'] = $ms_act_list[$i]['account'];
			
			$strategy_name = pdo_fetchcolumn ("SELECT name FROM " .tablename('ms_strategy') . 
				" WHERE id= '".$user_info['strategy_id']."'");
			$my_task_list[$i]['strategy_name'] = $strategy_name;

			//$task_id = $dev_task_list[$m]['task_id'];
			$task_name = pdo_fetchcolumn ("SELECT origin_name FROM " .tablename('xsy_resource_file') . 
				" WHERE id= '".$dev_task_list[$i]['task_id']."'" );
			$my_task_list[$i]['task_name'] 	= $task_name;
			$my_task_list[$i]['account']    = $ms_act_device_list[$i]['account'];
			$my_task_list[$i]['ms_id']    	= $ms_act_device_list[$i]['ms_id'];

			$my_task_list[$i]['ms_type']    = $ms_act_device_list[$i]['ms_type'];

			$my_task_list[$i]['time']     	= $dev_info['time'];
			$my_task_list[$i]['task_index'] = $dev_info['task_index'];
			$my_task_list[$i]['task_num']	= $user_info['task_num'];
			$my_task_list[$i]['ip'] 		= $dev_info['ip'];
			$task_list[] = $my_task_list[$i];

	}	
	//print_n_array($task_list);
	log_info("++++".$page_size."-------". $page_index);
	return $task_list;
}