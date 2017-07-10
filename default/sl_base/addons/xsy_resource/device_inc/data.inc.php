<?php
$dev_msg_info  = array(
		 'ms_id' 		=> "ABCDEFG12345678"
		,'ms_type' 		=> "ip4"   // ip4,ip4s,ip5,ip5c,ip5s,ip6.ip6s
	    ,'ms_act' 		=> "kobe"
	    ,'ms_pwd' 		=> "H11111111h"
	    ,'ms_token' 	=> "shunliantianxia12345"
 );

$user_id_r_info = array(
	'user_config_path'=>'', 
	'idle_task'=>"",     //必须要有
	'strategy_id'=>'',	 //必须要有 
	'task_num'=>'',      //任务的总个数
	'user_id'
);

$dev_id_r_dev_task_list = array(
			array(  //任务
			'task_id'                =>'task_id',
			'task_path'              =>'task_path',
			'task_data_id'           =>'task_data_id',
			'task_data_path'         =>'task_data_path',
			'time'                   =>'',
			'task_pri'				 =>'', //任务优先级，给前端显示用
			'task_time'    			 =>'' // 任务执行时间，给前端显示用
			) 
		);

$dev_id_rw_info	= array(
	'task_index' => 0,  //当前任务的序号
	'task_id'=>0,    	//任务ID给前端使用
	'time' => 0 ,       //最近一次正常请求时间
	'token' =>'',       //token
	'user_id' =>''      //用户的id
);

$g_info = array(    			//全局的数据
	'is_close_ms_server' => false
); //是否关闭站点


//发送回给设备
$data=array(
	'token'=>'',
	'task_id'=>'',
	'task_path'=>'',
	'task_data_id'=>'',
	'task_data_path'=>'',
	'strategy_id'=>'',
	'user_config_path'=>'',  //kobe新加一条，用户的配置数据地址
);
