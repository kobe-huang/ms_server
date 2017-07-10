<?php

//
if (! defined ( 'IN_IA' )) {
    exit ( 'Access Denied' );
}
define ( 'XSY_RESOURCE_DEBUG', false );
! defined ( 'XSY_RESOURCE_PATH' ) && define ( 'XSY_RESOURCE_PATH', IA_ROOT . '/addons/xsy_resource/' );
! defined ( 'XSY_RESOURCE_INC' ) && define ( 'XSY_RESOURCE_INC', XSY_RESOURCE_PATH . 'inc/' );
! defined ( 'XSY_RESOURCE_CORE' ) && define ( 'XSY_RESOURCE_CORE', XSY_RESOURCE_INC . 'core/' );
! defined ( 'XSY_RESOURCE_URL' ) && define ( 'XSY_RESOURCE_URL', $_W ['siteroot'] . 'addons/xsy_resource/' );
! defined ( 'XSY_RESOURCE_STATIC' ) && define ( 'XSY_RESOURCE_STATIC', XSY_RESOURCE_URL . 'template/static/' );
! defined ( 'XSY_RESOURCE_PREFIX' ) && define ( 'XSY_RESOURCE_PREFIX', 'XSY_RESOURCE_' );
! defined ( 'XSY_RESOURCE_ATTACHMENT' ) && define ( 'XSY_RESOURCE_ATTACHMENT', 'addons/xsy_resource/attachment' );

!defined('GARCIA_OSS') && define('GARCIA_OSS', XSY_RESOURCE_PATH.'oss/');//oss
