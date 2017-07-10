<?php
/**
 * @Author: 特筹网
 * @Date:   2017-01-12 14:41:04
 * @Last Modified by:   gangan
 * @Last Modified time: 2017-03-30 11:06:14
 */
header('Content-Type:text/html;charset=utf-8'); 
//require_once '../../framework/bootstrap.inc.php';  //系统初始化--这个地方需要优化，只初始化ql和cache就好了，其他的不用
require_once 'device_inc/sys.inc.php';
require_once 'device_inc/misc.inc.php';
require_once 'device_inc/device.inc.php';

/**
 *  $arr->数组   $sort->排序顺序标志 
 *  排序顺序标志 SORT_DESC 降序；SORT_ASC 升序 ,
 */

class GETTASK {
    public $time            = 1489218514; //2017-03-11 03:48:34pm
    public $account         = "";       //账户
    public $user_id         = "";      // user's id
    public $device_id       = "";    //设备ID
    public $error_num       = 0;  //容错的次数
    public $dev_msg         = null; //设备传过来的消息
    public $is_send_token   = false; //是否返回给设备token信息
    public $is_update_alive_ms_table = false;

    //memcached相关，缓存数据
    public $m_dev_task_list   = null;
    public $m_dev_info        = null;
    public $m_dev_track_info  = null;
    public $m_user_info       = null;
    public $m_g_info          = null;

    //文件头，命名规则
    public $pre_fix_dev_id   = null;
    public $pre_fix_user_act = null;

    function task($get){
        log_info("----enter task-----");

        //step1 检测设备发送的消息是否okay
        $this->check_device_msg($get);

        //step2 检查系统是否在维护状态
        $this->check_web_status();

        //step3 检查用户的合法性
        $this->check_user();

        //step4 检查策略 & idle_task& user_config
        $this->check_user_strategy();

        //step5 检查device
        $this->check_device();

        //step6 返回任务清单
        //$data = $this->allot($alive_data['account'], $alive_data['ms_id']);
        $data = $this->allot();
        if($this->is_send_token == true)
        {
            $data['token'] = $this->m_dev_info['token'];
        }
        log_info("after allot");

        //刷新设备的cache
        $this->m_dev_info['time'] = $this->time;
        $this->m_dev_info['ip']   = $_SERVER['REMOTE_ADDR'];
        //error_log('dev_ip = ' . $this->m_dev_info['ip']);

        cache_write($this->pre_fix_dev_id . "dev_info", $this->m_dev_info);
        $code=101;
        $message='成功';
        return $this->output($code, $message, $data);
    }

    //返回给设备数据
    function output($code, $message,  $data){
        $output = array(
            'code'=>$code ,
            'message'=>$message
        );
        if($data != false){
            $output['data']=$data;
        }
        exit(json_encode($output));
    }
    
    //发送给设备错误信息,并退出
    function send_error_info($code, $message){ 
         exit(json_encode($this->output($code,$message, false) ) );
    }

    //检查设备发过来的数据格式
    function check_device_msg($get){

         if (!empty($get['task'])) {
            $json = str_replace("\\", "", $get['task']);
            $data = json_decode($json,true);

            //必须要 用户名 + 设备ID + "token或pwd"
            if( ( empty($data['ms_id']) || empty($data['ms_act'])  )  || 
                ( empty($data['ms_token']) && empty($data['ms_pwd']) ) ){
                exit;
            }else{
                $this->dev_msg = $data;
                $this->pre_fix_dev_id   = $data['ms_id'] . '_';
                $this->pre_fix_user_act = $data['ms_act'] . '_';

                //读取cache中的值
               /* $this->m_g_info           = cache_read('g_info'); */
               /* $this->m_dev_task_list    = cache_read($this->pre_fix_dev_id  . 'dev_task_list');*/
               /* $this->m_dev_info         = cache_read($this->pre_fix_dev_id . 'dev_info');*/
               /* $this->m_user_info        = cache_read($this->pre_fix_dev_id  . 'user_info');*/
               /*cache_delete($this->pre_fix_dev_id  . 'dev_task_list');
               cache_delete($this->pre_fix_dev_id  . 'dev_info');
               cache_delete($this->pre_fix_user_act .'user_info');*/
            }
        }else{
            $code=103;
            $message='设备消息异常';
            $this->send_error_info($code, $message); 
            exit;
        }
    }

    //检查web的状态
    function check_web_status(){ 
        $g_info = 'g_info';
        $web_status = $this->m_g_info;
        $this->m_g_info = cache_read('g_info');
        if( empty( $this->m_g_info['is_close_ms_server'] ) ){
            $_setting = pdo_fetch('SELECT * FROM '.tablename("ms_setting")." where 1");
            if($_setting['close']==1){//站点维护开启
                $this->m_g_info['is_close_ms_server'] = true;
            }
            else{
                 $this->m_g_info['is_close_ms_server'] = false;
            }
            cache_write($g_info, $this->m_g_info); //写入全局的cache
        } 

        if ( true == $this->m_g_info['is_close_ms_server']){
            $code=105;
            $message='系统维护中';
            $this->send_error_info($code, $message); 
        }
    }
    
    //检查用户的合理性
    function check_user(){
        $this->m_user_info = cache_read($this->pre_fix_user_act  . 'user_info');
        log_info("check_user");
        if( empty($this->m_user_info['user_id']) ){
           $user = pdo_fetch('SELECT * FROM ' . tablename('mc_members') ." where realname='".$this->dev_msg['ms_act']."'");
            if(empty($user)){
                $code=107;
                $message='用户名不存在';
                $this->send_error_info($code, $message);  //发出失败的信息
            } 
            else{
                $this->m_user_info['user_id'] = $user['uid'];
                cache_write($this->pre_fix_user_act . 'user_info', $this->m_user_info);
            }
        }
        $this->user_id = $this->m_user_info['user_id'];     
    }
    
    //检查用户对应的策略是否正常。
    //设置策略的memcache
    function check_user_strategy(){
        log_info("check_user_strategy");
        if(empty($this->m_user_info['strategy_id']) || empty($this->m_user_info['idle_task']) )
        {
            $strategy = $this->get_strategy($this->dev_msg['ms_act']);//得到策略
            if (empty($strategy)){
                $this->send_error_info(102, "该用户未设置策略");
                exit;
            }
            else{
                $idle_path= pdo_fetchcolumn("SELECT path FROM " .tablename('xsy_resource_file') . " WHERE id=".$strategy['idle']);
                if (empty($idle_path)) {
                    $this->send_error_info(102, "该用户策略未设置空闲任务");
                    exit;
                }
                else{
                    log_info('+++strategy_id = ' . $strategy['id']);
                    $sql = "SELECT user_config_path FROM " .
                        tablename('xxx_user_strategy_table') .
                        " WHERE user_id='".$this->user_id."'" . "AND strategy_id = '". $strategy['id']."'";
                    $this->m_user_info['user_config_path'] = pdo_fetchcolumn($sql);
                   /* $user_config_path_array = pdo_fetchall("SELECT user_config_path FROM " .tablename('xxx_user_strategy_table') .
                        " WHERE user_id='".$this->user_id."'" );*/
                    //当用户切换策略，但是此时有没有更新模版数据，返回错误，并退出
                    if(!empty($strategy['temple_name']) && empty($this->m_user_info['user_config_path'] ) )
                    {
                        $this->send_error_info(102, "请设置用户模版数据");
                        exit;
                    }

                    log_info($sql);
                    log_info($this->m_user_info['user_config_path']);

                    $this->m_user_info['idle_task']    = $idle_path;
                    $this->m_user_info['idle_task_id'] = $strategy['idle'];
                    $this->m_user_info['strategy_id']  = $strategy['id'];
                    $strategy_task_list = $this->get_strategy_task_list($strategy['id']);
                    //得到任务的个数
                    $strategy_task_list_num = 0;
                    foreach ($strategy_task_list as $key => $value) {
                        # code...
                        $strategy_task_list_num = $strategy_task_list_num + intval($value['task_num']);
                    }
                    $this->m_user_info['task_num'] = $strategy_task_list_num;  //任务的个数
                    cache_write($this->pre_fix_user_act . 'user_info', $this->m_user_info );
                }
            }
        }
    }

    //检查设备
    function check_device(){
        global $_W;
        log_info("check_device");
        $this->m_dev_info = cache_read($this->pre_fix_dev_id . 'dev_info');
        if($this->m_dev_info['user_id'] != $this->m_user_info['user_id'] ) //如果设备更换用户，更换策略
        {   
            $this->m_dev_info       = null;
            $this->m_dev_task_list  = null;
            cache_delete($this->pre_fix_dev_id . 'dev_task_list');
            cache_delete($this->pre_fix_dev_id . 'dev_info');
        }
        
        if ( ( !empty($this->dev_msg['ms_token'] )&& !empty($this->m_dev_info['token']) ) && 
        ($this->dev_msg['ms_token'] == $this->m_dev_info['token']) ){ //正常状况
            if( ( !empty($this->dev_msg['ms_reset'] )  )&& ('true' == $this->dev_msg['ms_reset'] )  ){
                del_memc_task_list($this->dev_msg['ms_id']);  //如果是复位信息
                exit;
                //error_log("reset====");
            }
            else{
                return true;
            }
        }
        
        if(!empty($this->dev_msg['ms_pwd']))
        {
            $user = pdo_fetch('SELECT * FROM ' . tablename('mc_members') ." where realname='".$this->dev_msg['ms_act']."'");
            // 有此用户名
            log_info($this->dev_msg['ms_act'] . ':  '.$this->dev_msg['ms_pwd']);
            $salt=$user['salt'];
            $password=$user['password'];
            $ms_pwd=md5(trim($this->dev_msg['ms_pwd']) . $salt . $_W['config']['setting']['authkey']);
            if($ms_pwd==$password)
            {       
                  //如果是复位信息
                 if( ( !empty($this->dev_msg['ms_reset'] )  )&& ('true' == $this->dev_msg['ms_reset'] )  ){
                     del_memc_task_list($this->dev_msg['ms_id']);  //如果是复位信息
                     exit;
                    //error_log("reset=222===");
                 }
                // 密码正确           
                $this->m_dev_info['token']   = my_generate_token(); //产生16位的token               
                $this->m_dev_info['user_id'] = $user['uid'];
                $this->is_send_token         = true; 
                $this->is_update_alive_ms_table = true;
                log_info("111111111111111");
                $this->update_alive();            //更新alive表
                log_info("22222222");        
                cache_write($this->pre_fix_dev_id . 'dev_info', $this->m_dev_info); //写入信息
                return true;
                //return $alive_data; //can_delete
            }
            else
            {
                $code=106;
                $message = '密码错误';
            }         
        }   
        else
        {
            $code=102;
            $message='token&密码不全';            
        }   
        $this->send_error_info($code, $message);  //发出失败的信息
    }


    /**
     * 根据用户序号找出对应策略，根据策略分配任务
     * $ms_id   终端序号
     * $account 账号
     */ 
    function allot(){
        //$strategy = $this->get_strategy($account);//得到策略
        log_info("allot");
        $this->time = time();
        //如果是统计数据
        if( ( !empty($this->dev_msg['ms_track'] )  )&& ('true' == $this->dev_msg['ms_track'] ) ){
             $this->m_dev_track_info = $this->dev_msg; 
             unset($this->m_dev_track_info['ms_act'] );
             unset($this->m_dev_track_info['ms_pwd']);
             unset($this->m_dev_track_info['ms_token']);
             unset($this->m_dev_track_info['ms_track']);
	     unset($this->m_dev_track_info['ms_id']);
             unset($this->m_dev_track_info['ms_type']);
             cache_write($this->pre_fix_dev_id . "dev_track_info", $this->m_dev_track_info);
        }

        $this->m_dev_task_list = cache_read($this->pre_fix_dev_id  . 'dev_task_list'); 
        $task_list = $this->m_dev_task_list;
        $run_task_index = 0;            //要运行的任务index，初始化为0
       

        if ( empty($task_list) ) {          //未分配过任务
            error_log("ms_act =  " . $this->dev_msg['ms_act']);
            $strategy  = $this->get_strategy($this->dev_msg['ms_act']);
            error_log("strategy_id =  " . $this->m_user_info['strategy_id']);
            $task_list = $this->get_strategy_task_list($this->m_user_info['strategy_id']);
                
            if($this->dev_msg['ms_id'] == '841288W1DZZ'){   
                log_info("strategy list:");
                print_2_array($task_list);
            }

            $task_list = $this->reset_task_list($task_list, $strategy); 

            for ($task_i=0; $task_i<count($task_list) ; $task_i++) { 
                # code...
                $this->m_dev_task_list[$task_i]['task_id']          = $task_list[$task_i]['task_id'];
                $this->m_dev_task_list[$task_i]['task_data_id']     = $task_list[$task_i]['task_d_id'];
                $this->m_dev_task_list[$task_i]['task_pri']         = $task_list[$task_i]['task_pri'];
                $this->m_dev_task_list[$task_i]['task_path']        = $this->get_task_path($task_list[$task_i]['task_id']);
                $this->m_dev_task_list[$task_i]['task_data_path']   = $this->get_task_path($task_list[$task_i]['task_d_id']);
                $this->m_dev_task_list[$task_i]['time']             = $task_list[$task_i]['time'];
                $this->m_dev_task_list[$task_i]['task_time']        = $task_list[$task_i]['task_time'];
            }
            cache_write($this->pre_fix_dev_id . "dev_task_list", $this->m_dev_task_list); //写入任务列表
            $this->m_dev_info['task_index'] = 0;
            cache_write($this->pre_fix_dev_id . "dev_info", $this->m_dev_info);
            if($this->dev_msg['ms_id'] == '841288W1DZZ')
            {
                log_info("task list:");
                print_2_array($task_list); 
            }            
        }
        else{  //已分配过任务，存在任务列表            
            
            $task_list = $this->m_dev_task_list;
            $tmp_task_count = count($task_list); //任务的个数
            if(empty($this->m_dev_info['task_index']))  $this->m_dev_info['task_index'] = 0;
            if( $this->m_dev_info['task_index'] + 1 >= $tmp_task_count ){        //如果已经是运行到最后一个任务
                cache_delete($this->pre_fix_dev_id . 'dev_task_list'); //清除任务列表
                $this->m_dev_task_list = null;
                return $this->allot();
            }
            
            $current_time = $this->time; //可以换成 $this->time
            for ($tmp_task_index = 0; $tmp_task_index < $tmp_task_count; $tmp_task_index++) {
                if ($current_time > $task_list[$tmp_task_index]['time']) {}
                else
                {
                    break;
                }
            }

            if($tmp_task_index > 0){
                $tmp_task_index  = $tmp_task_index - 1; 
            }
            //任务已经执行过了
            //if  current_task_index  ==  "任务index"  then  返回   idle任务给终端   end
            if( $tmp_task_index == $this->m_dev_info['task_index']){
               $data=array(
                            'task_id'=>intval($this->m_user_info['idle_task_id']),
                            'task_path'=>$this->m_user_info['idle_task'],
                            'task_data_id'=>'',
                            'task_data_path'=>'',
                            'strategy_id'=>'',
                            'user_config_path'=>'',
                            );
                return $data;
            }
            //if  current_task_index + 1 ==  "任务index"  then    //这种是正常状态
            else{
                $run_task_index = $tmp_task_index;//下一个执行的任务
                //更新正在执行的任务               
                //pdo_update("ms_allot_table", array('ms_task_index'=>$run_task_index), array("ms_id"=>$ms_id) );
                //if  current_task_index + 1 ==  "任务index"  then    //这种是正常状态
                $this->m_dev_info['task_index'] = $run_task_index;
                cache_write($this->pre_fix_dev_id . "dev_info", $this->m_dev_info); //刷新计数器
                if( ($this->m_dev_info['task_index']+1) != $run_task_index){
                    //错误处理
                }              
            }
        }
        //$tmp_list    = array($task_list[$run_task_index]); //防止错误：Fatal error:  Cannot use string offset as an array
        //if( empty($TaskPath) ) //如果找不到 要执行的任务
        if( empty($this->m_dev_task_list[$run_task_index]['task_path']) )
        {
             $this->error_num++;
             if( $this->error_num >= 3)
             {
                $this->error_num = 0;
                $this->send_error_info(105,"没有此任务，或被删除"); 
             }
             cache_delete($this->pre_fix_dev_id . 'dev_task_list'); //清除任务列表
             $this->m_dev_task_list = null;
             return $this->allot();
        } 

        $data=array(
            'task_id'           =>intval($this->m_dev_task_list[$run_task_index]['task_id']),
            'task_path'         =>$this->m_dev_task_list[$run_task_index]['task_path'],
            'task_data_id'      =>intval($this->m_dev_task_list[$run_task_index]['task_data_id']),
            'task_data_path'    =>$this->m_dev_task_list[$run_task_index]['task_data_path'],
            'strategy_id'       =>intval($this->m_user_info['strategy_id']),
            'user_config_path'  =>$this->m_user_info['user_config_path'],  //kobe新加一条，用户的配置数据地址
        );
        //log_info("---------------".$this->user_id);
        //log_info($this->m_user_info['user_config_path']);
        return $data;
    }




    //刷新alive设备表--
    function update_alive(){ 
        $alive_date = array(); 
        $ms_id=pdo_fetchcolumn ("SELECT ms_id FROM " .tablename('ms_alive_table') . " WHERE ms_id='".$this->dev_msg['ms_id']."'");
        $alive_data['account']   =$this->dev_msg['ms_act'];
        $alive_data['user_id']  =$this->m_dev_info['user_id'];        
        $alive_data['ms_id']    =$this->dev_msg['ms_id'];
        $alive_data['ms_type']  =$this->dev_msg['ms_type']; 
        if(empty($ms_id)){//新增
            //alive终端表 ms_alive_table
            pdo_insert ( "ms_alive_table",  $alive_data);
        }else{//更新
            log_info("tttt1erer1212");
            pdo_update("ms_alive_table", 
                array('ms_type'=>$alive_data['ms_type'],'user_id'=>$alive_data['user_id'], 'account'=>$alive_data['account'] ),
                array("ms_id"=>$alive_data['ms_id'])              
                );
        }
    }

    //重置设备的任务列表--
    function reset_task_list($stratefy_task_list, $strategy){ //重新设置任务列表
        
        $stratefy_task_list = my_sort($stratefy_task_list, 'task_pri' );//按优先级排序；
        log_info("reset_task_list");
        print_2_array($stratefy_task_list);

        $task_list = array();
        foreach ($stratefy_task_list as $key => $value) {//根据任务列表次数重新组合数组
            if ($value['task_num'] >=1 ){
                for ($i=1; $i <= $value['task_num']; $i++) {
                    $task_list[]=$value;
                }
            }
        }

        //log_info("reset_task_list2222:");
        //print_2_array($task_list);

        if (1 == $strategy['is_ramd']){      
           log_info("++++do ramd_task+++++");
            $task_list = $this->ramd_task($task_list); //做随机化 
        }

        log_info("reset_task_list3333:");
        print_2_array($task_list);

        $task_list = $this->settime($task_list, $strategy['full_time']); //设置运行时间  
        log_info("++++do settime++++");
        log_info($strategy['full_time']);
        log_info("reset_task_list444:");
        print_2_array($task_list);   
        return $task_list;
    }

    //通过帐号查找对应的策略
    function get_strategy($account){  
        $strategy = pdo_fetch('SELECT b.* FROM ' . tablename('mc_members') . " a
                LEFT JOIN " . tablename('ms_strategy') . " b on a.strategy_id=b.id 
                where a.realname='".$account."'");//根据用户账号找出对应策略
        return $strategy;
    }

    
    //得到策略任务清单
    function get_strategy_task_list($strategy_id){ //得到策略对应的任务表
        $task_list = pdo_fetchall('SELECT * FROM ' . tablename('ms_strategy_task_list') . " 
                where strategy_id='".$strategy_id."'");//策略id找出对应任务列表
        return $task_list;
    }

    
    //得到任务的路径
    function get_task_path($id){
        if(!empty($id) && ($id != 0) ){ //当没有设置任务数据的时候 task_d_id 为0
            $file_path = pdo_fetchcolumn ("SELECT path FROM " .tablename('xsy_resource_file') . " WHERE id=".$id);
        }
        else
        {
            return;
        }
        if (!empty($file_path))
        {
            return $file_path;
        }
        else
        {
            log_info("not get task: " . $id);
            log_info($this->device_id);
            return;
        }
    }


    //随机同一个优先级的任务
    function ramd_task($task_list){
        $task_num = count($task_list);
        $task_pri = 121212;
        $task_pri_num_array = array();
        $task_out_array = array();
        for ($i=0; $i < $task_num; $i++) {
            if($task_pri != $task_list[$i]['task_pri']){
                $task_pri = $task_list[$i]['task_pri'];
                $task_pri_num_array[] = $i;
            };            
        }
        $task_pri_num_array[] = $task_num;   //最后的一个

        for($i = 0; $i < (count($task_pri_num_array) - 1); $i++){
            $tmp_num = $task_pri_num_array[$i+1] -  $task_pri_num_array[$i];
           
            $tmp_wash_card_array = array();
            log_info("wash_card:  $tmp_num");
            $tmp_wash_card_array = my_wash_card($tmp_num);

            for ($m=0; $m < $tmp_num ; $m++) { 
                $task_out_array[] = $task_list[ $task_pri_num_array[$i] + $tmp_wash_card_array[$m] ];
            }
        }
         return $task_out_array;
    }
 
    //给每一个任务设置运行的起始时间
    function settime($list,$full_time){ 
        $num = 0;
        foreach($list as $k => $v) {
            $num += $v['task_time']; //task_time 为每个任务运行的时间
        }

        //$full_time = $full_time - $num;
        if($full_time>$num)
        {
            $full_time = $full_time - $num;
        }
        else
        {
            $full_time = 0;
        }

        $count=count($list);

        $rand_time = my_randnum($full_time, $count);
        $rand_time[0] = 0; //设置第一个的间隔为0
        $tmp_time = $this->time;
        for ($i=0; $i < $count ; $i++) { 
            $list[$i]['time'] =  $tmp_time;
            if( $rand_time[$i] >=0 ){ //要做个判断，可能会小于0
                $tmp_time = $tmp_time +  $list[$i]['task_time'] +  $rand_time[$i];
            }
            else{
                $tmp_time = $tmp_time +  $list[$i]['task_time'];
            }
        }
        return $list;
    }
}

//------------------------------------------------------------------------------------
$get=$_GET;
$GETTASK = new GETTASK();
$GETTASK->task($get);