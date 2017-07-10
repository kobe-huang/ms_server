<?php

header('Content-Type:text/html;charset=utf-8'); 
require_once '../../../framework/bootstrap.inc.php';
//default_server_addr = "http://120.76.215.162/sl_base/addons/xsy_resource/test/test_memche.php?task="
$get=$_GET;
$s_p = ini_get('session.save_path');
$s_p = ini_get('session.gc_maxlifetime');
error_log("session_save_path = ");
error_log($s_p);