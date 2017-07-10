<?php
/**
 * @Author: 特筹网
 * @Date:   2017-01-12 14:41:04
 * @Last Modified by:   gangan
 * @Last Modified time: 2017-03-10 15:26:41
 */
header('Content-Type:text/html;charset=utf-8'); 

require_once '../../framework/bootstrap.inc.php';

class GETTASK {
    function task($get){

        $this->check_web_status();
        $alive_data=$this->check_user($get);
        $data=$this->allot($alive_data['account'],$alive_data['ms_id']);

        $this->update_alive($data,$alive_data);




//echo "<pre>";
//print_r($data);
//exit;
        $code=101;
        $message='成功';
        return $this->output($code,$message,$data);
    }

    function output($code,$message,$data){
            $output = array(
                'Code'=>$code ,
                'Message'=>$message
            );
            if($data){
                $output['data']=$data;
            }
// echo "<pre>";
// print_r($output);
// exit;

        exit(json_encode($output));
    }


    function check_web_status(){
        $_setting = pdo_fetch('SELECT * FROM '.tablename("ms_setting")." where 1");
        if($_setting['close']==1){//站点维护开启
            $code=105;
            $message='系统维护中';
            exit(json_encode($this->output($code,$message)));
        }
    }
    function check_user($get){
        global $_W;
        if (!empty($get['task'])) {
            $json = str_replace("\\", "", $get['task']);
            $data = json_decode($json,true);
        
            if(!empty($data['ms_act']) && !empty($data['ms_pwd'])){
                $user = pdo_fetch('SELECT * FROM ' . tablename('mc_members') . " where realname='".$data['ms_act']."'");
                if(!empty($user)){
                    // 有此用户名
                    $salt=$user['salt'];
                    $password=$user['password'];
                    $ms_pwd=md5(trim($data['ms_pwd']) . $salt . $_W['config']['setting']['authkey']);
                    if($ms_pwd==$password){
                        // 密码正确  
                        if (!empty($data['ms_id']) && !empty($data['ms_type']) && !empty($data['ms_act']) ) {

                                $alive_data=array(
                                    'ms_id'=>$data['ms_id'],                  //序号
                                    'account'=>$data['ms_act'],               //账号
                                    'ms_type'=>$data['ms_type'],              //型号
                                    'time'=>time(),
                                );

                                return $alive_data;
                        }
                    }else{
                        $code=106;
                        $message='密码错误';            
                    }
                                              
                }else{
                    $code=107;
                    $message='用户名不存在';            
                }



            }else{
                $code=102;
                $message='失败';            
            }
        }else{
            $code=102;
            $message='失败';            
        }

            exit(json_encode($this->output($code,$message)));
    }



    /**
     * 根据用户序号找出对应策略，根据策略分配任务
     * $ms_id   终端序号
     */ 
    function allot($account,$ms_id){
        global $_W;



        $strategy=$this->get_strategy($account);//策略

//         $allot=cache_load($ms_id);

// echo "<pre>";
// print_r($allot);
// exit;

//         if(empty($allot)){
            $allot = pdo_fetch('SELECT * FROM ' . tablename('ms_allot_table') . " where ms_id='".$ms_id."'");//任务列表            
        // }




        if (empty($allot) && empty($strategy)){
                $data=array(
                    'message'=>"序列号有误",
                    'TaskId'=>'',
                    'TaskPath'=>'',
                    'TaskDataID'=>'',
                    'TaskDataPath'=>'',
                    'Strategy_ID'=>'',
                );

                return $data;
        }elseif (empty($allot) && !empty($strategy)) {//未分配过任务


            $task_list=$this->get_task_list($strategy['id']);
            $task_list=$this->reset_task_list($task_list,$strategy);
            $next_task=$task_list[0];
            $task_list=json_encode($task_list);


            $task_data=array(
                'ms_id'=>$ms_id,//序列号
                'task'=>$task_list,//执行的任务列表
                'ms_task_id'=>0,//当前执行任务id,数组的键名
                'time'=>time(),
            );



            // $result=cache_write($ms_id, $task_data);

            pdo_insert ( "ms_allot_table", $task_data );



        }elseif (!empty($allot) && !empty($strategy)){//已分配过任务
            


            $task=json_decode($allot['task'],true);//已分配任务列表
            $ms_task_id=$allot['ms_task_id'];//当前执行的任务索引

            $run_time=$allot['time']+$task[$ms_task_id]['tesk_time'];//运行时间
            $idle_time=$run_time+$task[$ms_task_id]['rand_time'];//空闲时间

            if( $idle_time > time() && time() > $run_time){//判断是否在空闲时间内，分配空闲任务
                
                $idle_path= pdo_fetch("SELECT id,path FROM " .tablename('xsy_resource_file') . " WHERE id=".$strategy['idle']);

                $data=array(
                    'TaskId'=>intval($idle_path['id']),
                    'TaskPath'=>$idle_path['path'],
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

    function update_alive($data,$alive_data){
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
    }

    function reset_task_list($task_list,$strategy){
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

        return $task_list;
    }

    function get_strategy($account){
        
        $strategy = pdo_fetch('SELECT b.* FROM ' . tablename('mc_members') . " a
                LEFT JOIN " . tablename('ms_strategy') . " b on a.strategy_ID=b.id 
                where a.realname='".$account."'");//根据用户账号找出对应策略

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
            $list[$key]['rand_time']=$rand_time[$key+1];
        }


        unset($rand_time);
        return $list;
    }

// 获取一定范围内的多个随机数字
function randnumber($total, $div){ //$total 总数, $div 份数

$area = 5; //各份数间允许的最大差值
 
$average = round($total / $div);
$sum = 0;
$result = array_fill( 1, $div, 0 );
 
for( $i = 1; $i < $div; $i++ ){
 //根据已产生的随机数情况，调整新随机数范围，以保证各份间差值在指定范围内
 if( $sum > 0 ){
  $max = 0;
  $min = 0 - round( $area / 2 );
 }elseif( $sum < 0 ){
  $min = 0;
  $max = round( $area / 2 );
 }else{
  $max = round( $area / 2 );
  $min = 0 - round( $area / 2 );
 }
 
 //产生各份的份额
 $random = rand( $min, $max );
 $sum += $random;
 $result[$i] = $average + $random;
}
 
//最后一份的份额由前面的结果决定，以保证各份的总和为指定值
$result[$div] = $average - $sum;
 

    return $result;
}







}










$get=$_GET;
$GETTASK = new GETTASK();
$GETTASK->task($get);

