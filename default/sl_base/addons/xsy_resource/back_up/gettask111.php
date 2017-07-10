<?php
/**
 * @Author: 特筹网
 * @Date:   2017-01-12 14:41:04
 * @Last Modified by:   gangan
 * @Last Modified time: 2017-03-08 10:52:49
 */
header('Content-Type:text/html;charset=utf-8'); 


// ms_code  手机的UUID  ABCDEFG12345678
// ms_type  手机的型号  ip4， ip4s
// ms_act  帐号  kobe
// ms_pwd  密码  H11111111h
// ms_token  token   shunliantianxia12345
// ms_stg_id  现在执行的策略  40003
// ms_task_id  执行的脚本  50005
// ms_task_d_id  执行的脚本数据  50003
// ms_status执行状态：
        // "ideal" ： 空闲，在主程序中，无脚本执行
        // "running"： 在脚本执行中
        // "finished"：当前脚本执行完成
        

// Code返回码
//         101：成功，
//         102：失败，
//          103：欠费，
//          104：找不到相关数据

//  Message返回消息返回接口状态；可以自定义

//          TskId  任务编号  50005

//          TskPath  任务地址  http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg

//         TskDataID  任务数据编号  50003

//         TskDataPath  任务数据地址  http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg

//         StgID  策略编号  40003

// http://120.76.215.162/sl_base/addons/xsy_resource/gettask.php?task={\%22ms_act\%22:\%22member\%22,\%22ms_id\%22:\%22ganboling\%22,\%22ms_pwd\%22:\%2213800000000\%22,\%22ms_token\%22:\%22shunliantianxia12345\%22,\%22ms_type\%22:\%22ip4\%22}




require_once '../../framework/bootstrap.inc.php';
// require_once str_replace("\\", '/', dirname(dirname(dirname(__FILE__)))).'/framework/bootstrap.inc.php';


class GetTask {

    function check_web_status(){
        $_setting = pdo_fetch('SELECT * FROM '.tablename("ms_setting")." where 1");
        if($_setting['close']==1){//站点维护开启
            $code=105;
            $message='系统维护中';
            $output = array(
                'Code'=>$code ,
                'Message'=>$message
            );
            exit(json_encode($output));
        }
    }

    function task($get){
             global $_W;

             $this->check_web_status();



            if (!empty($get['task'])) {
                // 带参数
                $json = str_replace("\\", "", $get['task']);
                $data = json_decode($json,true);


                /**
                 * 验证token
                 */
                // if(!empty($data['ms_token'])){
                //     $token='shunliantianxia12345';
                //     if($data['ms_token']!==$token){
                //         $this->output(105);
                //     }
                // }
                /**
                 * 检查用户名密码
                 */
                if(!empty($data['ms_act']) && !empty($data['ms_pwd'])){

                    $user = pdo_fetch('SELECT * FROM ' . tablename('mc_members') . " where realname='".$data['ms_act']."'");

                    if(!empty($user)){
                        // 有此用户名
                        $salt=$user['salt'];
                        $password=$user['password'];
                        $ms_pwd=md5(trim($data['ms_pwd']) . $salt . $_W['config']['setting']['authkey']);
                        if($ms_pwd==$password){
                            // 密码正确

// http://120.76.215.162/sl_base/addons/xsy_resource/gettask.php?task={\"ms_act\":\"kobe\",\"ms_id\":\"WXKJ2QU9IPAD\",\"ms_pwd\":\"H11111111h\",\"ms_token\":\"shunliantianxia12345\",\"ms_type\":\"ip4\"}


// ID终端的ID，自增UUID手机的 UUID； 这个是一串码，例如： 12osdji12934182121212running_script_ID现在执行的任务IDtime上报时间，从系统得到Strategy_ID现在执行的策略IDcurrent_task_index当前运行阶段（同任务序号）task_list任务列表account帐号ms_type手机型号（4，4S，5，5C）


                            if (!empty($data['ms_id']) && !empty($data['ms_type']) && !empty($data['ms_act']) ) {

                                $alive_data=array(
                                    'ms_id'=>$data['ms_id'],                  //序号
                                    'account'=>$data['ms_act'],               //账号
                                    'ms_type'=>$data['ms_type'],              //型号
                                    'time'=>time(),
                                );




                            }

                            // if (!empty($data['ms_status'])) {
                            //     switch ($data['ms_status']) {
                            //         case 'ideal':
                            //             // echo 444;
                            //             break;
                            //         case 'running':
                            //             # code...
                            //             break;
                            //         case 'finished':
                            //             # code...
                            //             break;                                        
                            //         default:
                            //             # code...
                            //             break;
                            //     }
                            // }

                            $code=101;
                        }else{
                            // 密码错误
                            $code=106;
                        }
                    }else{
                        // 无此用户名
                        $code=107;
                    }


                }

                $this->output($code,$data['ms_id'],$alive_data);

            }else{
                // 无参数，失败
                $code=102;
                $this->output($code);
            }


                // echo "<pre>";
                // print_r(basename($_SERVER['PHP_SELF']));
                // exit;




    }






    function output($code=102,$ms_id,$alive_data){

        $output = array(
            'Code'=>$code ,
        );

                if($code==101){
                    $output['Message']='成功'; 

                    $AllotTask = new AllotTask();
                    $data=$AllotTask->allot($ms_id);
                    $output['data']=$data;

                        if(!empty($data['Strategy_ID']) && !empty($data['TaskId'])){

                            $ms_id=pdo_fetchcolumn ("SELECT ms_id FROM " .tablename('ms_alive_table') . " WHERE ms_id='".$alive_data['ms_id']."'");

                            if(empty($ms_id)){//新增
                                //alive终端表 ms_alive_table
                                $alive_data['Strategy_ID']=$data['Strategy_ID'];        //策略
                                $alive_data['running_script_ID']=$data['TaskId']; //执行的任务id
                                pdo_insert ( "ms_alive_table", $alive_data );
                            }else{//更新
                                pdo_update("ms_alive_table",array('Strategy_ID'=>$data['Strategy_ID'],'running_script_ID'=>$data['TaskId'],'time'=>$alive_data['time']),array("ms_id"=>$alive_data['ms_id']));
                            }




                        }




                }elseif($code==102){
                    $output['Message']='失败';
                }elseif($code==103){
                    $output['Message']='欠费';
                }elseif($code==104){
                    $output['Message']='空闲状况';
                }elseif($code==105){
                    $output['Message']='TOKEN错误';
                }elseif($code==106){
                    $output['Message']='密码错误';
                }elseif($code==107){
                    $output['Message']='用户名不存在';
                }




                // echo "<pre>";
                // print_r($output);
                // exit;
        exit(json_encode($output));
    }






}


class AllotTask {

    /**
     * 根据用户序号找出对应策略，根据策略分配任务
     * $ms_id   终端序号
     */ 
    function allot($ms_id){

        $strategy=$this->get_strategy($ms_id);//策略

        $allot = pdo_fetch('SELECT * FROM ' . tablename('ms_allot_table') . " where ms_id='".$ms_id."'");//任务列表





        if (empty($allot) && !empty($strategy)) {//未分配过任务


            
            $task_list=$this->get_task_list($strategy['id']);

            foreach ($task_list as $key => $value) {//根据任务列表次数重新组合数组
                if($value['tesk_num']>1){
                    for ($i=2; $i <= $value['tesk_num']; $i++) {
                        $task_list[]=$value;
                    }
                }
            }



            /**
             *  $arr->数组   $sort->排序顺序标志   $value->排序字段  $is_ramd->根据tesk_sort是否随机
             *     排序顺序标志 SORT_DESC 降序；SORT_ASC 升序 ,
             */
            $task_list=$this->settime($task_list,$strategy['full_time']);
            $task_list=$this->sort($task_list,0,'tesk_sort',$strategy['is_ramd']);


            // echo "<pre>";
            // print_r($task_list);
            // exit;
            $next_task=$task_list[0];

            $task_list=json_encode($task_list);







            $task_data=array(
                'ms_id'=>$ms_id,//序列号
                'task'=>$task_list,//执行的任务列表
                'ms_task_id'=>0,//当前执行任务id,数组的键名
                'time'=>time(),
            );


            pdo_insert ( "ms_allot_table", $task_data );



        }elseif (!empty($allot) && !empty($strategy)){//已分配过任务
            


            $task=json_decode($allot['task'],true);//已分配任务列表
            $ms_task_id=$allot['ms_task_id'];//当前执行的任务索引



            $run_time=$allot['time']+$task[$ms_task_id]['tesk_time'];//运行时间
            $ideal_time=$run_time+$task[$ms_task_id]['rand_time'];//空闲时间

            if( $ideal_time > time() && time() > $run_time){//判断是否在空闲时间内，分配空闲任务
                
                $ideal_path= pdo_fetch("SELECT id,path FROM " .tablename('xsy_resource_file') . " WHERE info='空闲任务'");

                $data=array(
                    'TaskId'=>intval($ideal_path['id']),
                    'TaskPath'=>$ideal_path['path'],
                    'TaskDataID'=>'',
                    'TaskDataPath'=>'',
                    'Strategy_ID'=>'',
                );

                return $data;
                
            }elseif($allot['time']<time() && time()<$run_time){
                $data=array(
                    'message'=>"任务正在运行",
                    'TaskId'=>'',
                    'TaskPath'=>'',
                    'TaskDataID'=>'',
                    'TaskDataPath'=>'',
                    'Strategy_ID'=>'',
                );

                return $data;
            }

            $next_ms_task_id=$ms_task_id+1;//下一个执行任务的索引

            if (array_key_exists($next_ms_task_id,$task)){//判断是否有下一个任务
                //存在
                $next_task=$task[$next_ms_task_id];//下一个执行的任务

                pdo_update("ms_allot_table",array('ms_task_id'=>$next_ms_task_id,'time'=>time()),array("ms_id"=>$ms_id));//更新正在执行的任务
            }else{
                //不存在，重新分配任务
                
                pdo_delete("ms_allot_table",array("ms_id"=>$ms_id));

                return $this->allot($ms_id);
                exit;
                //已分配任务列表
                // $task=$this->settime($task,$strategy['full_time']);//重新设置时间
                // $task=$this->sort($task,0,'tesk_sort',$strategy['is_ramd']);//重新排序

                // $task_list=json_encode($task);
                // $next_ms_task_id=0;
                // $next_task=$task[0];
                // pdo_update("ms_allot_table",array('task'=>$task_list,'ms_task_id'=>$next_ms_task_id,'time'=>time()),array("ms_id"=>$ms_id));//更新任务
            }






        }elseif (empty($allot) && empty($strategy)){
                $data=array(
                    'message'=>"序列号有误",
                    'TaskId'=>'',
                    'TaskPath'=>'',
                    'TaskDataID'=>'',
                    'TaskDataPath'=>'',
                    'Strategy_ID'=>'',
                );

                return $data;
        }





        //返回当前任务
        $TaskId=$next_task['task_id'];
        $TaskPath=$this->get_task_path($TaskId);
        $TaskDataID=$next_task['task_d_id'];
        $TaskDataPath=$this->get_task_path($TaskDataID);
        $Strategy_ID=$next_task['strategy_ID'];
        $data=array(
            'TaskId'=>intval($TaskId),
            'TaskPath'=>$TaskPath,
            'TaskDataID'=>intval($TaskDataID),
            'TaskDataPath'=>$TaskDataPath,
            'Strategy_ID'=>intval($Strategy_ID),
        );

        return $data;

    }




    function get_strategy($ms_id){
        
        $strategy = pdo_fetch('SELECT b.* FROM ' . tablename('mc_members') . " a
                LEFT JOIN " . tablename('ms_strategy') . " b on a.strategy_ID=b.id 
                where a.ms_code='".$ms_id."'");//根据用户序号找出对应策略

        return $strategy;
    }
    function get_task_list($strategy_ID){
        
        $task_list = pdo_fetchall('SELECT * FROM ' . tablename('ms_task_list') . " 
                where strategy_ID='".$strategy_ID."'");//策略id找出对应任务列表

        return $task_list;
    }

    function get_task_path($id){
        if(!empty($id)){
        $file_path = pdo_fetchcolumn ("SELECT path FROM " .tablename('xsy_resource_file') . " WHERE id=".$id);
        }
        return $file_path;
    }




    function sort($arr,$sort,$v,$is_ramd){
    //$arr->数组   $sort->排序顺序标志   $value->排序字段
     //排序顺序标志 SORT_DESC 降序；SORT_ASC 升序  
        if($sort == "0"){                   
                $sort = "SORT_ASC";
        }elseif ($sort == "1") {
                $sort = "SORT_DESC";
        }

        foreach($arr as $uniqid => $row){
            foreach($row as $key=>$value){
                    $arrsort[$key][$uniqid] = $value;
                }
            }
        if($sort){
            array_multisort($arrsort[$v], constant($sort), $arr);  
        }
        

        if($is_ramd==1){//如果策略为随机
            $array=$this->_rand($arr);//根据优先级排序
        }


         return $array;
    }
    function _rand($task_list){

        // foreach ($task_list as $key => $value) {
        //     unset($task_list[$key]['id']);
        //     unset($task_list[$key]['tesk_num']);
        //     unset($task_list[$key]['task_d_id']);
        //     unset($task_list[$key]['task_d_id']);
        //     unset($task_list[$key]['tesk_time']);
        //     unset($task_list[$key]['strategy_ID']);
        // }
        foreach ($task_list as $key => $value) {//以排序归为key成新的二维数组
            $rand[$value['tesk_sort']][]=$value;
            shuffle($rand[$value['tesk_sort']]);
        }

        foreach ($rand as $key => $value) {
            foreach ($value as $k => $v) {
                $new_rand[]=$v;
            }

        }

        return $new_rand;
    }

    function settime($list,$full_time){ 

        $num = 0;
        foreach($list as $k => $v) {
            $num += $v['tesk_time'];
        }
        $full_time=$full_time-$num;
 
        $count=count($list);
        $rand_time=$this->randnumber($full_time,$count);

        foreach ($list as $key => $value) {
            $list[$key]['rand_time']=$rand_time[$key];
        }
        unset($rand_time);
        return $list;
    }

// 获取一定范围内的多个随机数字
function randnumber($total, $div){ //$total 总数, $div 份数
    $remain=$total;
    $max_sum=($div-1)*$div/2;
    $p=$div; $min=0;
    $a=array();
    for($i=0; $i<$div-1; $i++){
        $max=($remain-$max_sum)/($div-$i);
        $e=rand($min,$max);    
        $min=$e+1; $max_sum-=--$p;
        $remain-=$e;
        $a[$e]=true;
    }
    $a=array_keys($a);
    $a[]=$remain;

    return $a;
}




}









$get=$_GET;
$GetTask = new GetTask();
$response=$GetTask->task($get);

echo $response;
