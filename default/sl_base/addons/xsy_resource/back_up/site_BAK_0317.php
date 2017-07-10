<?php
/**
 * 入口文件
 * @author QQ:3419335695
 */
defined ( 'IN_IA' ) or exit ( 'Access Denied' );
require IA_ROOT . '/addons/xsy_resource/defines.php';
class Xsy_resourceModuleSite extends WeModuleSite {
	
	/**
	 * 资源管理
	 */
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


// echo "<pre>";
// print_r($_FILES);
// print_r($_GPC);
// exit;

			$id = $_GPC['id'];
			$type = $_GPC ['type'];
			if(empty($id)){


				

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
						$data = array (
								"info" => $info,
								'type' => $type,
								'owner_id' => $owner_id,
								'origin_name'=>$file ['name'],
								'name' => $filename,
								"path" => $_result['imgurl'],
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

			}else{

				$data = array (
						"info" => $info,
				);
				pdo_update("xsy_resource_file",$data,array("id"=>intval($id)));

				$this->_log($id,'update');

				message ( '修改成功', $this->createWebUrl("manager"), 'success' );
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
		$data_list = pdo_fetchall($sql);//脚本列表
        $sql = "select * from " . tablename ( 'xsy_resource_file' ) . " where type='idle' order by time desc";
        $idle_list = pdo_fetchall($sql);//脚本列表
		// $count=count($task_list);//计算有几个脚本得出有几个优先级

		$sql = "select * from " . tablename ( 'ms_strategy' ) . " order by id desc";
		$strategy = pdo_fetchall($sql);//策略列表

		if ($_GPC['dopost'] == 'add') {

				//增加策略表
				if(empty($_GPC['name']) || empty($_GPC['full_time']) || empty($_GPC['cost']) || empty($_GPC['info']) ){
					message ( '缺少参数,请重新填写', $this->createWebUrl("strategy"), 'error' );	
				}


                $name=$_GPC['name'];//空闲
				$owner=$_W['uid'];//制定者
				$full_time=$_GPC['full_time'];//执行一轮时间
				$cost=$_GPC['cost'];//扣点数
				$is_ramd=$_GPC['is_ramd'];//随机
				$info=$_GPC['info'];//随机
                $idle=$_GPC['idle'];//空闲

				$strategy_data=array(
                    'name'=>$name,
					'owner'=>$owner,
					'full_time'=>$full_time,
					'cost'=>$cost,
					'is_ramd'=>$is_ramd,
                    'idle'=>$idle,
					'info'=>$info,
				);


				pdo_insert ( "ms_strategy", $strategy_data );
				$strategy_id = pdo_insertid();

				if(!empty($strategy_id)){

					//增加任务表
					$task_id=$_GPC['ms_task_index'];//任务id
					$task_time=$_GPC['task_time'];//秒
					$task_num=$_GPC['task_num'];//次
					$task_pri=$_GPC['task_pri'];//排序
					$task_d_id=$_GPC['task_d_id'];//次
					$task=array();

					foreach ($task_id as $key => $value) {
						$task_data=array(
							'task_id'=>$value,
							'task_time'=>$task_time[$key],
							'task_num'=>$task_num[$key],
							'task_pri'=>$task_pri[$key],
							'task_d_id'=>$task_d_id[$key],
							'strategy_id'=>$strategy_id,
						);
				// echo "<pre>";
				// print_r($task_data);
				
				
				
						pdo_insert ( "ms_strategy_task_list", $task_data );
					}

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


		}elseif($_GPC['dopost'] == 'show_task'){


			$sql = "select * from " . tablename ( 'ms_strategy_task_list' ) . " where strategy_id=".$_GPC['id'];
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
			$task=pdo_fetchcolumn ("SELECT task_list FROM " .tablename('ms_allot_table') . " WHERE ms_id='".$ms_id."'");
			$task=json_decode($task,true);//已分配任务列表

			foreach ($task as $key => $value) {
					$task_name=$this->_gettaskname($value['task_id']);

					if($value['task_d_id']==0){
						$task_d_name='无';
					}else{
						$task_d_name=$this->_gettaskname($value['task_d_id']);
						$task_d_name=$task_d_name ? $task_d_name : '';
					}
					date_default_timezone_set("Asia/Shanghai"); //kobe add
					$time = date("m-d H:i:s",$value['time']);

					$task[$key]['task_id']= $task_name ? $task_name : '';
					$task[$key]['task_d_id']= $task_d_name;
					$task[$key]['time'] = $time;
			}

			die(json_encode($task));
		}




		$sql ="select * from ".tablename ( 'ms_alive_table' )."order by id desc";
		$count_sql = "select count(*) from " . tablename ( "ms_alive_table" );
		$params = array ();
		$total = 0;
		$pager;
		$total_page;
		$list = array ();
		$this->get_page_data ( $sql, $count_sql, $params, $total, $pager, $list, $total_page );


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
	 	$taskname=pdo_fetchcolumn ("SELECT info FROM " .tablename('xsy_resource_file') . " WHERE id=".$id);
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





}