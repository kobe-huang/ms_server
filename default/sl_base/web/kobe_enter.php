<?php

define('IN_SYS', true);
require '../framework/bootstrap.inc.php';
load()->web('common');
load()->web('template');
header('Content-Type: text/html; charset=UTF-8');
$uniacid = intval($_GPC['i']);
$cookie = $_GPC['__uniacid'];

if (empty($uniacid) && empty($cookie)) {
	exit('Access Denied.');
}

error_log("----begin----");
session_start();

if (!empty($uniacid)) {
	$_SESSION['__xxxxx_uniacid'] = $uniacid;
	isetcookie('__uniacid', $uniacid, 7 * 86400);
}


$site = WeUtility::createModuleSite('xsy_resource');
if (!is_error($site)) {
	//error_log("create success");
	//$method = 'doWebkobe_login';
	$method = 'doWebWeb';
	$site->uniacid = $uniacid;
	$site->inMobile = false;

	if (method_exists($site, $method)) {
		//error_log("create step1");
		$site->$method();
		exit();
	}

}


?>