<?php
/**
 * @Author: 特筹网
 * @Date:   2017-01-12 14:41:04
 * @Last Modified by:   gangan
 * @Last Modified time: 2017-01-18 14:30:33
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


// 120.76.215.162/we7_base/addons/xsy_resource/GetTask/gettask.php?




require_once '../../framework/bootstrap.inc.php';
// require_once str_replace("\\", '/', dirname(dirname(dirname(__FILE__)))).'/framework/bootstrap.inc.php';


class GetTask {


    function task($get){
             global $_W;

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

// http://120.76.215.162/sl_base/addons/xsy_resource/gettask.php?task={\"ms_act\":\"kobe\",\"ms_id\":\"3\",\"ms_pwd\":\"H11111111h\",\"ms_status\":\"ideal\",\"ms_stg_id\":40004,\"ms_task_d_id\":50003,\"ms_task_id\":50005,\"ms_token\":\"shunliantianxia12345\",\"ms_type\":\"ip4\"}


// ID终端的ID，自增UUID手机的 UUID； 这个是一串码，例如： 12osdji12934182121212running_script_ID现在执行的任务IDtime上报时间，从系统得到Strategy_ID现在执行的策略IDcurrent_task_index当前运行阶段（同任务序号）task_list任务列表account帐号ms_type手机型号（4，4S，5，5C）


                            if (!empty($data['ms_id']) && !empty($data['ms_type']) && !empty($data['ms_act']) && !empty($data['ms_stg_id']) ) {
                                $alive_data=array(
                                    'ms_id'=>$data['ms_id'],//序号
                                    'Strategy_ID'=>$data['ms_stg_id'],//策略
                                    'running_script_ID'=>$data['ms_task_id'],//执行的任务id
                                    'account'=>$data['ms_act'],//账号
                                    'task_list'=>5,//$data['task_list'],//任务列表id
                                    'ms_type'=>$data['ms_type'],//型号
                                    'time'=>time(),
                                );




                //                                 echo "<pre>";
                // print_r($alive_data);
                // exit;
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


            }else{
                // 无参数，失败
                $code=102;
            }


                // echo "<pre>";
                // print_r(basename($_SERVER['PHP_SELF']));
                // exit;

            $this->output($code);


    }

    function output($code=102){

        $output = array(
            'Code'=>$code ,
        );

                if($code==101){
                    $output['Message']='成功'; 
                    $output['data']=array(
                        // 'TaskId'=>$TaskId,
                        // 'TaskPath'=>$TaskPath,
                        // 'TaskDataID'=>$TaskDataID,
                        // 'TaskDataPath'=>$TaskDataPath,
                        // 'Strategy_ID'=>$Strategy_ID,
                        'TaskId'=>50005,
                        'TaskPath'=>'http://oss.temaiol.com/file/1/20170118/f9fc7f93f08c9f8b2dba8d7312b058bb.lua',
                        'TaskDataID'=>50003,
                        'TaskDataPath'=>'http://oss.temaiol.com/file/1/20170118/344d895908d5bf7cfa65c622f6d85bcc.lua',
                        'Strategy_ID'=>40003,
                    );





   
                }elseif($code==102){
                    $output['Message']='失败';
                }elseif($code==103){
                    $output['Message']='欠费';
                }elseif($code==104){
                    $output['Message']='找不到相关数据';
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
$get=$_GET;
$GetTask = new GetTask();
$response=$GetTask->task($get);

echo $response;
