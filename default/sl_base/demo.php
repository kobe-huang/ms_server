<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title></title>
</head>
<body>

<?php
/**
 * @Author: 特筹网
 * @Date:   2017-03-03 16:51:54
 * @Last Modified by:   gangan
 * @Last Modified time: 2017-03-06 11:55:55
 */

/**
 * @desc 获取快递信息 
 * @param string $code 快递编码
 * @param string $invoice 快递单号
 * @return mixed $result('status','info','state','data')
 */

$info = getExpressDelivery('yuantong','200402651111');


$body = file_get_contents("http://www.phpos.net/weiqing/wqhs/mysql_cache_write.html"); //FIXME




echo "<pre>";
print_r($body);
exit;



function getExpressDelivery($code,$invoice){
    $result = array('status'=>0,'info'=>'未知错误');
    $url = "http://m.kuaidi100.com/query?type={$code}&postid={$invoice}&id=1&valicode=&temp=".rand(1,710);
    $body = file_get_contents($url); //FIXME
    $body = json_decode($body,true);
    $result['status'] = $body['status'] == 200 ? 1 : 0;
    $result['info'] = $body['message'];
    isset($body['data']) && ($result['state']=$body['state']) && ($result['data'] = $body['data']) ;
    return $result;
}


