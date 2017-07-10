<?php
/**
 * 入口文件
 * @author QQ:3419335695
 */
defined ( 'IN_IA' ) or exit ( 'Access Denied' );
require IA_ROOT . '/addons/xsy_resource/defines.php';
//require IA_ROOT . '/addons/xsy_resource/kobe_inc/user_site.php';
class Xsy_resourceModuleSite extends WeModuleSite {
	
	/**
	 * 资源管理
	 */
	
	public function doWebkobe_login() {
		error_log("doWebkobe_login");
	}
	
	
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

					pdo_delete ( "xs