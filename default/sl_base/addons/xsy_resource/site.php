<?php
/**
 * 入口文件
 * @author QQ:3419335695
 */
defined ( 'IN_IA' ) or exit ( 'Access Denied' );
require IA_ROOT . '/addons/xsy_resource/defines.php';
require IA_ROOT . '/addons/xsy_resource/device_inc/device.inc.php';

//require IA_ROOT . '/addons/xsy_resource/kobe_inc/user_site.php';

class Xsy_resourceModuleSite extends WeModuleSite {
	
	/**
	 * 资源管理
	 */
	
	public function doWebWeb() {
		require_once IA_ROOT . '/addons/xsy_resource/kobe_inc/user_site.php';
		error_log("enter doWebWeb");
		$my_obj = new kobeModuleSite();
		

		$my_obj->do_command();
		//$this->do_command();	
		//include $this->template('web/kobe_tpl/user_login');
		error_log("after dewebweb");
	}
	
	//require IA_ROOT . '/addons/xsy_resource/kobe_inc/user_site.php';
	public function doWebManager() {
		error_reporting ( 0 );
		set_time_limit ( 0 );
		global $_W, $_GPC;
		$op = $_GPC ['op'];





		$_setting = pdo_fetch('SELECT * FROM '.tablename("ms_setting")." where 1");
		if ($op == "setting") {//站点设置
			$close = $_GPC ['close'];
			$data = array (
						"close" => $close,
					);
			pdo_update ( "ms_setting", $data , array("id"=>intval($_setting['id'])));
			message ( '设置成功', $this->createWebUrl("manager"), 'success' );
		}elseif ($op == "dels") {//站点设置
			$ids = $_GPC ['ids'];

			$ids=explode(",",$ids);

			foreach ($ids as $k => $v) {
				$file_path = pdo_fetchcolumn ("SELECT path FROM " .tablename('xsy_resource_file') . " WHERE id=".$v);
				$del_path=ATTACHMENT_ROOT.substr($file_path,strlen($_W['setting']['remote']['alioss']['url'])+1);
				if (!unlink($del_path)){
					message ( 'id为 '.$v.' 文件删除失败，请重试', $this->createWebUrl("manager"), 'error' );
				}else{
					$this->_log($v,'del');

					pdo_delete ( "xsy_resource_file", array (
							"id" => intval ( $v )
					) );
				}
			}

			message ( '文件删除成功', $this->createWebUrl("manager"), 'success' );
			exit;
		}


		$info = trim($_GPC ['info']);
		$owner_id = $_GPC ['owner_id'];
		if ($op == "save") {

			$type = $_GPC ['type'];








				if(empty($owner_id)){
					message ( '请选择上传者', $this->createWebUrl("manager"), 'error' ); 
				}

                $file = $_FILES ["file"];
                $filetype = $file ["type"];
				$filesize = $file ["size"];
            










				$filename=substr($file ["name"],strrpos($file ["name"], "."));

// echo "<pre>";
// print_r($filename);
//     exit;
                if(empty($file)){
                    message ( '请选择上传的文件', $this->createWebUrl("manager"), 'error' ); 
                }
                // if($filetype=='application/octet-stream'){
                //     message ( '无法上传此文件类型', $this->createWebUrl("manager"), 'error' );
                // }
                if($filesize>2000000){
                    message ( '文件大小不能超过2M。', $this->createWebUrl("manager"), 'error' );
                }

				

				$filepath = "file/" . $_W ['uniacid'] . "/" . date ( 'Ymd' ) . "/";//ATTACHMENT下的目录
				$filename = $this->uuid () . $filename;//文件名

				 $dirname = ATTACHMENT_ROOT.$filepath;//绝对路径（不含文件名）
				$this->mkFolder ( ATTACHMENT_ROOT.$filepath );//检测目录

				$pathname =  $filepath . $filename;//ATTACHMENT下的目录+文件名
				$filepath = ATTACHMENT_ROOT. $pathname;//绝对路径+ATTACHMENT下的目录+文件名

				
				if (move_uploaded_file ( $file ['tmp_name'], $filepath )) {

				  $this->_Initoss();//检查oss是否正常
                  $_result = $this->_ossClient->multiuploadFile($pathname,$filepath,array('type'=>1));//上传返回status,imgurl;

                  	if($_result['status']==1){

                  		$excel_data="";
                  		/*如果是数据模板上传的话单独处理*/
						if($type=='excel'){
							$excel_data=$this->_do_excel($filepath);
						}
						$data = array (
								"info" => $info,
								'type' => $type,
								'owner_id' => $owner_id,
								'origin_name'=>$file ['name'],
								'name' => $filename,
								"path" => $_result['imgurl'],
								'excel_data'=>$excel_data,//如果type不为模板类型，则为空
								"time" => time ()
						);
						pdo_insert ( "xsy_resource_file", $data );
						$this->_log( pdo_insertid(), 'insert');

                  	}else{
                  		message ( '文件上传 OSS服务器 失败', $this->createWebUrl("manager"), 'error' );
                  	}
					message ( '文件上传成功', $this->createWebUrl("manager"), 'success' );


				} else {
					message ( '文件上传失败', $this->createWebUrl("manager"), 'error' );
				}

		} else if ($op == 'del') {

			$file_path = pdo_fetchcolumn ("SELECT path FROM " .tablename('xsy_resource_file') . " WHERE id=".$_GPC ['id']);

			$del_path=ATTACHMENT_ROOT.substr($file_path,strlen($_W['setting']['remote']['alioss']['url'])+1);

			if (!unlink($del_path)){
				message ( '文件删除失败', $this->createWebUrl("manager"), 'error' );
			}else{


				$this->_log($_GPC ['id'],'del');

				pdo_delete ( "xsy_resource_file", array (
						"id" => intval ( $_GPC ['id'] )
				) );
				message ( '文件删除成功', $this->createWebUrl("manager"), 'success' );				
			}

		}
 		else if ($op == 'replace') {

		$info = trim($_GPC ['info']);
		$id = $_GPC['id'];
		$file = $_FILES ["file"];

        if(!empty($file ["name"]) && $file ["size"]!==0){

                $file = $_FILES ["file"];
                $filetype = $file ["type"];
				$filesize = $file ["size"];

				$filename=substr($file ["name"],strrpos($file ["name"], "."));

                if($filesize>2000000){
                    message ( '文件大小不能超过2M。', $this->createWebUrl("manager"), 'error' );
                }


				$filepath = "file/" . $_W ['uniacid'] . "/" . date ( 'Ymd' ) . "/";//ATTACHMENT下的目录
				$filename = $this->uuid () . $filename;//文件名

				 $dirname = ATTACHMENT_ROOT.$filepath;//绝对路径（不含文件名）
				$this->mkFolder ( ATTACHMENT_ROOT.$filepath );//检测目录

				$pathname =  $filepath . $filename;//ATTACHMENT下的目录+文件名
				$filepath = ATTACHMENT_ROOT. $pathname;//绝对路径+ATTACHMENT下的目录+文件名
				if (move_uploaded_file ( $file ['tmp_name'], $filepath ) && !empty($id)) {

				  $this->_Initoss();//检查oss是否正常
                  $_result = $this->_ossClient->multiuploadFile($pathname,$filepath,array('type'=>1));//上传返回status,imgurl;

                  	if($_result['status']==1){
						$data = array (
								"info" => $info,
								'origin_name'=>$file ['name'],
								'name' => $filename,
								"path" => $_result['imgurl'],
								"time" => time ()
						);
						pdo_update ( "xsy_resource_file", $data  , array("id"=>$id));

						$this->_log( pdo_insertid(), 'update');

                  	}else{
                  		message ( '文件上传 OSS服务器 失败', $this->createWebUrl("manager"), 'error' );
                  	}
					message ( '修改成功', $this->createWebUrl("manager"), 'success' );


				} else {
					message ( '失败', $this->createWebUrl("manager"), 'error' );
				}
            
        }else{
			$data = array (
					"info" => $info,
					"time" => time ()
			);

			pdo_update("xsy_resource_file",$data,array("id"=>intval($id)));

			$this->_log($id,'update');

			message ( '修改成功', $this->createWebUrl("manager"), 'success' );
        }


		}
		if (! empty ( $info )) {
			$condition = " where origin_name like '%" . $info . "%'";
		}
		$sql = "select * from " . tablename ( 'xsy_resource_file' ) . " {$condition} order by id desc";
		
		$count_sql = "select count(*) from " . tablename ( "xsy_resource_file" ) . " {$condition} ";
		
		$params = array ();
		$total = 0;
		$pager;
		$total_page;
		$list = array ();
		$this->get_page_data ( $sql, $count_sql, $params, $total, $pager, $list, $total_page );
		
		$resourcepath = $_W ['siteroot']."app/".$this->createMobileUrl('resource');
		
		$_members = pdo_fetchall('SELECT uid,realname FROM '.tablename("mc_members")." where uniacid=".$_W['uniacid']);

		include $this->template ( 'web/manager' );
	}

	/**
	 * 日志页面
	 */
	public function doWebLog() {
		global $_W, $_GPC;
		// $search = trim($_GPC ['search']);
		// if (! empty ( $search )) {
		// 	$condition = " where origin_name like '%" . $search . "%'";
		// }
		$sql = "select a.*,c.realname from " . tablename ( 'xsy_resource_file_log' ) . " a 
		LEFT JOIN " . tablename ( 'mc_members' ) . " c on a.owner_id=c.uid 
		 {$condition} order by id desc";
		$count_sql = "select  count(*) from " . tablename ( 'xsy_resource_file_log' ) . " a 
		LEFT JOIN " . tablename ( 'mc_members' ) . " c on a.owner_id=c.uid 
		 {$condition}";
		$params = array ();
		$total = 0;
		$pager;
		$total_page;
		$list = array ();
		$this->get_page_data ( $sql, $count_sql, $params, $total, $pager, $list, $total_page );


		include $this->template ( 'web/log' );
	}

	/**
	 * 策略页面
	 */
	public function doWebStrategy() {
		global $_W, $_GPC;

		$sql = "select * from " . tablename ( 'xsy_resource_file' ) . " where type='file' order by time desc";
		$task_list = pdo_fetchall($sql);//脚本列表
		$sql = "select * from " . tablename ( 'xsy_resource_file' ) . " where type='data' order by time desc";
		$data_list = pdo_fetchall($sql);//数据列表
        $sql = "select * from " . tablename ( 'xsy_resource_file' ) . " where type='idle' order by time desc";
        $idle_list = pdo_fetchall($sql);//空闲列表
		// $count=count($task_list);//计算有几个脚本得出有几个优先级
		
        $sql = "select * from " . tablename ( 'xsy_resource_file' ) . " where type='excel' order by time desc";
        $excel_list = pdo_fetchall($sql);//模板列表


		$sql = "select * from " . tablename ( 'ms_strategy' ) . " order by id desc";
		$strategy = pdo_fetchall($sql);//策略列表

		if ($_GPC['dopost'] == 'add') {
				$id=$_GPC['id'];

				//增加策略表
				if(empty($_GPC['name']) || empty($_GPC['full_time']) || empty($_GPC['cost']) || empty($_GPC['info']) ){
					message ( '缺少参数,请重新填写', $this->createWebUrl("strategy"), 'error' );	
				}
				$owner=$_W['uid'];//制定者
                $name=$_GPC['name'];//
				$full_time=$_GPC['full_time'];//执行一轮时间
				$cost=$_GPC['cost'];//扣点数
				$is_ramd=$_GPC['is_ramd'];//随机
				$info=$_GPC['info'];//随机
                $idle=$_GPC['idle'];//空闲
                $excel=$_GPC['excel'];//模板



                if(empty($id)){//增加
					$strategy_data=array(
	                    'name'=>$name,
						'owner'=>$owner,
						'full_time'=>$full_time,
						'cost'=>$cost,
						'is_ramd'=>$is_ramd,
	                    'idle'=>$idle,
						'info'=>$info,
						'temple_name'=>$excel,
					);


					pdo_insert ( "ms_strategy", $strategy_data );
					$strategy_id = pdo_insertid();
                }else{//修改
                	$strategy_data=array(
	                    'name'=>$name,
						'full_time'=>$full_time,
						'cost'=>$cost,
						'is_ramd'=>$is_ramd,
						'info'=>$info,
					);
					pdo_update ( "ms_strategy", $strategy_data , array("id"=>$id));
					$strategy_id = $id;
                }


				if(!empty($strategy_id)){

					//增加任务表
					$task_id=$_GPC['ms_task_index'];//任务id
					$task_time=$_GPC['task_time'];//秒
					$task_num=$_GPC['task_num'];//次
					$task_pri=$_GPC['task_pri'];//排序
					$task_d_id=$_GPC['task_d_id'];//次
					$task=array();

					if(!empty($id)){//修改，先把原有的都删除再新增
							pdo_delete ( "ms_strategy_task_list", array ("strategy_id" => intval ( $id ) ) );
						}
					foreach ($task_id as $key => $value) {
						$task_data=array(
							'task_id'=>$value,
							'task_time'=>$task_time[$key],
							'task_num'=>$task_num[$key],
							'task_pri'=>$task_pri[$key],
							'task_d_id'=>$task_d_id[$key],
							'strategy_id'=>$strategy_id,
						);

						pdo_insert ( "ms_strategy_task_list", $task_data );
					}

				}

				if(!empty($id)){
					message ( '策略修改成功', $this->createWebUrl("strategy"), 'success' );	
				}
				message ( '策略添加成功', $this->createWebUrl("strategy"), 'success' );	


		}elseif($_GPC['dopost'] == 'del'){


			$id=$_GPC['id'];
			pdo_delete ( "ms_strategy", array ("id" => intval ( $id ) ) );
			pdo_delete ( "ms_strategy_task_list", array ("strategy_id" => intval ( $id ) ) );
			message ( '删除策略成功', $this->createWebUrl("strategy"), 'success' );	



		}elseif($_GPC['dopost'] == 'select'){


			$sql = "select * from " . tablename ( 'xsy_resource_file' ) . " where id=".$_GPC['id'];
			$task = pdo_fetch($sql);
			die(json_encode($task));


		}


		elseif($_GPC['dopost'] == 'show_task'){
			$sql = "select * from " . tablename ( 'ms_strategy_task_list' ) . " where strategy_id=".$_GPC['id'] . " order by task_pri asc";
			$task_list = pdo_fetchall($sql);

			foreach ($task_list as $key => $value) {

					$task_name=$this->_gettaskname($value['task_id']);

					if($value['task_d_id']==0){
						$task_d_name='无';
					}else{
						$task_d_name=$this->_gettaskname($value['task_d_id']);
						$task_d_name=$task_d_name ? $task_d_name : '';
					}
					$task_list[$key]['task_id']= $task_name ? $task_name : '';
					$task_list[$key]['task_d_id']= $task_d_name;
			}

			die(json_encode($task_list));
		}
//----kobe for download info----------------------------------------------
		elseif($_GPC['dopost'] == 'download_strategy'){
			error_log("+++++id = ".$_GPC['id']);
			$sql = "select * from " . tablename ( 'ms_strategy_task_list' ) . " where strategy_id=".$_GPC['id'] . " order by task_pri asc";
			$task_list = pdo_fetchall($sql);

			foreach ($task_list as $key => $value) {

					$task_name=$this->_gettaskname($value['task_id']);

					if($value['task_d_id']==0){
						$task_d_name='无';
					}else{
						$task_d_name=$this->_gettaskname($value['task_d_id']);
						$task_d_name=$task_d_name ? $task_d_name : '';
					}
					$task_list[$key]['task_id']		= $task_name ? $task_name : '';
					$task_list[$key]['task_d_id']	= $task_d_name;
			}
			$my_strategy = pdo_fetch("SELECT * from " . tablename ( 'ms_strategy' ) . " where id=".$_GPC['id']);
			//die(json_encode($task_list));
			$download_info = array();
			$download_info['strategy_info'] 		= $my_strategy;
			$download_info['strategy_task_info'] 	= $task_list;

			$now_time = time();
			$my_time = date('Y-m-d_H-i-s', $now_time); 
			$my_file = IA_ROOT .'/attachment/'.'strategy_'.$my_time.".strategy";
			//$fopen =  fopen('../attachment/'.$pathname,'w') or die("Unable to open file!");
			$fp = fopen($my_file,'w') or die("Unable to open file!");
			fwrite($fp, var_export($download_info, true));
			fclose($fp);
			//error_log($_SERVER['HTTP_HOST']."+++++++++");
			$xxxx = '/sl_base/attachment/'.'strategy_'.$my_time.".strategy";
			die(json_encode($xxxx));
			//exit($my_file);
		}

		elseif($_GPC['dopost'] == 'show_task'){
			$sql = "select * from " . tablename ( 'ms_strategy_task_list' ) . " where strategy_id=".$_GPC['id'] . " order by task_pri asc";
			$task_list = pdo_fetchall($sql);

			foreach ($task_list as $key => $value) {

					$task_name=$this->_gettaskname($value['task_id']);

					if($value['task_d_id']==0){
						$task_d_name='无';
					}else{
						$task_d_name=$this->_gettaskname($value['task_d_id']);
						$task_d_name=$task_d_name ? $task_d_name : '';
					}
					$task_list[$key]['task_id']= $task_name ? $task_name : '';
					$task_list[$key]['task_d_id']= $task_d_name;
			}
			
			die(json_encode($task_list));
		}





		elseif($_GPC['dopost'] == 'get_edit'){
			$op = $_GPC ['op'];
			$id=$_GPC['id'];
			if($op=='tasklist'){
				$task_list = pdo_fetchall("SELECT a.task_d_id,a.task_time,a.task_num,a.task_pri,b.id,b.origin_name,b.info from " . tablename ( 'ms_strategy_task_list' ) . " a 
					LEFT JOIN " . tablename ( 'xsy_resource_file' ) . " b on a.task_id=b.id 
				 where a.strategy_id=".$id);

				foreach ($task_list as $key => $value) {
						if($value['task_d_id']==0){
							$task_d_name='';
						}else{
							$task_d_name=$this->_gettaskorigin_name($value['task_d_id']);
							$task_d_name=$task_d_name ? $task_d_name : '';
							$task_d_info=$this->_gettaskname($value['task_d_id']);
							$task_d_info=$task_d_info ? $task_d_info : '';
						}
						$task_list[$key]['task_d_name']=$task_d_name;
						$task_list[$key]['task_d_info']=$task_d_info;
				}


				die(json_encode($task_list));
			}elseif($op=='strategyinfo'){
				$strategy = pdo_fetch("SELECT * from " . tablename ( 'ms_strategy' ) . " where id=".$id);
				die(json_encode($strategy));
			}


		}


// <pre>Array
// (
//     [0] => Array
//         (
//             [id] => 62
//             [task_id] => 232
//             [task_d_id] => 248
//             [task_time] => 700
//             [task_num] => 30
//             [task_pri] => 1
//             [strategy_id] => 29
//         )




		include $this->template ( 'web/strategy' );
	}
	/**
	 * 策略页面
	 */
	public function doWebAllot() {
		global $_W, $_GPC;


		if($_GPC['op']=='showinfo'){
			$allot_id=$_GPC['id'];
			$task=pdo_fetchcolumn ("SELECT task_list FROM " .tablename('ms_allot_table') . " WHERE id=".$allot_id);
			$task=json_decode($task,true);//已分配任务列表

			foreach ($task as $key => $value) {
					$task_name=$this->_gettaskname($value['task_id']);

					if($value['task_d_id']==0){
						$task_d_name='无';
					}else{
						$task_d_name=$this->_gettaskname($value['task_d_id']);
						$task_d_name=$task_d_name ? $task_d_name : '';
					}
					$task[$key]['task_id']= $task_name ? $task_name : '';
					$task[$key]['task_d_id']= $task_d_name;
			}

			die(json_encode($task));
		}


		$sql = "select a.*,b.realname,c.info from " . tablename ( 'ms_allot_table' )." a 
		LEFT JOIN " . tablename ( 'mc_members' )." b on a.ms_id=b.ms_code 
		LEFT JOIN " . tablename ( 'ms_strategy' )." c on b.strategy_id=c.id ";

		$count_sql = "select count(*) from " . tablename ( "ms_allot_table" );


		$params = array ();
		$total = 0;
		$pager;
		$total_page;
		$list = array ();
		$this->get_page_data ( $sql, $count_sql, $params, $total, $pager, $list, $total_page );
		include $this->template ( 'web/allot' );
	}

	public function get_page_memc_data($sql,  &$total, &$pager, &$list, &$total_page = 0){
		try {
			global $_GPC;
			$psize = 10;
			$pindex = max ( 1, intval ( $_GPC ['page'] ) ); //index最小为1
			//$total = pdo_fetchcolumn ( $count_sql, $params );
			$total_device_list = get_total_device_list($sql);
			$device_num = count($total_device_list);
			$total = $device_num;
			 
			$total_page = ($device_num % $psize == 0) ? $device_num / $psize : intval ( $device_num / $psize ) + 1;
			if (($pindex - 1) * $psize > $device_num)
				$pindex = 1;
		    //error_log("111111");	
			//$list = pdo_fetchall ( "$sql limit " . (($pindex - 1) * $psize) . ",$psize", $params );
			$list  = get_task_list_by_page($total_device_list, $psize,  $pindex);
			$pager = pagination ( $device_num, $pindex, $psize );
			//error_log("22222: ". $device_num );
			return false;
		} catch ( Exception $e ) {
			return $e->getMessage ();
		}

	}

	/**
	 * 终端日志页面
	 */
	public function doWebAlive() {
		global $_W, $_GPC;
		// $search = trim($_GPC ['search']);
		// if (! empty ( $search )) {
		// 	$condition = " where origin_name like '%" . $search . "%'";
		// }
		
		if($_GPC['op']=='showinfo'){
			$ms_id=$_GPC['ms_id'];
			/*$task=pdo_fetchcolumn ("SELECT task_list FROM " .tablename('ms_allot_table') . " WHERE ms_id='".$ms_id."'");
			$task=json_decode($task,true);//已分配任务列表*/
			$task = memc_get_task_list($ms_id);

			foreach ($task as $key => $value) {
					$task_name=$this->_gettaskname($value['task_id']);

					if($value['task_data_id']==0){
						$task_data_name='无';
					}else{
						$task_data_name=$this->_gettaskname($value['task_data_id']);
						$task_data_name=$task_data_name ? $task_data_name : '';
					}
					date_default_timezone_set("Asia/Shanghai"); //kobe add
					$time = date("m-d H:i:s",$value['time']);

					$task[$key]['task_id']= $task_name ? $task_name : '';
					$task[$key]['task_data_id']= $task_data_name;
					$task[$key]['time'] = $time;
			}

			die(json_encode($task));
		}
		if($_GPC['op']=='show_track_info'){
			$ms_id=$_GPC['ms_id'];
			/*$task=pdo_fetchcolumn ("SELECT task_list FROM " .tablename('ms_allot_table') . " WHERE ms_id='".$ms_id."'");
			$task=json_decode($task,true);//已分配任务列表*/
			$track_list = memc_get_dev_track_info($ms_id);
			$my_i = 0;
			foreach ($track_list as $key => $value) {			
					$track_info[$my_i]['track_key']	= $key;
					$track_info[$my_i]['track_value']= $value;					# code...
					$my_i = $my_i +1;						
			}
			//error_log("+++show_track_info+++");
			print_n_array($track_info);
			//error_log("-----show_track_info+++");
			print_n_array($track_list);
			die(json_encode($track_info));
		}
		//---------------------kobe begin ----------------------------
		elseif ($_GPC['op'] == "task_list_dels") {//站点设置
			$ids = $_GPC ['ids'];
			//error_log("---task_list_dels---");	
			$ids=explode(",",$ids);
			foreach ($ids as $k => $v) {
					//pdo_delete ( "ms_allot_table", array ("ms_id" => intval ( $v )) );
					del_memc_task_list($v);  //直接从Memcached中删除
				}

			message ( '重置成功', $this->createWebUrl("alive"), 'success' );
			exit;
		}//----------kobe end-----------


//----------excel begin -----------
		if($_GPC['op']=='down_alive'){

		if($_W['role_bool']){ //判断是否是管理员
			$uid=$_W['uid'];
			$realname=pdo_fetchcolumn ("SELECT realname FROM " .tablename('mc_members') . " WHERE uid=".$uid);
			$w=" where account='".$realname."'";		
		}

		include IA_ROOT.'/framework/library/phpexcel/PHPExcel.php';

		$sql ="select * from ".tablename ( 'ms_alive_table' ).$w." order by id desc";

		$total_device_list = get_total_device_list($sql);
		$_list  = get_task_list_by_all($total_device_list);


		$title = array(
		      array(
		        'name'=>'ID',
		        'width'=>8,
		      ),
		      array(
		        'name'=>'用户',
		        'width'=>20,
		      ),
		      array(
		        'name'=>'序号',
		        'width'=>20,
		      ),
		      array(
		        'name'=>'型号',
		        'width'=>10,
		      ),
		      array(
		        'name'=>'IP',
		        'width'=>20,
		      ),
		      array(
		        'name'=>'脚本',
		        'width'=>30,
		      ),
		      array(
		        'name'=>'策略',
		        'width'=>30,
		      ),
		      array(
		        'name'=>'执行时间',
		        'width'=>20,
		      ),
		      array(
		        'name'=>'进度',
		        'width'=>10,
		      ),
		  );

		foreach ($_list as $key => $value) {
			$_conf[$key]['id']= $value['id'];
			$_conf[$key]['account']=$value['account'];
			$_conf[$key]['ms_id'] = $value['ms_id'];
			$_conf[$key]['ms_type'] = $value['ms_type'];
			$_conf[$key]['ip'] = $value['ip'];
			$_conf[$key]['task_name'] = $value['task_name'];
			$_conf[$key]['strategy_name'] = $value['strategy_name'];
			$_conf[$key]['time'] = date('m-d H:i:s', $value['time']);
			$_conf[$key]['schedule'] =  intval($value['task_index']).'/'.intval($value['task_num']);
		}

	    $name = '终端状态';
	    $this->_pushExcel($title,$_conf,$name);
		}
		//----------excel end-----------

		if($_W['role_bool']){ //判断是否是管理员
			$uid=$_W['uid'];
			$realname=pdo_fetchcolumn ("SELECT realname FROM " .tablename('mc_members') . " WHERE uid=".$uid);
			$w=" where account='".$realname."'";		
		}


		$sql ="select * from ".tablename ( 'ms_alive_table' ).$w."order by user_id desc";
		$count_sql = "select count(*) from " . tablename ( "ms_alive_table" ).$w;
		$params = array ();
		$total = 0;
		$pager;
		$total_page;
		$list = array();
		//$this->get_page_data ( $sql, $count_sql, $params, $total, $pager, $list, $total_page );
		$this->get_page_memc_data($sql, $total, $pager, $list, $total_page );
		//error_log("enter========");
		include $this->template ( 'web/alive' );
	}



	/**
	 * 资源下载
	 */
	public function doMobileResource() {
		global $_W, $_GPC;
		$isweixin = $this->is_weixin ();
		$fileid = intval ( $_GPC ['id'] );
		$file = pdo_get ( "xsy_resource_file", array ("id" => $fileid) );


        if($_GPC ['dopost']=='download'){
            $fileid = intval ( $_GPC ['id'] );
            $file = pdo_get ( "xsy_resource_file", array ("id" => $fileid) );
            $url=$_W['siteroot'].$file['path'];

            $fileinfo = pathinfo($url);
            header('Content-type: application/x-'.$fileinfo['extension']);
            header('Content-Disposition: attachment; filename='.$file['origin_name']);
            header('Content-Length: '.filesize($url));
            readfile($url);
            exit;
        }
		include $this->template ( 'default/resource' );
	}

	/**
	 * 资源列表
	 */
	public function doMobileIndex() {
		global $_W, $_GPC;
		$files = pdo_fetchall ("select * from ".tablename( "xsy_resource_file"));
		include $this->template ( 'default/index' );
	}
	public function is_weixin() {
		if (empty ( $_SERVER ['HTTP_USER_AGENT'] ) || strpos ( $_SERVER ['HTTP_USER_AGENT'], 'MicroMessenger' ) === false && strpos ( $_SERVER ['HTTP_USER_AGENT'], 'Windows Phone' ) === false) {
			return false;
		}
		return true;
	}









	
	public function uuid($prefix = '') {
		$chars = md5 ( uniqid ( mt_rand (), true ) );
		$uuid = substr ( $chars, 0, 8 );
		$uuid .= substr ( $chars, 8, 4 );
		$uuid .= substr ( $chars, 12, 4 );
		$uuid .= substr ( $chars, 16, 4 );
		$uuid .= substr ( $chars, 20, 12 );
		return $prefix . $uuid;
	}
	function get_page_data($sql, $count_sql, $params, &$total, &$pager, &$list, &$total_page = 0) {
		try {
			global $_GPC;
			$psize = 10;
			$pindex = max ( 1, intval ( $_GPC ['page'] ) );
			$total = pdo_fetchcolumn ( $count_sql, $params );
			$total_page = ($total % $psize == 0) ? $total / $psize : intval ( $total / $psize ) + 1;
			if (($pindex - 1) * $psize > $total)
				$pindex = 1;
			
			$list = pdo_fetchall ( "$sql limit " . (($pindex - 1) * $psize) . ",$psize", $params );
			$pager = pagination ( $total, $pindex, $psize );
			return false;
		} catch ( Exception $e ) {
			return $e->getMessage ();
		}
	}
	function mkFolder($path) {
		if (! is_readable ( $path )) {
			is_file ( $path ) or mkdir ( $path, 0700, true );
		}
	}
	public function _Initoss(){
		global $_W;
	     include GARCIA_OSS."index.php";
		$oss=$_W['setting']['remote']['alioss'];

	   if(!empty($oss['key'])&&!empty($oss['secret'])&&!empty($oss['url'])){
	      $this->_ossClient = new _ali($oss['key'],$oss['secret'],$oss['ossurl'],$oss['bucket'],$oss['url']);
	   }
	  //  echo $this->sys['oss_url'];
	 }

	 public function _getmembername($id){
	 	$realname=pdo_fetchcolumn('SELECT realname FROM '.tablename("mc_members")." where uid=".$id);
	 	return $realname;
	 }
	 public function _getusername($uid){
	 	$username=pdo_fetchcolumn('SELECT username FROM '.tablename("users")." where uid=".$uid);
	 	return $username;
	 }
	 public function _log($id,$action){

	 	$data=pdo_fetch ("SELECT * FROM " .tablename('xsy_resource_file') . " WHERE id=".$id);

	 	$log=array();
	 	$log['action']=$action;
		$log['owner_id']=$data['owner_id'];
		$log['script_id']=$data['id'];
		$log['file_name']=$data['origin_name'];
		$log['time']=time();

		pdo_insert('xsy_resource_file_log', $log);
	 }

	 public function _gettask($id){
	 	$task=pdo_fetch ("SELECT * FROM " .tablename('ms_allot_table') . " WHERE id=".$id);
	 	$ms_task_index=$task['ms_task_index'];
	 	$task=json_decode($task['task_list'],true);//已分配任务列表

	 	foreach ($task as $key => $value) {
	 		if($key==$ms_task_index){
	 			$task_info=pdo_fetchcolumn ("SELECT info FROM " .tablename('xsy_resource_file') . " WHERE id=".$value['task_id']);
	 			$task_info=$task_info ? $task_info : '未知';
	 		}
	 	}
	 	return $task_info;
	 }
	 // public function _getms_task_index($id){
	 // 	$ms_task_index=pdo_fetchcolumn("SELECT ms_task_index FROM " .tablename('ms_allot_table') . " WHERE id=".$id);
	 // 	return $ms_task_index;
	 // }
	 // public function _getcounttask($id){
	 // 	$task=pdo_fetchcolumn("SELECT task FROM " .tablename('ms_allot_table') . " WHERE id=".$id);

	 // 	$task=json_decode($task,true);//已分配任务列表
	 // 	$task=count($task);
	 // 	return $task;
	 // }
	 public function _gettaskname($id){
	 	if(!empty($id)){
	 		$taskname=pdo_fetchcolumn ("SELECT info FROM " .tablename('xsy_resource_file') . " WHERE id=".$id);
	 	}
	 	return $taskname;
	 }
	 public function _gettaskorigin_name($id){
	 	if(!empty($id)){
	 		$taskname=pdo_fetchcolumn ("SELECT origin_name FROM " .tablename('xsy_resource_file') . " WHERE id=".$id);
	 	}
	 	return $taskname;
	 }
	 public function _getstrategyname($id){
	 	$strategyname=pdo_fetchcolumn ("SELECT name FROM " .tablename('ms_strategy') . " WHERE id=".$id);
	 	return $strategyname;
	 }
     public function _getstrategyinfo($id){
        $strategyinfo=pdo_fetchcolumn ("SELECT info FROM " .tablename('ms_strategy') . " WHERE id=".$id);
        return $strategyinfo;
     }
	 public function _getpercent($ms_id){
	 	$ms_task_index=pdo_fetchcolumn("SELECT ms_task_index FROM " .tablename('ms_allot_table') . " WHERE ms_id='".$ms_id."'");//当前任务
	 	$counttask=$this->_getcounttask($ms_id);

	 	$percent=intval($ms_task_index)/intval($counttask)*100;


	 	return intval($percent);
	 }

	 public function _getcounttask($ms_id){
	 	$task=pdo_fetchcolumn("SELECT task_list FROM " .tablename('ms_allot_table') . " WHERE ms_id='".$ms_id."'");
	 	$task=json_decode($task,true);//已分配任务列表
	 	$task=count($task);
	 	return $task;
	 }
	 public function _getms_task_index($ms_id){
	 	$ms_task_index=pdo_fetchcolumn("SELECT ms_task_index FROM " .tablename('ms_allot_table') . " WHERE ms_id='".$ms_id."'");
	 	return $ms_task_index;
	 }


	 public function _do_excel($filepath){
	 	
/**
 * excel读取
 */
include IA_ROOT . '/framework/library/phpexcel/PHPExcel.php';
include IA_ROOT . '/framework/library/phpexcel/PHPExcel/IOFactory.php';
include IA_ROOT . '/framework/library/phpexcel/PHPExcel/Reader/Excel5.php';


$reader = PHPExcel_IOFactory::createReader(($file_type == 'xls' ? 'Excel5' : 'Excel2007'));
$excel = $reader->load($filepath);

$sheet = $excel->getActiveSheet();
//获取行数与列数,注意列数需要转换
$highestRowNum = $sheet->getHighestRow();
$highestColumn = $sheet->getHighestColumn();
$highestColumnNum = PHPExcel_Cell::columnIndexFromString($highestColumn);


// tmp_name mp_id   iphone_num  position    num_strag
// 数据表名 转发公众号   电话号码    坐标  号码段
//     加粉   xxxx_11 18600000001 124.79968,23.246656 186234
//         yyyy_221 18600000002 134.79968,23.246656 121222
//       kobe_huang 18600000003 114.79968,23.246656 121223



//取得字段，这里测试表格中的第一行为数据的字段，因此先取出用来作后面数组的键名
$filed = array();
for($i=0; $i<$highestColumnNum;$i++){
    $cellName = PHPExcel_Cell::stringFromColumnIndex($i).'1';
    $cellVal = $sheet->getCell($cellName)->getValue();//取得列内容
    $filed []= $cellVal;
}

// $name = array();
// for($i=0; $i<$highestColumnNum;$i++){//取得行内容
//     $cellName = PHPExcel_Cell::stringFromColumnIndex($i).'2';
//     $cellVal = $sheet->getCell($cellName)->getValue();
//     $name []= $cellVal;
// }


//开始取出数据并存入数组
//按列读取数据
$data = array();
$replace=array(" ","　","\t","\n","\r");
for($i=0;$i<$highestColumnNum;$i++){//列
    $row = array();
    for($j=3; $j<=$highestRowNum;$j++){//从第三行开始
      $cellName = PHPExcel_Cell::stringFromColumnIndex($i).$j;
      $cellVal = $sheet->getCell($cellName)->getValue();
      $cellVal = str_replace($replace, '', $cellVal);
      if(!empty($cellVal)){
        $row[] = $cellVal;
      }
    }
    $data [$filed[$i]]= $row;
}




// echo "<pre>";
// print_r($data);
// exit;

/**
 * excel读取end
 */

$data=json_encode($data);


return $data;
}











//导出excel
    public function _pushExcel($title=array(),$data=array(),$name){
        $ichar =  ord("A"); //初始节点头A
        $_file = $name." (".date('YmdHis', time()).").xls";//定义文件名
        $_file = iconv("utf-8", "gb2312", $_file);

        $objPHPExcel = new PHPExcel(); //实例化 phpexcel类
        $objProps = $objPHPExcel->getProperties();
        //设置表头

        foreach($title as $k => $v){
            $colum = chr($ichar);
            $objPHPExcel->setActiveSheetIndex(0) ->setCellValue($colum.'1', $v['name']);
            $v['width'] = empty($v['width'])?10:$v['width'];
            $objPHPExcel->getActiveSheet()->getColumnDimension($colum)->setWidth($v['width']); //设置宽度
            $ichar += 1;
        }
        //内容列表
        $column = 2;
        $objActSheet = $objPHPExcel->getActiveSheet();
        foreach($data as $key => $rows){ //行写入
            $span = ord("A");
            foreach($rows as $keyName=>$value){// 列写入
                $j = chr($span);
                $objActSheet->setCellValueExplicit($j.$column, $value, PHPExcel_Cell_DataType::TYPE_STRING);
                $span++;
            }
            $column++;
        }
        //重命名表
        $objPHPExcel->getActiveSheet()->setTitle('Simple');
        //设置活动单指数到第一个表,所以Excel打开这是第一个表
        $objPHPExcel->setActiveSheetIndex(0);
        //将输出重定向到一个客户端web浏览器(Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header("Content-Disposition: attachment; filename=\"$_file\"");
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        exit;

    }



}