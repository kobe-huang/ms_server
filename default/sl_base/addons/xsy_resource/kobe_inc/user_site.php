<?php
defined ('IN_IA' ) or exit ( 'Access Denied' );

class kobeModuleSite extends WeModuleSite {
	
	public function print_n_array($contact1){
	    foreach ($contact1 as $key1 => $value1) {   
	        if ( true == is_array($contact1[$key1]) )
	        {
	            $this->print_n_array($contact1[$key1]);
	        } else{
	            error_log( $key1 . " => " . $contact1[$key1]);
	        }
	        
	    }
	}

	public function print_g_info(){
		global $_GPC, $_W;
		error_log("the _GPC = ");
		$this->print_n_array($_GPC);
		error_log("the _W = ");
		//$this->print_n_array($_W);
		error_log($_W['uniacid']);
		error_log("\n");
	}

	public function log_info($info){
		error_log($info);
	}

//----------------------------------
	public function do_command(){	
		global $_GPC, $_W;
		error_log("do_command");
		$this->modulename  = 'xsy_resource';
		$this->__define  = IA_ROOT . '/addons/xsy_resource/xsy_resource.php';
		$this->print_g_info();

		switch ($_GPC['action']) {
			case 'login':
				# code...
				$this->log_info("login operation");
				$this->_web_login();		# code...
				break;
			case 'account':
				$this->log_info("----account------");
				$this->_user_account();
				break;
			default:
				# code...
				break;
		}	
	}
	
	public function _web_login(){
		//error_log("enter _web_login");
		//if(checksubmit() || $_W['isajax']) {
		global $_GPC, $_W;	
		if($_GPC['username']){
			$this->log_info("enter _web_login");
			$this->_user_web_login();
			exit;
		}		
		include $this->template('web/kobe_tpl/user_login');
		$this->log_info("++enter login++");
	}

	public function _user_web_login(){
		global $_GPC, $_W;	
		$openid = $_W['openid'];
		$dos = array('basic', 'uc', 'mobile_exist');
		$do = 'basic';   //in_array($do, $dos) ? $do : 'basic';
		$this->log_info("1111");
		//$this->log_info($_GPC['username']);
		/*$setting = uni_setting($_W['uniacid'], array('uc', 'passport'));
		$uc_setting = $setting['uc'] ? $setting['uc'] : array();
		$ltype = empty($setting['passport']['type']) ? 'hybird' : $setting['passport']['type'];
		$audit = @intval($setting['passport']['audit']);
		$item = !empty($setting['passport']['item']) ? $setting['passport']['item'] : 'random';
		$type = trim($_GPC['type']) ? trim($_GPC['type']) : 'email';
		$forward = url('mc'); //-----------*/

		if(!empty($_GPC['forward'])) {
			$forward = './kobe_enter.php?&action=login';
		}
	

/*		if($do == 'mobile_exist') {
			if($_W['ispost'] && $_W['isajax']) {
				$is_exist = pdo_get('mc_members', array('uniacid' => $_W['uniacid'], 'mobile' => trim($_GPC['mobile'])));
				if (!empty($is_exist)) {
					message(error(1, ''), '', 'ajax');
				} else {
					message(error(2, ''), '', 'ajax');
				}
			}
		}*/
		/*
		if(!empty($_W['member']) && (!empty($_W['member']['mobile']) || !empty($_W['member']['email']))) {
			header('location: ' . $forward);
			exit;
		}*/
		if($do == 'basic') {
			if($_W['ispost']){ //&& $_W['isajax']) {
				$username = trim($_GPC['username']);
				$password = trim($_GPC['password']);
				$mode = trim($_GPC['mode']);
				if (empty($username)) {
					message('用户名不能为空', '', 'error');
				}
				if (empty($password)) {
					if ($mode == 'code') {
						message('验证码不能为空', '', 'error');
					} else {
						message('密码不能为空', '', 'error');
					}
				}
				if ($mode == 'code') {
					load()->model('utility');
					if (!code_verify($_W['uniacid'], $username, $password)) {
						message('验证码错误', '', 'error');
					} else {
						pdo_delete('uni_verifycode', array('receiver' => $username));
					}
				}

				$sql = 'SELECT `uid`,`salt`,`password`,`uniacid` FROM ' . tablename('mc_members') . ' WHERE `realname`=:realname';
				$pars = array();
				/*$pars[':uniacid'] = $_W['uniacid'];*/
				$pars[':realname'] = $_GPC['username'];

				/*if ($item  == 'mobile') {
					if (preg_match(REGULAR_MOBILE, $username)) {
						$sql .= ' AND `mobile`=:mobile';
						$pars[':mobile'] = $username;
					} else {
						message('请输入正确的手机', '', 'error');
					}
				} elseif ($item == 'email') {
					if (preg_match(REGULAR_EMAIL, $username)) {
						$sql .= ' AND `email`=:email';
						$pars[':email'] = $username;
					} else {
						message('请输入正确的邮箱', '', 'error');
					}
				} else {
					if (preg_match(REGULAR_MOBILE, $username)) {
						$sql .= ' AND `mobile`=:mobile';
						$pars[':mobile'] = $username;
					} else {
						$sql .= ' AND `email`=:email';
						$pars[':email'] = $username;
					}
				}*/

				$this->log_info("3333");
				$user = pdo_fetch($sql, $pars);
				if ($mode == 'basic') {
					$hash = md5($password . $user['salt'] . $_W['config']['setting']['authkey']);
					if ($user['password'] != $hash) {
						message('密码错误', '', 'error');
					}
				}
				if (empty($user)) {
					message('该帐号尚未注册', '', 'error');
				}
				$_W['uniacid'] = $user['uniacid'];
				
				load()->model('mc');
				if (_mc_login($user)) {					
					message('登录成功！', 'kobe_enter.php?&action=account' , 'success');				
				}
				message('未知错误导致登陆失败', '', 'error');
			}
			//include $this->template('web/kobe_tpl/user_login');
			exit;
		} 
/*elseif ($do == 'uc') {
	if ($_W['ispost'] && $_W['isajax']) {
		if(empty($uc_setting) || $uc_setting['status'] <> 1) {
			exit('系统尚未开启UC');
		}
		
		$post = $_GPC['__input'];
		$username = trim($post['username']);
		$password = trim($post['password']);
		empty($username) && exit('请填写' . $uc_setting['title'] . '用户名');
		empty($password) && exit('请填写' . $uc_setting['title'] . '密码！');
		
		mc_init_uc();
		$data = uc_user_login($username, $password);
		if ($data[0] < 0) {
			if($data[0] == -1) exit('用户不存在，或者被删除！');
			elseif ($data[0] == -2) exit('密码错误！');
			elseif ($data[0] == -3) exit('安全提问错误！');
		}
		
		$exist = pdo_fetch('SELECT * FROM ' . tablename('mc_mapping_ucenter') . ' WHERE `uniacid`=:uniacid AND `centeruid`=:centeruid', array(':uniacid' => $_W['uniacid'], 'centeruid' => $data[0]));
		if (!empty($exist)) {
			$user['uid'] = $exist['uid'];
			if(_mc_login($user)) {
				exit('success');
			} else {
				exit('未知错误导致登陆失败');
			}
		} else {
			if (!empty($_SESSION['openid'])) {
				$default_groupid = pdo_fetchcolumn('SELECT groupid FROM ' .tablename('mc_groups') . ' WHERE uniacid = :uniacid AND isdefault = 1', array(':uniacid' => $_W['uniacid']));
				$user = array(
					'uniacid' => $_W['uniacid'],
					'email' => $data[3],
					'salt' => random(8),
					'groupid' => $default_groupid,
					'createtime' => TIMESTAMP,
				);
				$user['password'] = md5($data[2] . $user['salt'] . $_W['config']['setting']['authkey']);
				pdo_insert('mc_members', $user);
				$uid = pdo_insertid();
				pdo_insert('mc_mapping_ucenter', array('uniacid' => $_W['uniacid'], 'uid' => $uid, 'centeruid' => $data[0]));
				pdo_update('mc_mapping_fans', array('uid' => $uid), array('uniacid' => $_W['uniacid'], 'acid' => $_W['acid'], 'openid' => $_SESSION['openid']));
				$user['uid'] = $uid;
				if (_mc_login($user)) {
					exit('success');
				} else {
					exit('未知错误导致登陆失败');
				}
			}
			exit('该' . $uc_setting['title'] . '账号尚未绑定系统账号');
		}
	}
	template('auth/uc-login');
	exit;
}
	*/

	}

	public function _user_account(){
		global $_W, $_GPC;
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
		$_GPC['do'] = 'alive';
		include $this->template ( 'web/kobe_tpl/user_alive' );
	}

}

