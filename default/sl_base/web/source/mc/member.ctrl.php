<?php
/**
 * [WeEngine System] Copyright (c) 2014 WE7.CC
 * WeEngine is NOT a free software, it under the license terms, visited http://www.we7.cc/ for more details.
 */
defined('IN_IA') or exit('Access Denied');
require IA_ROOT . '/addons/xsy_resource/device_inc/device.inc.php';  //kobe新增
uni_user_permission_check('mc_member');
$dos = array('display', 'post','del', 'add', 'group','strategy', 'credit_record', 'credit_stat','download','up_excel','show_list','show_tpl','user_excel_form');
$do = in_array($do, $dos) ? $do : 'display';
load()->model('mc');
if($do == 'display') {
    $_W['page']['title'] = '会员列表 - 会员 - 会员中心';
    $groups = mc_groups();
    $pindex = max(1, intval($_GPC['page']));
    $psize = 50;
    $condition = '';
    $params = array(':uniacid' => $_W['uniacid']);
    $starttime = empty($_GPC['createtime']['start']) ? strtotime('-90 days') : strtotime($_GPC['createtime']['start']);
    $endtime = empty($_GPC['createtime']['end']) ? TIMESTAMP + 86399 : strtotime($_GPC['createtime']['end']) + 86399;
    $condition .= " AND createtime >= {$starttime} AND createtime <= {$endtime}";
    $condition .= empty($_GPC['username']) ? '' : " AND ((`uid` = :openid) OR ( `realname` LIKE :username ) OR ( `nickname` LIKE :username ) OR ( `mobile` LIKE :username ))";
    if (!empty($_GPC['username'])) {
        $params[':username'] =  '%'.trim($_GPC['username']).'%';
        if (!is_numeric(trim($_GPC['username']))) {
            $uid = pdo_fetchcolumn('SELECT `uid` FROM'. tablename('mc_mapping_fans')." WHERE openid = :openid", array(':openid' => trim($_GPC['username'])));
            $params[':openid'] =  $uid;
        } else {
            $params[':openid'] =  $_GPC['username'];
        }
    }
    if (!empty($_GPC['uid'])) {
        $condition .= " AND uid = :uid";
        $params[':uid'] = $_GPC['uid'];
    }
    $condition .= intval($_GPC['groupid']) > 0 ?  " AND `groupid` = '".intval($_GPC['groupid'])."'" : '';
    if(checksubmit('export_submit', true)) {
        $count = pdo_fetchcolumn("SELECT COUNT(*) FROM". tablename('mc_members')." WHERE uniacid = :uniacid ".$condition, $params);
        $pagesize = ceil($count/5000);
        $header = array(
            'uid' => 'UID', 'nickname' => '昵称', 'realname' => '用户名', 'groupid' => '会员组', 'mobile' => '手机', 'email' => '邮箱',
            'credit1' => '积分', 'credit2' => '余额', 'createtime' => '注册时间',
        );
        $keys = array_keys($header);
        $html = "\xEF\xBB\xBF";
        foreach ($header as $li) {
            $html .= $li . "\t ,";
        }
        $html .= "\n";



        for ($j = 1; $j <= $pagesize; $j++) {
            $sql = "SELECT uid, uniacid, groupid, realname, nickname, email, mobile, credit1, credit2, credit6, createtime  FROM " . tablename('mc_members') . " WHERE uniacid = :uniacid " . $condition . " ORDER BY createtime limit " . ($j - 1) * 5000 . ",5000 ";
            $list = pdo_fetchall($sql, $params);
            if (!empty($list)) {
                $size = ceil(count($list) / 500);
                for ($i = 0; $i < $size; $i++) {
                    $buffer = array_slice($list, $i * 500, 500);
                    foreach ($buffer as $row) {
                        if (strexists($row['email'], 'we7.cc')) {
                            $row['email'] = '';
                        }
                        $row['createtime'] = date('Y-m-d H:i:s', $row['createtime']);
                        $row['groupid'] = $groups[$row['groupid']]['title'];
                        foreach ($keys as $key) {
                            $data[] = $row[$key];
                        }
                        $user[] = implode("\t ,", $data) . "\t ,";
                        unset($data);
                    }
                    $html .= implode("\n", $user);
                }
            }
        }
        header("Content-type:text/csv");
        header("Content-Disposition:attachment; filename=会员数据.csv");
        echo $html;
        exit();
    }

        if($_W['role_bool']){//筛选用户自己看到自己 
            $condition .= " AND uid = :uid";
            $params[':uid'] = $_W['uid'];               
        } 
    $sql = "SELECT uid, uniacid, groupid, realname,strategy_id,nickname, email, mobile, credit1, credit2, credit6, createtime  FROM ".tablename('mc_members')." WHERE uniacid = :uniacid ".$condition." ORDER BY createtime DESC LIMIT " . ($pindex - 1) * $psize . ',' . $psize;
    $list = pdo_fetchall($sql, $params);
    if(!empty($list)) {
        foreach($list as &$li) {
            if(empty($li['email']) || (!empty($li['email']) && substr($li['email'], -6) == 'we7.cc' && strlen($li['email']) == 39)) {
                $li['email_effective'] = 0;
            } else {
                $li['email_effective'] = 1;
            }
        }
    }
    $total = pdo_fetchcolumn("SELECT COUNT(*) FROM ".tablename('mc_members')." WHERE uniacid = '{$_W['uniacid']}' ".$condition);
    $pager = pagination($total, $pindex, $psize);
    $stat['total'] = pdo_fetchcolumn('SELECT COUNT(*) FROM ' . tablename('mc_members') . ' WHERE uniacid = :uniacid', array(':uniacid' => $_W['uniacid']));
    $stat['today'] = pdo_fetchcolumn('SELECT COUNT(*) FROM ' . tablename('mc_members') . ' WHERE uniacid = :uniacid AND createtime >= :starttime AND createtime <= :endtime', array(':uniacid' => $_W['uniacid'], ':starttime' => strtotime('today'), ':endtime' => strtotime('today') + 86399));
    $stat['yesterday'] = pdo_fetchcolumn('SELECT COUNT(*) FROM ' . tablename('mc_members') . ' WHERE uniacid = :uniacid AND createtime >= :starttime AND createtime <= :endtime', array(':uniacid' => $_W['uniacid'], ':starttime' => strtotime('today')-86399, ':endtime' => strtotime('today')));

    $sql = "select * from " . tablename ( 'ms_strategy' );
    $strategy = pdo_fetchall($sql);//策略列表



if (count($list)==1) {
    foreach ($strategy as $key => $value) {
        if($value['id']==$list[0]['strategy_id']){
            $temple_name=$value['temple_name'];
        }
    }

    if($temple_name!==""){
        $sql = "select excel_data from " . tablename ( 'xsy_resource_file' ) . "where id=".$temple_name;
        $excel_data=json_decode(pdo_fetchcolumn($sql), true);
        $data_name=array();
        foreach ($excel_data as $key => $value) {
            $data_name[]=$value[0];
            unset($excel_data[$key][0]);
        }
        $excel_info=array();
        $data_key=0;
        foreach ($excel_data as $key => $value) {
            $excel_info[$key][$data_name[$data_key]]=$value;
            $data_key++;
        }

        $tem_str="";
        foreach ($excel_info as $key => $value) {
            foreach ($value as $k1 => $v1) {
                $v1_len=count($v1);
                $v1_height=$v1_len<5 ?  100 : $v1_len * 35;
                $tem_str.='<div class="form-group">
                            <label class="col-xs-10 col-sm-3 col-md-3 control-label">'.$k1.'</label>
                            <div class="col-sm-6 col-xs-12">
                                <textarea class="form-control" style="height:'.$v1_height.'px" name="excel_info['.$key.'][]">';
                foreach ($v1 as $k2 => $v2) {
                    $tem_str.=$v2."\n";
                }
                $tem_str.='</textarea>
                            </div>
                        </div>';
            }
        }
    }







// echo "<pre>";
// print_r($_W['uid']);
// exit;



       
}



}
if($do == 'post') {
    $_W['page']['title'] = '编辑会员资料 - 会员 - 会员中心';
    $uid = intval($_GPC['uid']);
    if ($_W['ispost'] && $_W['isajax']) {
        if ($_GPC['op'] == 'addaddress' || $_GPC['op'] == 'editaddress') {
            $post = array(
                'uniacid' => $_W['uniacid'],
                'province' => trim($_GPC['province']),
                'city' => trim($_GPC['city']),
                'district' => trim($_GPC['district']),
                'address' => trim($_GPC['detail']),
                'uid' => intval($_GPC['uid']),
                'username' => trim($_GPC['name']),
                'mobile' => trim($_GPC['phone']),
                'zipcode' => trim($_GPC['code'])
            );
            if ($_GPC['op'] == 'addaddress') {
                $sql = "SELECT COUNT(*) FROM ". tablename('mc_member_address'). " WHERE uniacid = :uniacid AND uid = :uid";
                $exist_address = pdo_fetchcolumn($sql, array(':uniacid' => $post['uniacid'], ':uid' => $uid));
                if (!$exist_address) {
                    $post['isdefault'] = 1;
                }
                pdo_insert('mc_member_address', $post);
                $post['id'] = pdo_insertid();
                message(error(1, $post), '', 'ajax');
            } else {
                pdo_update('mc_member_address', $post, array('id' => intval($_GPC['id']), 'uniacid' => $_W['uniacid']));
                $post['id'] = intval($_GPC['id']);
                message(error(1, $post), '', 'ajax');
            }
        }
        if ($_GPC['op'] == 'del') {
            $id = intval($_GPC['id']);
            pdo_delete('mc_member_address', array('id' => $id, 'uniacid' => $_W['uniacid']));
            message(error(1), '', 'ajax');
        }
        if ($_GPC['op'] == 'isdefault') {
            $id = intval($_GPC['id']);
            $uid = intval($_GPC['uid']);
            pdo_update('mc_member_address', array('isdefault' => 0), array('uid' => $uid, 'uniacid' => $_W['uniacid']));
            pdo_update('mc_member_address', array('isdefault' => 1), array('id' => $id, 'uniacid' => $_W['uniacid']));
            message(error(1), '', 'ajax');
        }


        if ($_GPC['op'] == 'updatestrategy') {
            $uid = intval($_GPC['uid']);
            $strategy_id = intval($_GPC['strategy_id']);
            pdo_update('mc_members', array('strategy_id' => $strategy_id), array('uid' => $uid));

            

            message(error(1), '', 'ajax');

        }

        
        $password = $_GPC['password'];
        $sql = 'SELECT `uid`, `salt` FROM ' . tablename('mc_members') . " WHERE `uniacid`=:uniacid AND `uid` = :uid";
        $user = pdo_fetch($sql, array(':uniacid' => $_W['uniacid'], ':uid' => $uid));
        if(empty($user) || $user['uid'] != $uid) {
            exit('error');
        }
        $password = md5($password . $user['salt'] . $_W['config']['setting']['authkey']);
        if (pdo_update('mc_members', array('password' => $password), array('uid' => $uid))) {
            exit('success');
        }
        exit('othererror');
    }
    if (checksubmit('submit')) {
        $uid = intval($_GPC['uid']);
        if (!empty($_GPC)) {
            if (!empty($_GPC['birth'])) {
                $_GPC['birthyear'] = $_GPC['birth']['year'];
                $_GPC['birthmonth'] = $_GPC['birth']['month'];
                $_GPC['birthday'] = $_GPC['birth']['day'];
            }
            if (!empty($_GPC['reside'])) {
                $_GPC['resideprovince'] = $_GPC['reside']['province'];
                $_GPC['residecity'] = $_GPC['reside']['city'];
                $_GPC['residedist'] = $_GPC['reside']['district'];
            }
            unset($_GPC['uid']);
            if(!empty($_GPC['fanid'])) {
                if(empty($_GPC['email']) && empty($_GPC['mobile'])) {
                    $_GPC['email'] = md5($_GPC['openid']) . '@we7.cc';
                }
                $fanid = intval($_GPC['fanid']);
                $struct = array_keys(mc_fields());
                $struct[] = 'birthyear';
                $struct[] = 'birthmonth';
                $struct[] = 'birthday';
                $struct[] = 'resideprovince';
                $struct[] = 'residecity';
                $struct[] = 'residedist';
                $struct[] = 'groupid';
                unset($_GPC['reside'], $_GPC['birth']);
                foreach ($_GPC as $field => $value) {
                    if(!in_array($field, $struct)) {
                        unset($_GPC[$field]);
                    }
                }

                if(!empty($_GPC['avatar'])) {
                    if(strexists($_GPC['avatar'], 'attachment/images/global/avatars/avatar_')) {
                        $_GPC['avatar'] = str_replace($_W['attachurl'], '', $_GPC['avatar']);
                    }
                }
                $condition = '';
                                if(!empty($_GPC['email'])) {
                    $emailexists = pdo_fetchcolumn("SELECT email FROM ".tablename('mc_members')." WHERE uniacid = :uniacid AND email = :email " . $condition, array(':uniacid' => $_W['uniacid'], ':email' => trim($_GPC['email'])));
                    if($emailexists) {
                        unset($_GPC['email']);
                    }
                }
                if(!empty($_GPC['mobile'])) {
                    $mobilexists = pdo_fetchcolumn("SELECT mobile FROM ".tablename('mc_members')." WHERE uniacid = :uniacid AND mobile = :mobile " . $condition, array(':uniacid' => $_W['uniacid'], ':mobile' => trim($_GPC['mobile'])));
                    if($mobilexists) {
                        unset($_GPC['mobile']);
                    }
                }
                $_GPC['uniacid'] = $_W['uniacid'];
                $_GPC['createtime'] = TIMESTAMP;
                pdo_insert('mc_members', $_GPC);
                $uid = pdo_insertid();
                pdo_update('mc_mapping_fans', array('uid' => $uid), array('fanid' => $fanid, 'uniacid' => $_W['uniacid']));
                message('更新资料成功！', url('mc/member/post', array('uid' => $uid)), 'success');
            } else {
                $email_effective = intval($_GPC['email_effective']);
                if(($email_effective == 1 && empty($_GPC['email']))) {
                    unset($_GPC['email']);
                }
                unset($_GPC['addresss']);
                $uid = mc_update($uid, $_GPC);
            }
        }
        message('更新资料成功！', referer(), 'success');
    }
    $groups = mc_groups($_W['uniacid']);
    $profile = pdo_get('mc_members', array('uniacid' => $_W['uniacid'], 'uid' => $uid));
    if(!empty($profile)) {
        if(empty($profile['email']) || (!empty($profile['email']) && substr($profile['email'], -6) == 'we7.cc' && strlen($profile['email']) == 39)) {
                        $profile['email_effective'] = 1;
            $profile['email'] = '';
        } else {
                        $profile['email_effective'] = 2;
        }
    }
    $all_fields = mc_fields();
    $custom_fields = array();
    $base_fields = cache_load('userbasefields');
    $base_fields = array_keys($base_fields);
    foreach ($all_fields as $field => $title) {
        if (!in_array($field, $base_fields)) {
            $custom_fields[] = $field;
        }
    }
    if(empty($uid)) {
        $fanid = intval($_GPC['fanid']);
        $tag = pdo_fetchcolumn('SELECT tag FROM ' . tablename('mc_mapping_fans') . ' WHERE uniacid = :uniacid AND fanid = :fanid', array(':uniacid' => $_W['uniacid'], ':fanid' => $fanid));
        if(is_base64($tag)){
            $tag = base64_decode($tag);
        }
        if(is_serialized($tag)){
            $fan = iunserializer($tag);
        }
        if(!empty($tag)) {
            if(!empty($fan['nickname'])) {
                $profile['nickname'] = $fan['nickname'];
            }
            if(!empty($fan['sex'])) {
                $profile['gender'] = $fan['sex'];
            }
            if(!empty($fan['city'])) {
                $profile['residecity'] = $fan['city'] . '市';
            }
            if(!empty($fan['province'])) {
                $profile['resideprovince'] = $fan['province'] . '省';
            }
            if(!empty($fan['country'])) {
                $profile['nationality'] = $fan['country'];
            }
            if(!empty($fan['headimgurl'])) {
                $profile['avatar'] = rtrim($fan['headimgurl'], '0') . 132;
            }
        }
    }
    $addresss = pdo_getall('mc_member_address', array('uid' => $uid, 'uniacid' => $_W['uniacid']));


    $sql = "select id,info,name from " . tablename ( 'ms_strategy' );
    $strategy = pdo_fetchall($sql);//策略列表


}

if($do == 'del') {
    $_W['page']['title'] = '删除会员资料 - 会员 - 会员中心';
    if(checksubmit('submit')) {
        if(!empty($_GPC['uid'])) {
            $delete_uids = array();
            foreach ($_GPC['uid'] as $uid) {
                $uid = intval($uid);
                if (!empty($uid)) {
                    $delete_uids[] = intval($uid);
                }
            }
            if (!empty($delete_uids)) {
                $tables = array('mc_members', 'mc_card_members', 'mc_card_notices', 'mc_card_notices_unread', 'mc_card_record', 'mc_card_sign_record', 'mc_cash_record', 'mc_credits_recharge', 'mc_credits_record', 'mc_mapping_fans', 'mc_member_address', 'mc_mapping_ucenter');
                foreach ($tables as $key => $value) {
                    pdo_delete($value, array('uniacid' => $_W['uniacid'], 'uid' => $delete_uids));
                }
                message('删除成功！', referer(), 'success');
            }
        }
        message('请选择要删除的项目！', referer(), 'error');
    }
}

if($do == 'add') {
    if($_W['isajax']) {
        $type = trim($_GPC['type']);
        $data = trim($_GPC['data']);
        if(empty($data) || empty($type)) {
            exit(json_encode(array('valid' => false)));
        }
        $user = pdo_get('mc_members', array('uniacid' => $_W['uniacid'], $type => $data));
        if(empty($user)) {
            exit(json_encode(array('valid' => true)));
        } else {
            exit(json_encode(array('valid' => false)));
        }
    }
    if(checksubmit('form')) {
        // $ms_code = trim($_GPC['ms_code']) ? trim($_GPC['ms_code']) : message('手机序号不能为空');
        $realname = trim($_GPC['realname']) ? trim($_GPC['realname']) : message('用户名不能为空');
        $mobile = trim($_GPC['mobile']) ? trim($_GPC['mobile']) : message('手机不能为空');
        // $strategy_id = trim($_GPC['strategy_id']) ? trim($_GPC['strategy_id']) : message('策略不能为空');
        $user = pdo_get('mc_members', array('uniacid' => $_W['uniacid'], 'mobile' => $mobile));
        if(!empty($user)) {
            message('手机号被占用');
        }
        $email = trim($_GPC['email']);
        if(!empty($email)) {
            $user = pdo_get('mc_members', array('uniacid' => $_W['uniacid'], 'email' => $email));
            if(!empty($user)) {
                message('邮箱被占用');
            }
        }
        $salt = random(8);
        $data = array(
            'uniacid' => $_W['uniacid'],
            // 'ms_code' => $ms_code,
            // 'strategy_id' => $strategy_id,
            'realname' => $realname,
            'mobile' => $mobile,
            'email' => $email,
            'salt' => $salt,
            'password' => md5(trim($_GPC['password']) . $salt . $_W['config']['setting']['authkey']),
            'credit1' => intval($_GPC['credit1']),
            'credit2' => intval($_GPC['credit2']),
            'groupid' => intval($_GPC['groupid']),
            'createtime' => TIMESTAMP,
        );
        pdo_insert('mc_members', $data);
        $uid = pdo_insertid();
        message('添加会员成功,将进入编辑页面', url('mc/member/post', array('uid' => $uid)), 'success');
    }
}
if($do == 'strategy') {
    if($_W['isajax']) {
        $strategy_id = intval($_GPC['strategy_id']);
        $uid = intval($_GPC['uid']);
        $status=pdo_update('mc_members', array('strategy_id' => $strategy_id), array('uid' => $uid, 'uniacid' => $_W['uniacid']));

        if($status !== false) {

            //kobe 新增修改策略的刷新操作； 手机会跟着刷新
            $ms_act = pdo_fetchcolumn ("SELECT realname FROM " .tablename('mc_members') . " WHERE uid=".$uid);
            //error_log("updatestrategy");
            if(!empty($ms_act) )
            {
                update_user_strategy($ms_act);
            }

            exit('success');
        } else {
            exit('更新策略出错');
        }
    }
    exit('error');
}
if($do == 'group') {
    if($_W['isajax']) {
        $id = intval($_GPC['id']);
        $group = $_W['account']['groups'][$id];
        if(empty($group)) {
            exit('会员组信息不存在');
        }
        $uid = intval($_GPC['uid']);
        $member = mc_fetch($uid);
        if(empty($member)) {
            exit('会员信息不存在');
        }
        $credit = intval($group['credit']);
        $credit6 = $credit - $member['credit1'];
        $status = pdo_update('mc_members', array('credit6' => $credit6, 'groupid' => $id), array('uid' => $uid, 'uniacid' => $_W['uniacid']));
        if($status !== false) {
            $openid = pdo_fetchcolumn('SELECT openid FROM ' . tablename('mc_mapping_fans') . ' WHERE acid = :acid AND uid = :uid', array(':acid' => $_W['acid'], ':uid' => $uid));
            if(!empty($openid)) {
                mc_notice_group($openid, $_W['account']['groups'][$member['groupid']]['title'], $_W['account']['groups'][$id]['title']);
            }
            exit('success');
        } else {
            exit('更新会员信息出错');
        }
    }
    exit('error');
}

if($do == 'credit_record') {
    $_W['page']['title'] = '积分日志-会员管理';
    $uid = intval($_GPC['uid']);
    $credits = array(
        'credit1' => '积分',
        'credit2' => '余额'
    );
    $type = trim($_GPC['type']) ? trim($_GPC['type']) : 'credit1';
    $pindex = max(1, intval($_GPC['page']));
    $psize = 50;
    $total = pdo_fetchcolumn("SELECT COUNT(*) FROM " . tablename('mc_credits_record') . ' WHERE uid = :uid AND uniacid = :uniacid AND credittype = :credittype ', array(':uniacid' => $_W['uniacid'], ':uid' => $uid, ':credittype' => $type));
    $data = pdo_fetchall("SELECT r.*, u.username FROM " . tablename('mc_credits_record') . ' AS r LEFT JOIN ' .tablename('users') . ' AS u ON r.operator = u.uid ' . ' WHERE r.uid = :uid AND r.uniacid = :uniacid AND r.credittype = :credittype ORDER BY id DESC LIMIT ' . ($pindex - 1) * $psize .',' . $psize, array(':uniacid' => $_W['uniacid'], ':uid' => $uid, ':credittype' => $type));
    $pager = pagination($total, $pindex, $psize);
    $modules = pdo_getall('modules', array('issystem' => 0), array('title', 'name'), 'name');
    $modules['card'] = array('title' => '会员卡', 'name' => 'card');
}

if($do == 'credit_stat') {
    $_W['page']['title'] = '积分日志-会员管理';
    $uid = intval($_GPC['uid']);
    $credits = array(
        'credit1' => '积分',
        'credit2' => '余额'
    );
    $type = intval($_GPC['type']);
    $starttime = strtotime('-7 day');
    $endtime = strtotime('7 day');
    if($type == 1) {
        $starttime = strtotime(date('Y-m-d'));
        $endtime = TIMESTAMP;
    } elseif($type == -1) {
        $starttime = strtotime('-1 day');
        $endtime = strtotime(date('Y-m-d'));
    } else{
        $starttime = strtotime($_GPC['datelimit']['start']);
        $endtime = strtotime($_GPC['datelimit']['end']) + 86399;
    }
    if(!empty($credits)) {
        $data = array();
        foreach($credits as $key => $li) {
            $data[$key]['add'] = round(pdo_fetchcolumn('SELECT SUM(num) FROM ' . tablename('mc_credits_record') . ' WHERE uniacid = :id AND uid = :uid AND createtime > :start AND createtime < :end AND credittype = :type AND num > 0', array(':id' => $_W['uniacid'], ':uid' => $uid, ':start' => $starttime, ':end' => $endtime, ':type' => $key)),2);
            $data[$key]['del'] = abs(round(pdo_fetchcolumn('SELECT SUM(num) FROM ' . tablename('mc_credits_record') . ' WHERE uniacid = :id AND uid = :uid AND createtime > :start AND createtime < :end AND credittype = :type AND num < 0', array(':id' => $_W['uniacid'], ':uid' => $uid, ':start' => $starttime, ':end' => $endtime, ':type' => $key)),2));
            $data[$key]['end'] = $data[$key]['add'] - $data[$key]['del'];
        }
    }
}


/*原下载模板*/
// if($do == 'download') {

//     if($_W['isajax']) {
//         $uid = intval($_GPC['uid']);
//         $path = pdo_fetchcolumn("SELECT path FROM ". tablename('mc_members')." a 
//             LEFT JOIN ".tablename('ms_strategy')." b on a.strategy_id=b.id 
//             LEFT JOIN ".tablename('xsy_resource_file')." c on b.temple_name=c.id  
//             WHERE a.uid=".$uid);

//         if(empty($path)){
//             exit('error');
//         }

//         exit($path);
//     }
//     exit('othererror');
// }




if($do == 'up_excel') {

        $uid=$_GPC['uid'];

        $strategy_id = pdo_fetchcolumn("SELECT strategy_id FROM ". tablename('mc_members')." WHERE uid=".$uid);

        if(empty($strategy_id)){
            message('请先绑定策略再上传!', referer(), 'error');
        }



        require IA_ROOT . '/addons/xsy_resource/defines.php';

        $file = $_FILES ["up_excel"];
        $filesize = $file ["size"];
        $filetype = $file ["type"];

        if(empty($file)){
            message('请选择上传的文件', referer(), 'error');
        }
        
        if($filesize>2000000){
            message('文件大小不能超过2M。', referer(), 'error');
        }



        $file_types = explode ( ".", $file['name'] );
        $file_type = $file_types [count ( $file_types ) - 1];
        $file_type = strtolower ( $file_type );
        if ( $file_type!== "xls" && $file_type !== 'xlsx'){
            message('请上传 xls 或 xlsx 格式的Excel文件!', referer(), 'error');
        }
        $filename=substr($file ["name"],strrpos($file ["name"], "."));
        $filepath = "file/" . $_W ['uniacid'] . "/" . date ( 'Ymd' ) . "/";//ATTACHMENT下的目录
        $filename = date ( 'Ymdhis' ). rand(0,999) . $filename;//文件名

        $path=ATTACHMENT_ROOT.$filepath;//检测目录

        if (! is_readable ( $path )) {
            is_file ( $path ) or mkdir ( $path, 0700, true );
        }

        $pathname =  $filepath . $filename;//ATTACHMENT下的目录+文件名
        $filepath = ATTACHMENT_ROOT. $pathname;//绝对路径+ATTACHMENT下的目录+文件名

            if (move_uploaded_file ( $file ['tmp_name'], $filepath )) {

                include GARCIA_OSS."index.php";
                $oss=$_W['setting']['remote']['alioss'];

                if(!empty($oss['key'])&&!empty($oss['secret'])&&!empty($oss['url'])){
                    $_ossClient = new _ali($oss['key'],$oss['secret'],$oss['ossurl'],$oss['bucket'],$oss['url']);
                }

            $_result = $_ossClient->multiuploadFile($pathname,$filepath,array('type'=>1));//上传返回status,imgurl;


            if (!$_result){
                message('上传Excel 文件失败, 请重新上传!', '', 'error');
            }

            $data = array (
                    "info" => $_GPC['info'],
                    'type' => $_GPC['type'],
                    'owner_id' => $uid,
                    'origin_name'=>$file ['name'],
                    'name' => $filename,
                    "path" => $_result['imgurl'],
                    "time" => time ()
            );

            pdo_insert ( "xsy_resource_file", $data );
            $file_id=pdo_insertid();
           
            //kobe 更新缓存
            $ms_act = pdo_fetchcolumn ("SELECT realname FROM " .tablename('mc_members') . " WHERE uid=".$uid);
            //error_log("updatestrategy");
            if(!empty($ms_act) )
            {
                update_user_strategy($ms_act);
            }


                
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
    /*kobe将客户的数据包起来*/
    $is_new_version = true;  
    if ("user_data_v01" == end($filed) ){

        $is_new_version = true;
    }
/**
 * excel读取end
 */

	//处理成lua格式
	$lua_data="";

	foreach ($data as $key => $value) {  //现在的做法是，将如如果是空的值，就去掉
        if( true == $is_new_version){ /*kobe将客户的数据包起来*/
            if(!empty($key) && !empty($value) ){
                $lua_data.=$key."={'".implode("','", $value)."'}".",\n";
            }
        }
        else{
            if(!empty($key) && !empty($value) ){
                $lua_data.=$key."={'".implode("','", $value)."'}"."\n";
            }
        }
	}
    /*kobe将客户的数据包起来*/
    if( true == $is_new_version){ 
        $lua_data = "_U = {"."\n".$lua_data."\n"."}";
    }

        $json_data=json_encode($data); 
        unset($data);

        $filepath = "memberlua/" . $_W ['uniacid'] . "/" . date ( 'Ymd' ) . "/";//ATTACHMENT下的目录
        $path=ATTACHMENT_ROOT.$filepath;//检测目录

        if (! is_readable ( $path )) {//创建目录
            is_file ( $path ) or mkdir ( $path, 0700, true );
        }

        //创建文件
        $filename =$uid.'_'.$strategy_id.'_'.date ( 'Ymdhis' ).rand(0,999).'.lua';//文件名及路径,在当前目录下新建xxx.xxx文件 
        $pathname =  $filepath . $filename;//ATTACHMENT下的目录+文件名
        $filepath = ATTACHMENT_ROOT. $pathname;//绝对路径+ATTACHMENT下的目录+文件名
        $fopen =  fopen('../attachment/'.$pathname,'w') or die("Unable to open file!");//新建文件命令 
        fputs($fopen, $lua_data);//向文件中写入内容; 
        fclose($fopen); 


        if(!empty($oss['key'])&&!empty($oss['secret'])&&!empty($oss['url'])){
            $_ossClient = new _ali($oss['key'],$oss['secret'],$oss['ossurl'],$oss['bucket'],$oss['url']);
        }

        $_result = $_ossClient->multiuploadFile($pathname,$filepath,array('type'=>1));//上传返回status,imgurl;

        if ($_result['status']!==1){
            message('上传文件失败, 请重新上传!', '', 'error');
        }

                $data=array(
                    // 'user_id'=>$uid,
                    'user_type'=>'',
                    // 'strategy_id'=>$strategy_id,
                    'file_id'=>$file_id,
                    'user_config'=>$json_data,
                    'user_config_path'=>$_result['imgurl'],
                );
			$id = pdo_fetchcolumn('SELECT id FROM'. tablename('xxx_user_strategy_table')." WHERE user_id =".$uid.' and strategy_id='.$strategy_id);

			if(!empty($id)){
				pdo_update('xxx_user_strategy_table', $data,array('id' => $id));	
			}else{
				$data['user_id']=$uid;
				$data['strategy_id']=$strategy_id;
				pdo_insert('xxx_user_strategy_table', $data);
			}
                message('上传成功！', referer(), 'success');

            }

}
if($do == 'show_list') {

    if($_W['isajax']) {
        $uid = intval($_GPC['uid']);
        $data = pdo_fetchall("SELECT a.id,a.name,b.name as strategyname FROM " . tablename('xxx_user_strategy_table')." a LEFT JOIN " . tablename('ms_strategy')." b on a.strategy_id=b.id
                where a.user_id=".$uid);

    }
    exit(json_encode($data));
}
if($do == 'show_tpl') {

    if($_W['isajax']) {
        $id=$_GPC['id'];
        $data = pdo_fetchcolumn("SELECT user_config FROM " . tablename('xxx_user_strategy_table') . 
                "where id=".$id);//取出已经是json格式


    }
    exit($data);
}
if($do == 'user_excel_form') {

        $name=$_GPC['name'];
        if(empty($name)){
            message('请输入这个模板的名称', '', 'error');
            exit;
        }
        $uid=$_GPC['uid'];
        $strategy_id = pdo_fetchcolumn("SELECT strategy_id FROM ". tablename('mc_members')." WHERE uid=".$uid);
        if(!empty($_GPC['excel_info']) && !empty($strategy_id) && !empty($uid)){

            $excel_info=$_GPC['excel_info'];
            foreach ($excel_info as $key => $value) {//转换回车
                $excel_info[$key]=explode("\n",$value[0]);
            }
            foreach ($excel_info as $key => $value) {
                foreach ($value as $k => $v) {//去除多余的回车，空值
                    if(empty($v)){
                        unset($excel_info[$key][$k]);
                    }
                }
            }


/*kobe将客户的数据包起来*/
    $is_new_version = false;  
    if ("user_data_v01" == end($filed) ){

        $is_new_version = true;
    }
/**
 * excel读取end
 */

    //处理成lua格式
    $lua_data="";

    foreach ($excel_info as $key => $value) {  //现在的做法是，将如如果是空的值，就去掉
        if( true == $is_new_version){ /*kobe将客户的数据包起来*/
            if(!empty($key) && !empty($value) ){
                $lua_data.=$key."={'".str_replace("\r", "", implode("','", $value))."'}".",\n";
            }
        }
        else{
            if(!empty($key) && !empty($value) ){
                $lua_data.=$key."={'".str_replace("\r", "", implode("','", $value))."'}"."\n";
            }
        }
    }

    /*kobe将客户的数据包起来*/
    if( true == $is_new_version){
        $lua_data = "_U = {"."\n".$lua_data."\n"."}";
    }

        require IA_ROOT . '/addons/xsy_resource/defines.php';
        $filepath = "memberlua/" . $_W ['uniacid'] . "/" . date ( 'Ymd' ) . "/";//ATTACHMENT下的目录
        $path=ATTACHMENT_ROOT.$filepath;//检测目录

        if (! is_readable ( $path )) {//创建目录
            is_file ( $path ) or mkdir ( $path, 0700, true );
        }

        //创建文件
        $filename =$uid.'_'.$strategy_id.'_'.date ( 'Ymdhis' ).rand(0,999).'.lua';//文件名及路径,在当前目录下新建xxx.xxx文件 


        $pathname =  $filepath . $filename;//ATTACHMENT下的目录+文件名
        $filepath = ATTACHMENT_ROOT. $pathname;//绝对路径+ATTACHMENT下的目录+文件名
        $fopen =  fopen('../attachment/'.$pathname,'w') or die("Unable to open file!");//新建文件命令 
        fputs($fopen, $lua_data);//向文件中写入内容; 
        fclose($fopen); 
        include GARCIA_OSS."index.php";
        $oss=$_W['setting']['remote']['alioss'];
        if(!empty($oss['key'])&&!empty($oss['secret'])&&!empty($oss['url'])){
            $_ossClient = new _ali($oss['key'],$oss['secret'],$oss['ossurl'],$oss['bucket'],$oss['url']);
        }


        $_result = $_ossClient->multiuploadFile($pathname,$filepath,array('type'=>1));//上传返回status,imgurl;

        if ($_result['status']!==1){
            message('上传lua文件失败, 请重试!', '', 'error');
        }
                $data=array(
                    'user_id'=>$uid,
                    'name'=>$name,
                    'strategy_id'=>$strategy_id,
                    'user_config'=>json_encode($excel_info),
                    'user_config_path'=>$_result['imgurl'],
                );

                pdo_insert('xxx_user_strategy_table', $data);
            message('上传成功！', referer(), 'success');
        }

}
template('mc/member');



