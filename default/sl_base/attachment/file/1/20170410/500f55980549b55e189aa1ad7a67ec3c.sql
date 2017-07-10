-- phpMyAdmin SQL Dump
-- version 4.4.15.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2017-04-10 09:52:37
-- 服务器版本： 5.6.31-log
-- PHP Version: 5.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `we7_base`
--

-- --------------------------------------------------------

--
-- 表的结构 `sltx_account`
--

CREATE TABLE IF NOT EXISTS `sltx_account` (
  `acid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `hash` varchar(8) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `isconnect` tinyint(4) NOT NULL,
  `isdeleted` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_account`
--

INSERT INTO `sltx_account` (`acid`, `uniacid`, `hash`, `type`, `isconnect`, `isdeleted`) VALUES
(1, 1, 'uRr8qvQV', 1, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_account_wechats`
--

CREATE TABLE IF NOT EXISTS `sltx_account_wechats` (
  `acid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `token` varchar(32) NOT NULL,
  `access_token` varchar(1000) NOT NULL,
  `encodingaeskey` varchar(255) NOT NULL,
  `level` tinyint(4) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `account` varchar(30) NOT NULL,
  `original` varchar(50) NOT NULL,
  `signature` varchar(100) NOT NULL,
  `country` varchar(10) NOT NULL,
  `province` varchar(3) NOT NULL,
  `city` varchar(15) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `lastupdate` int(10) unsigned NOT NULL,
  `key` varchar(50) NOT NULL,
  `secret` varchar(50) NOT NULL,
  `styleid` int(10) unsigned NOT NULL,
  `subscribeurl` varchar(120) NOT NULL,
  `auth_refresh_token` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_account_wechats`
--

INSERT INTO `sltx_account_wechats` (`acid`, `uniacid`, `token`, `access_token`, `encodingaeskey`, `level`, `name`, `account`, `original`, `signature`, `country`, `province`, `city`, `username`, `password`, `lastupdate`, `key`, `secret`, `styleid`, `subscribeurl`, `auth_refresh_token`) VALUES
(1, 1, 'omJNpZEhZeHj1ZxFECKkP48B5VFbk1HP', '', '', 1, '顺联控制台', '', '', '', '', '', '', 'admin', 'd89f2543875844ad65a8c06ff26d616a', 0, '', '', 1, '', '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_clerks`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_clerks` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `storeid` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `openid` varchar(50) NOT NULL,
  `nickname` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_clerk_menu`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_clerk_menu` (
  `id` int(11) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `displayorder` int(4) NOT NULL,
  `pid` int(6) NOT NULL,
  `group_name` varchar(20) NOT NULL,
  `title` varchar(20) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `url` varchar(60) NOT NULL,
  `type` varchar(20) NOT NULL,
  `permission` varchar(50) NOT NULL,
  `system` int(2) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_activity_clerk_menu`
--

INSERT INTO `sltx_activity_clerk_menu` (`id`, `uniacid`, `displayorder`, `pid`, `group_name`, `title`, `icon`, `url`, `type`, `permission`, `system`) VALUES
(1, 0, 0, 0, 'mc', '快捷交易', '', '', '', 'mc_manage', 1),
(2, 0, 0, 1, '', '积分充值', 'fa fa-money', 'credit1', 'modal', 'mc_credit1', 1),
(3, 0, 0, 1, '', '余额充值', 'fa fa-cny', 'credit2', 'modal', 'mc_credit2', 1),
(4, 0, 0, 1, '', '消费', 'fa fa-usd', 'consume', 'modal', 'mc_consume', 1),
(5, 0, 0, 1, '', '发放会员卡', 'fa fa-credit-card', 'card', 'modal', 'mc_card', 1),
(6, 0, 0, 0, 'stat', '数据统计', '', '', '', 'stat_manage', 1),
(7, 0, 0, 6, '', '积分统计', 'fa fa-bar-chart', './index.php?c=stat&a=credit1', 'url', 'stat_credit1', 1),
(8, 0, 0, 6, '', '余额统计', 'fa fa-bar-chart', './index.php?c=stat&a=credit2', 'url', 'stat_credit2', 1),
(9, 0, 0, 6, '', '现金消费统计', 'fa fa-bar-chart', './index.php?c=stat&a=cash', 'url', 'stat_cash', 1),
(10, 0, 0, 6, '', '会员卡统计', 'fa fa-bar-chart', './index.php?c=stat&a=card', 'url', 'stat_card', 1),
(11, 0, 0, 0, 'activity', '系统优惠券核销', '', '', '', 'activity_card_manage', 1),
(12, 0, 0, 11, '', '折扣券核销', 'fa fa-money', './index.php?c=activity&a=consume&do=display&type=1', 'url', 'activity_consume_coupon', 1),
(13, 0, 0, 11, '', '代金券核销', 'fa fa-money', './index.php?c=activity&a=consume&do=display&type=2', 'url', 'activity_consume_token', 1),
(14, 0, 0, 0, 'wechat', '微信卡券核销', '', '', '', 'wechat_card_manage', 1),
(15, 0, 0, 14, '', '卡券核销', 'fa fa-money', './index.php?c=wechat&a=consume', 'url', 'wechat_consume', 1),
(16, 0, 0, 6, '', '收银台收款统计', 'fa fa-bar-chart', './index.php?c=stat&a=paycenter', 'url', 'stat_paycenter', 1);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_coupon_allocation`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_coupon_allocation` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `couponid` int(10) unsigned NOT NULL,
  `groupid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_coupon_modules`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_coupon_modules` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `couponid` int(10) unsigned NOT NULL,
  `module` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_exchange`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_exchange` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `thumb` varchar(500) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL,
  `extra` varchar(3000) NOT NULL,
  `credit` int(10) unsigned NOT NULL,
  `credittype` varchar(10) NOT NULL,
  `pretotal` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `total` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `starttime` int(10) unsigned NOT NULL,
  `endtime` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_exchange_trades`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_exchange_trades` (
  `tid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `exid` int(10) unsigned NOT NULL,
  `type` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_exchange_trades_shipping`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_exchange_trades_shipping` (
  `tid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `exid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `status` tinyint(4) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `province` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `district` varchar(30) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zipcode` varchar(6) NOT NULL,
  `mobile` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_modules`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_modules` (
  `mid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `exid` int(10) unsigned NOT NULL,
  `module` varchar(50) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `available` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_modules_record`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_modules_record` (
  `id` int(10) unsigned NOT NULL,
  `mid` int(10) unsigned NOT NULL,
  `num` tinyint(3) NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_activity_stores`
--

CREATE TABLE IF NOT EXISTS `sltx_activity_stores` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `branch_name` varchar(50) NOT NULL,
  `category` varchar(255) NOT NULL,
  `province` varchar(15) NOT NULL,
  `city` varchar(15) NOT NULL,
  `district` varchar(15) NOT NULL,
  `address` varchar(50) NOT NULL,
  `longitude` varchar(15) NOT NULL,
  `latitude` varchar(15) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `photo_list` varchar(10000) NOT NULL,
  `avg_price` int(10) unsigned NOT NULL,
  `recommend` varchar(255) NOT NULL,
  `special` varchar(255) NOT NULL,
  `introduction` varchar(255) NOT NULL,
  `open_time` varchar(50) NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `source` tinyint(3) unsigned NOT NULL,
  `message` varchar(500) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_article_category`
--

CREATE TABLE IF NOT EXISTS `sltx_article_category` (
  `id` int(10) unsigned NOT NULL,
  `title` varchar(30) NOT NULL,
  `displayorder` tinyint(3) unsigned NOT NULL,
  `type` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_article_news`
--

CREATE TABLE IF NOT EXISTS `sltx_article_news` (
  `id` int(10) unsigned NOT NULL,
  `cateid` int(10) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` mediumtext NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `source` varchar(255) NOT NULL,
  `author` varchar(50) NOT NULL,
  `displayorder` tinyint(3) unsigned NOT NULL,
  `is_display` tinyint(3) unsigned NOT NULL,
  `is_show_home` tinyint(3) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `click` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_article_notice`
--

CREATE TABLE IF NOT EXISTS `sltx_article_notice` (
  `id` int(10) unsigned NOT NULL,
  `cateid` int(10) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` mediumtext NOT NULL,
  `displayorder` tinyint(3) unsigned NOT NULL,
  `is_display` tinyint(3) unsigned NOT NULL,
  `is_show_home` tinyint(3) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `click` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_article_unread_notice`
--

CREATE TABLE IF NOT EXISTS `sltx_article_unread_notice` (
  `id` int(10) unsigned NOT NULL,
  `notice_id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `is_new` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_basic_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_basic_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `content` varchar(1000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_business`
--

CREATE TABLE IF NOT EXISTS `sltx_business` (
  `id` int(10) unsigned NOT NULL,
  `weid` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `qq` varchar(15) NOT NULL,
  `province` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `dist` varchar(50) NOT NULL,
  `address` varchar(500) NOT NULL,
  `lng` varchar(10) NOT NULL,
  `lat` varchar(10) NOT NULL,
  `industry1` varchar(10) NOT NULL,
  `industry2` varchar(10) NOT NULL,
  `createtime` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_attachment`
--

CREATE TABLE IF NOT EXISTS `sltx_core_attachment` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_core_attachment`
--

INSERT INTO `sltx_core_attachment` (`id`, `uniacid`, `uid`, `filename`, `attachment`, `type`, `createtime`) VALUES
(1, 1, 1, 'e57575bbc002bf363fb37437bb12_680_616.c1.jpg', 'images/1/2017/01/EGyHz0K12Hs3IkJ04hS2hqT4Kjk34Z.jpg', 1, 1484042196);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_cache`
--

CREATE TABLE IF NOT EXISTS `sltx_core_cache` (
  `key` varchar(50) NOT NULL,
  `value` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_core_cache`
--

INSERT INTO `sltx_core_cache` (`key`, `value`) VALUES
('setting', 'a:8:{s:9:"copyright";a:1:{s:6:"slides";a:3:{i:0;s:58:"https://img.alicdn.com/tps/TB1pfG4IFXXXXc6XXXXXXXXXXXX.jpg";i:1;s:58:"https://img.alicdn.com/tps/TB1sXGYIFXXXXc5XpXXXXXXXXXX.jpg";i:2;s:58:"https://img.alicdn.com/tps/TB1h9xxIFXXXXbKXXXXXXXXXXXX.jpg";}}s:8:"authmode";i:1;s:5:"close";a:2:{s:6:"status";s:1:"0";s:6:"reason";s:0:"";}s:8:"register";a:4:{s:4:"open";i:0;s:6:"verify";i:1;s:4:"code";i:1;s:7:"groupid";i:1;}s:4:"site";a:5:{s:3:"key";s:5:"62706";s:5:"token";s:32:"79139afad502fe5cf89f870363632f8e";s:3:"url";s:22:"http://we7.temaiol.com";s:7:"version";s:3:"0.8";s:15:"profile_perfect";b:1;}s:7:"cloudip";a:2:{s:2:"ip";s:13:"112.90.51.175";s:6:"expire";i:1483816662;}s:6:"remote";a:5:{s:4:"type";i:2;s:3:"ftp";a:9:{s:3:"ssl";i:0;s:4:"host";s:0:"";s:4:"port";s:2:"21";s:8:"username";s:0:"";s:8:"password";s:0:"";s:4:"pasv";i:0;s:3:"dir";s:0:"";s:3:"url";s:0:"";s:8:"overtime";i:0;}s:6:"alioss";a:5:{s:3:"key";s:16:"LTAIj8GQp5pTM2V3";s:6:"secret";s:30:"GOgx0yEIh9NGA2sfmKW2Zr5EcKog15";s:6:"bucket";s:7:"temaiol";s:3:"url";s:22:"http://oss.temaiol.com";s:6:"ossurl";s:28:"oss-cn-shenzhen.aliyuncs.com";}s:5:"qiniu";a:4:{s:9:"accesskey";s:0:"";s:9:"secretkey";s:0:"";s:6:"bucket";s:0:"";s:3:"url";s:0:"";}s:3:"cos";a:5:{s:5:"appid";s:0:"";s:8:"secretid";s:0:"";s:9:"secretkey";s:0:"";s:6:"bucket";s:0:"";s:3:"url";s:0:"";}}s:18:"module_receive_ban";a:0:{}}'),
('system_frame', 'a:5:{s:8:"platform";a:3:{i:0;a:2:{s:5:"title";s:12:"基本功能";s:5:"items";a:9:{i:0;a:5:{s:2:"id";s:1:"3";s:5:"title";s:12:"文字回复";s:3:"url";s:38:"./index.php?c=platform&a=reply&m=basic";s:15:"permission_name";s:20:"platform_reply_basic";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:46:"./index.php?c=platform&a=reply&do=post&m=basic";}}i:1;a:5:{s:2:"id";s:1:"4";s:5:"title";s:12:"图文回复";s:3:"url";s:37:"./index.php?c=platform&a=reply&m=news";s:15:"permission_name";s:19:"platform_reply_news";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:45:"./index.php?c=platform&a=reply&do=post&m=news";}}i:2;a:5:{s:2:"id";s:1:"5";s:5:"title";s:12:"音乐回复";s:3:"url";s:38:"./index.php?c=platform&a=reply&m=music";s:15:"permission_name";s:20:"platform_reply_music";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:46:"./index.php?c=platform&a=reply&do=post&m=music";}}i:3;a:5:{s:2:"id";s:1:"6";s:5:"title";s:12:"图片回复";s:3:"url";s:39:"./index.php?c=platform&a=reply&m=images";s:15:"permission_name";s:21:"platform_reply_images";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:47:"./index.php?c=platform&a=reply&do=post&m=images";}}i:4;a:5:{s:2:"id";s:1:"7";s:5:"title";s:12:"语音回复";s:3:"url";s:38:"./index.php?c=platform&a=reply&m=voice";s:15:"permission_name";s:20:"platform_reply_voice";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:46:"./index.php?c=platform&a=reply&do=post&m=voice";}}i:5;a:5:{s:2:"id";s:1:"8";s:5:"title";s:12:"视频回复";s:3:"url";s:38:"./index.php?c=platform&a=reply&m=video";s:15:"permission_name";s:20:"platform_reply_video";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:46:"./index.php?c=platform&a=reply&do=post&m=video";}}i:6;a:5:{s:2:"id";s:1:"9";s:5:"title";s:18:"微信卡券回复";s:3:"url";s:39:"./index.php?c=platform&a=reply&m=wxcard";s:15:"permission_name";s:21:"platform_reply_wxcard";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:47:"./index.php?c=platform&a=reply&do=post&m=wxcard";}}i:7;a:5:{s:2:"id";s:2:"10";s:5:"title";s:21:"自定义接口回复";s:3:"url";s:40:"./index.php?c=platform&a=reply&m=userapi";s:15:"permission_name";s:22:"platform_reply_userapi";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:48:"./index.php?c=platform&a=reply&do=post&m=userapi";}}i:8;a:4:{s:2:"id";s:2:"11";s:5:"title";s:12:"系统回复";s:3:"url";s:44:"./index.php?c=platform&a=special&do=display&";s:15:"permission_name";s:21:"platform_reply_system";}}}i:1;a:2:{s:5:"title";s:12:"高级功能";s:5:"items";a:6:{i:0;a:4:{s:2:"id";s:2:"13";s:5:"title";s:18:"常用服务接入";s:3:"url";s:43:"./index.php?c=platform&a=service&do=switch&";s:15:"permission_name";s:16:"platform_service";}i:1;a:4:{s:2:"id";s:2:"14";s:5:"title";s:15:"自定义菜单";s:3:"url";s:30:"./index.php?c=platform&a=menu&";s:15:"permission_name";s:13:"platform_menu";}i:2;a:4:{s:2:"id";s:2:"15";s:5:"title";s:18:"特殊消息回复";s:3:"url";s:44:"./index.php?c=platform&a=special&do=message&";s:15:"permission_name";s:16:"platform_special";}i:3;a:4:{s:2:"id";s:2:"16";s:5:"title";s:15:"二维码管理";s:3:"url";s:28:"./index.php?c=platform&a=qr&";s:15:"permission_name";s:11:"platform_qr";}i:4;a:4:{s:2:"id";s:2:"17";s:5:"title";s:15:"多客服接入";s:3:"url";s:39:"./index.php?c=platform&a=reply&m=custom";s:15:"permission_name";s:21:"platform_reply_custom";}i:5;a:4:{s:2:"id";s:2:"18";s:5:"title";s:18:"长链接二维码";s:3:"url";s:32:"./index.php?c=platform&a=url2qr&";s:15:"permission_name";s:15:"platform_url2qr";}}}i:2;a:2:{s:5:"title";s:12:"数据统计";s:5:"items";a:4:{i:0;a:4:{s:2:"id";s:2:"20";s:5:"title";s:12:"聊天记录";s:3:"url";s:41:"./index.php?c=platform&a=stat&do=history&";s:15:"permission_name";s:21:"platform_stat_history";}i:1;a:4:{s:2:"id";s:2:"21";s:5:"title";s:24:"回复规则使用情况";s:3:"url";s:38:"./index.php?c=platform&a=stat&do=rule&";s:15:"permission_name";s:18:"platform_stat_rule";}i:2;a:4:{s:2:"id";s:2:"22";s:5:"title";s:21:"关键字命中情况";s:3:"url";s:41:"./index.php?c=platform&a=stat&do=keyword&";s:15:"permission_name";s:21:"platform_stat_keyword";}i:3;a:4:{s:2:"id";s:2:"23";s:5:"title";s:6:"参数";s:3:"url";s:41:"./index.php?c=platform&a=stat&do=setting&";s:15:"permission_name";s:21:"platform_stat_setting";}}}}s:4:"site";a:3:{i:0;a:2:{s:5:"title";s:12:"微站管理";s:5:"items";a:3:{i:0;a:5:{s:2:"id";s:2:"26";s:5:"title";s:12:"站点管理";s:3:"url";s:38:"./index.php?c=site&a=multi&do=display&";s:15:"permission_name";s:18:"site_multi_display";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:35:"./index.php?c=site&a=multi&do=post&";}}i:1;a:4:{s:2:"id";s:2:"29";s:5:"title";s:12:"模板管理";s:3:"url";s:39:"./index.php?c=site&a=style&do=template&";s:15:"permission_name";s:19:"site_style_template";}i:2;a:4:{s:2:"id";s:2:"30";s:5:"title";s:18:"模块模板扩展";s:3:"url";s:37:"./index.php?c=site&a=style&do=module&";s:15:"permission_name";s:17:"site_style_module";}}}i:1;a:2:{s:5:"title";s:18:"特殊页面管理";s:5:"items";a:2:{i:0;a:4:{s:2:"id";s:2:"32";s:5:"title";s:12:"会员中心";s:3:"url";s:34:"./index.php?c=site&a=editor&do=uc&";s:15:"permission_name";s:14:"site_editor_uc";}i:1;a:5:{s:2:"id";s:2:"33";s:5:"title";s:12:"专题页面";s:3:"url";s:36:"./index.php?c=site&a=editor&do=page&";s:15:"permission_name";s:16:"site_editor_page";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:38:"./index.php?c=site&a=editor&do=design&";}}}}i:2;a:2:{s:5:"title";s:12:"功能组件";s:5:"items";a:2:{i:0;a:4:{s:2:"id";s:2:"35";s:5:"title";s:12:"分类设置";s:3:"url";s:30:"./index.php?c=site&a=category&";s:15:"permission_name";s:13:"site_category";}i:1;a:4:{s:2:"id";s:2:"36";s:5:"title";s:12:"文章管理";s:3:"url";s:29:"./index.php?c=site&a=article&";s:15:"permission_name";s:12:"site_article";}}}}s:2:"mc";a:8:{i:0;a:2:{s:5:"title";s:12:"粉丝管理";s:5:"items";a:2:{i:0;a:4:{s:2:"id";s:2:"39";s:5:"title";s:12:"粉丝分组";s:3:"url";s:28:"./index.php?c=mc&a=fangroup&";s:15:"permission_name";s:11:"mc_fangroup";}i:1;a:4:{s:2:"id";s:2:"40";s:5:"title";s:6:"粉丝";s:3:"url";s:24:"./index.php?c=mc&a=fans&";s:15:"permission_name";s:7:"mc_fans";}}}i:1;a:2:{s:5:"title";s:12:"会员中心";s:5:"items";a:3:{i:0;a:4:{s:2:"id";s:2:"42";s:5:"title";s:21:"会员中心关键字";s:3:"url";s:37:"./index.php?c=platform&a=cover&do=mc&";s:15:"permission_name";s:17:"platform_cover_mc";}i:1;a:5:{s:2:"id";s:2:"43";s:5:"title";s:6:"会员";s:3:"url";s:25:"./index.php?c=mc&a=member";s:15:"permission_name";s:9:"mc_member";s:6:"append";a:2:{s:5:"title";s:26:"<i class="fa fa-plus"></i>";s:3:"url";s:32:"./index.php?c=mc&a=member&do=add";}}i:2;a:4:{s:2:"id";s:2:"44";s:5:"title";s:9:"会员组";s:3:"url";s:25:"./index.php?c=mc&a=group&";s:15:"permission_name";s:8:"mc_group";}}}i:2;a:2:{s:5:"title";s:15:"会员卡管理";s:5:"items";a:4:{i:0;a:4:{s:2:"id";s:2:"46";s:5:"title";s:18:"会员卡关键字";s:3:"url";s:36:"./index.php?c=platform&a=cover&eid=1";s:15:"permission_name";s:19:"platform_cover_card";}i:1;a:4:{s:2:"id";s:2:"47";s:5:"title";s:15:"会员卡管理";s:3:"url";s:64:"./index.php?c=site&a=entry&m=we7_coupon&do=cardmanage&op=display";s:15:"permission_name";s:14:"mc_card_manage";}i:2;a:4:{s:2:"id";s:2:"48";s:5:"title";s:15:"会员卡设置";s:3:"url";s:63:"./index.php?c=site&a=entry&m=we7_coupon&do=membercard&op=editor";s:15:"permission_name";s:14:"mc_card_editor";}i:3;a:4:{s:2:"id";s:2:"49";s:5:"title";s:21:"会员卡其他功能";s:3:"url";s:63:"./index.php?c=site&a=entry&m=we7_coupon&do=noticemanage&op=list";s:15:"permission_name";s:13:"mc_card_other";}}}i:3;a:2:{s:5:"title";s:12:"积分兑换";s:5:"items";a:2:{i:0;a:4:{s:2:"id";s:2:"51";s:5:"title";s:12:"卡券兑换";s:3:"url";s:56:"./index.php?c=activity&a=exchange&do=display&type=coupon";s:15:"permission_name";s:24:"activity_coupon_exchange";}i:1;a:4:{s:2:"id";s:2:"52";s:5:"title";s:18:"真实物品兑换";s:3:"url";s:67:"./index.php?c=site&a=entry&m=we7_coupon&do=goodsexchange&op=display";s:15:"permission_name";s:22:"activity_goods_display";}}}i:4;a:2:{s:5:"title";s:19:"微信素材&群发";s:5:"items";a:2:{i:0;a:4:{s:2:"id";s:2:"54";s:5:"title";s:13:"素材&群发";s:3:"url";s:32:"./index.php?c=material&a=display";s:15:"permission_name";s:16:"material_display";}i:1;a:4:{s:2:"id";s:2:"55";s:5:"title";s:12:"定时群发";s:3:"url";s:29:"./index.php?c=material&a=mass";s:15:"permission_name";s:13:"material_mass";}}}i:5;a:2:{s:5:"title";s:12:"卡券管理";s:5:"items";a:3:{i:0;a:4:{s:2:"id";s:2:"57";s:5:"title";s:12:"卡券列表";s:3:"url";s:66:"./index.php?c=site&a=entry&m=we7_coupon&do=couponmanage&op=display";s:15:"permission_name";s:23:"activity_coupon_display";}i:1;a:4:{s:2:"id";s:2:"58";s:5:"title";s:12:"卡券营销";s:3:"url";s:66:"./index.php?c=site&a=entry&m=we7_coupon&do=couponmarket&op=display";s:15:"permission_name";s:22:"activity_coupon_market";}i:2;a:4:{s:2:"id";s:2:"59";s:5:"title";s:12:"卡券核销";s:3:"url";s:67:"./index.php?c=site&a=entry&m=we7_coupon&do=couponconsume&op=display";s:15:"permission_name";s:23:"activity_consume_coupon";}}}i:6;a:2:{s:5:"title";s:9:"工作台";s:5:"items";a:4:{i:0;a:4:{s:2:"id";s:2:"61";s:5:"title";s:12:"门店列表";s:3:"url";s:63:"./index.php?c=site&a=entry&m=we7_coupon&do=storelist&op=display";s:15:"permission_name";s:19:"activity_store_list";}i:1;a:4:{s:2:"id";s:2:"62";s:5:"title";s:12:"店员列表";s:3:"url";s:63:"./index.php?c=site&a=entry&m=we7_coupon&do=clerklist&op=display";s:15:"permission_name";s:19:"activity_clerk_list";}i:2;a:4:{s:2:"id";s:2:"63";s:5:"title";s:18:"微信刷卡收款";s:3:"url";s:59:"./index.php?c=site&a=entry&m=we7_coupon&do=paycenter&op=pay";s:15:"permission_name";s:21:"paycenter_wxmicro_pay";}i:3;a:4:{s:2:"id";s:2:"64";s:5:"title";s:21:"店员操作关键字";s:3:"url";s:39:"./index.php?c=platform&a=cover&do=clerk";s:15:"permission_name";s:20:"platform_cover_clerk";}}}i:7;a:2:{s:5:"title";s:12:"统计中心";s:5:"items";a:5:{i:0;a:4:{s:2:"id";s:2:"66";s:5:"title";s:18:"会员积分统计";s:3:"url";s:28:"./index.php?c=stat&a=credit1";s:15:"permission_name";s:12:"stat_credit1";}i:1;a:4:{s:2:"id";s:2:"67";s:5:"title";s:18:"会员余额统计";s:3:"url";s:28:"./index.php?c=stat&a=credit2";s:15:"permission_name";s:12:"stat_credit2";}i:2;a:4:{s:2:"id";s:2:"68";s:5:"title";s:24:"会员现金消费统计";s:3:"url";s:25:"./index.php?c=stat&a=cash";s:15:"permission_name";s:9:"stat_cash";}i:3;a:4:{s:2:"id";s:2:"69";s:5:"title";s:15:"会员卡统计";s:3:"url";s:25:"./index.php?c=stat&a=card";s:15:"permission_name";s:9:"stat_card";}i:4;a:4:{s:2:"id";s:2:"70";s:5:"title";s:21:"收银台收款统计";s:3:"url";s:30:"./index.php?c=stat&a=paycenter";s:15:"permission_name";s:14:"stat_paycenter";}}}}s:7:"setting";a:3:{i:0;a:2:{s:5:"title";s:15:"公众号选项";s:5:"items";a:7:{i:0;a:4:{s:2:"id";s:2:"73";s:5:"title";s:12:"支付参数";s:3:"url";s:32:"./index.php?c=profile&a=payment&";s:15:"permission_name";s:15:"profile_payment";}i:1;a:4:{s:2:"id";s:2:"74";s:5:"title";s:19:"借用 oAuth 权限";s:3:"url";s:37:"./index.php?c=mc&a=passport&do=oauth&";s:15:"permission_name";s:17:"mc_passport_oauth";}i:2;a:4:{s:2:"id";s:2:"75";s:5:"title";s:22:"借用 JS 分享权限";s:3:"url";s:31:"./index.php?c=profile&a=jsauth&";s:15:"permission_name";s:14:"profile_jsauth";}i:3;a:4:{s:2:"id";s:2:"76";s:5:"title";s:18:"会员字段管理";s:3:"url";s:25:"./index.php?c=mc&a=fields";s:15:"permission_name";s:9:"mc_fields";}i:4;a:4:{s:2:"id";s:2:"77";s:5:"title";s:18:"微信通知设置";s:3:"url";s:28:"./index.php?c=mc&a=tplnotice";s:15:"permission_name";s:12:"mc_tplnotice";}i:5;a:4:{s:2:"id";s:2:"78";s:5:"title";s:21:"工作台菜单设置";s:3:"url";s:32:"./index.php?c=profile&a=deskmenu";s:15:"permission_name";s:16:"profile_deskmenu";}i:6;a:4:{s:2:"id";s:2:"79";s:5:"title";s:18:"会员扩展功能";s:3:"url";s:25:"./index.php?c=mc&a=plugin";s:15:"permission_name";s:9:"mc_plugin";}}}i:1;a:2:{s:5:"title";s:21:"会员及粉丝选项";s:5:"items";a:5:{i:0;a:4:{s:2:"id";s:2:"81";s:5:"title";s:12:"积分设置";s:3:"url";s:26:"./index.php?c=mc&a=credit&";s:15:"permission_name";s:9:"mc_credit";}i:1;a:4:{s:2:"id";s:2:"82";s:5:"title";s:12:"注册设置";s:3:"url";s:40:"./index.php?c=mc&a=passport&do=passport&";s:15:"permission_name";s:20:"mc_passport_passport";}i:2;a:4:{s:2:"id";s:2:"83";s:5:"title";s:18:"粉丝同步设置";s:3:"url";s:36:"./index.php?c=mc&a=passport&do=sync&";s:15:"permission_name";s:16:"mc_passport_sync";}i:3;a:4:{s:2:"id";s:2:"84";s:5:"title";s:14:"UC站点整合";s:3:"url";s:22:"./index.php?c=mc&a=uc&";s:15:"permission_name";s:5:"mc_uc";}i:4;a:4:{s:2:"id";s:2:"85";s:5:"title";s:18:"邮件通知参数";s:3:"url";s:30:"./index.php?c=profile&a=notify";s:15:"permission_name";s:14:"profile_notify";}}}i:2;a:1:{s:5:"title";s:18:"其他功能选项";}}s:3:"ext";a:1:{i:0;a:2:{s:5:"title";s:6:"管理";s:5:"items";a:1:{i:0;a:4:{s:2:"id";s:2:"89";s:5:"title";s:18:"扩展功能管理";s:3:"url";s:31:"./index.php?c=profile&a=module&";s:15:"permission_name";s:14:"profile_module";}}}}}'),
('userbasefields', 'a:44:{s:7:"uniacid";s:17:"同一公众号id";s:7:"groupid";s:8:"分组id";s:7:"credit1";s:6:"积分";s:7:"credit2";s:6:"余额";s:7:"credit3";s:19:"预留积分类型3";s:7:"credit4";s:19:"预留积分类型4";s:7:"credit5";s:19:"预留积分类型5";s:7:"credit6";s:19:"预留积分类型6";s:10:"createtime";s:12:"加入时间";s:6:"mobile";s:12:"手机号码";s:5:"email";s:12:"电子邮箱";s:8:"realname";s:12:"真实姓名";s:8:"nickname";s:6:"昵称";s:6:"avatar";s:6:"头像";s:2:"qq";s:5:"QQ号";s:6:"gender";s:6:"性别";s:5:"birth";s:6:"生日";s:13:"constellation";s:6:"星座";s:6:"zodiac";s:6:"生肖";s:9:"telephone";s:12:"固定电话";s:6:"idcard";s:12:"证件号码";s:9:"studentid";s:6:"学号";s:5:"grade";s:6:"班级";s:7:"address";s:6:"地址";s:7:"zipcode";s:6:"邮编";s:11:"nationality";s:6:"国籍";s:6:"reside";s:9:"居住地";s:14:"graduateschool";s:12:"毕业学校";s:7:"company";s:6:"公司";s:9:"education";s:6:"学历";s:10:"occupation";s:6:"职业";s:8:"position";s:6:"职位";s:7:"revenue";s:9:"年收入";s:15:"affectivestatus";s:12:"情感状态";s:10:"lookingfor";s:13:" 交友目的";s:9:"bloodtype";s:6:"血型";s:6:"height";s:6:"身高";s:6:"weight";s:6:"体重";s:6:"alipay";s:15:"支付宝帐号";s:3:"msn";s:3:"MSN";s:6:"taobao";s:12:"阿里旺旺";s:4:"site";s:6:"主页";s:3:"bio";s:12:"自我介绍";s:8:"interest";s:12:"兴趣爱好";}'),
('usersfields', 'a:45:{s:8:"realname";s:12:"真实姓名";s:8:"nickname";s:6:"昵称";s:6:"avatar";s:6:"头像";s:2:"qq";s:5:"QQ号";s:6:"mobile";s:12:"手机号码";s:3:"vip";s:9:"VIP级别";s:6:"gender";s:6:"性别";s:9:"birthyear";s:12:"出生生日";s:13:"constellation";s:6:"星座";s:6:"zodiac";s:6:"生肖";s:9:"telephone";s:12:"固定电话";s:6:"idcard";s:12:"证件号码";s:9:"studentid";s:6:"学号";s:5:"grade";s:6:"班级";s:7:"address";s:12:"邮寄地址";s:7:"zipcode";s:6:"邮编";s:11:"nationality";s:6:"国籍";s:14:"resideprovince";s:12:"居住地址";s:14:"graduateschool";s:12:"毕业学校";s:7:"company";s:6:"公司";s:9:"education";s:6:"学历";s:10:"occupation";s:6:"职业";s:8:"position";s:6:"职位";s:7:"revenue";s:9:"年收入";s:15:"affectivestatus";s:12:"情感状态";s:10:"lookingfor";s:13:" 交友目的";s:9:"bloodtype";s:6:"血型";s:6:"height";s:6:"身高";s:6:"weight";s:6:"体重";s:6:"alipay";s:15:"支付宝帐号";s:3:"msn";s:3:"MSN";s:5:"email";s:12:"电子邮箱";s:6:"taobao";s:12:"阿里旺旺";s:4:"site";s:6:"主页";s:3:"bio";s:12:"自我介绍";s:8:"interest";s:12:"兴趣爱好";s:7:"uniacid";s:17:"同一公众号id";s:7:"groupid";s:8:"分组id";s:7:"credit1";s:6:"积分";s:7:"credit2";s:6:"余额";s:7:"credit3";s:19:"预留积分类型3";s:7:"credit4";s:19:"预留积分类型4";s:7:"credit5";s:19:"预留积分类型5";s:7:"credit6";s:19:"预留积分类型6";s:10:"createtime";s:12:"加入时间";}'),
('module_receive_enable', 'a:0:{}'),
('upgrade', 'a:2:{s:7:"upgrade";b:0;s:10:"lastupdate";i:1483615923;}'),
('checkupgrade:system', 'a:1:{s:10:"lastupdate";i:1491787976;}'),
('modulesetting:1:we7_coupon', 'a:2:{s:11:"coupon_type";s:1:"0";s:15:"exchange_enable";s:1:"0";}'),
('unicount:', 's:1:"0";'),
('uniaccount:2', 'a:6:{s:4:"type";b:0;s:3:"uid";N;s:9:"starttime";N;s:7:"endtime";N;s:6:"groups";a:0:{}s:10:"grouplevel";b:0;}'),
('unimodules:1:1', 'a:14:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";s:1:"1";s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('uniaccount:1', 'a:28:{s:4:"acid";s:1:"1";s:7:"uniacid";s:1:"1";s:5:"token";s:32:"omJNpZEhZeHj1ZxFECKkP48B5VFbk1HP";s:12:"access_token";s:0:"";s:14:"encodingaeskey";s:0:"";s:5:"level";s:1:"1";s:4:"name";s:15:"顺联控制台";s:7:"account";s:0:"";s:8:"original";s:0:"";s:9:"signature";s:0:"";s:7:"country";s:0:"";s:8:"province";s:0:"";s:4:"city";s:0:"";s:8:"username";s:5:"admin";s:8:"password";s:32:"d89f2543875844ad65a8c06ff26d616a";s:10:"lastupdate";s:1:"0";s:3:"key";s:0:"";s:6:"secret";s:0:"";s:7:"styleid";s:1:"1";s:12:"subscribeurl";s:0:"";s:18:"auth_refresh_token";s:0:"";s:12:"default_acid";s:1:"1";s:4:"type";s:1:"1";s:3:"uid";N;s:9:"starttime";N;s:7:"endtime";N;s:6:"groups";a:2:{i:1;a:5:{s:7:"groupid";s:1:"1";s:7:"uniacid";s:1:"1";s:5:"title";s:15:"默认会员组";s:6:"credit";s:1:"0";s:9:"isdefault";s:1:"1";}i:2;a:5:{s:7:"groupid";s:1:"2";s:7:"uniacid";s:1:"1";s:5:"title";s:15:"普通会员组";s:6:"credit";s:3:"100";s:9:"isdefault";s:1:"0";}}s:10:"grouplevel";s:1:"0";}'),
('unimodules:1:', 'a:14:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";s:1:"1";s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('huangyinke', 'a:2:{i:0;a:6:{i:0;i:4;i:1;s:6:"书某";i:2;s:7:"D公司";i:3;s:9:"重庆市";i:4;s:13:"(023)13579135";i:5;s:10:"sm@php.com";}i:1;a:3:{i:0;i:5;i:1;s:5:"huang";s:2:"ke";a:3:{i:0;s:4:"okbe";i:1;s:4:"tttt";i:2;s:4:"kkkk";}}}'),
('unisetting:1', 'a:23:{s:7:"uniacid";s:1:"1";s:8:"passport";a:3:{s:8:"focusreg";i:0;s:4:"item";s:5:"email";s:4:"type";s:8:"password";}s:5:"oauth";a:2:{s:6:"status";s:1:"0";s:7:"account";s:1:"0";}s:11:"jsauth_acid";s:1:"0";s:2:"uc";a:1:{s:6:"status";i:0;}s:6:"notify";a:1:{s:3:"sms";a:2:{s:7:"balance";i:0;s:9:"signature";s:0:"";}}s:11:"creditnames";a:5:{s:7:"credit1";a:2:{s:5:"title";s:6:"积分";s:7:"enabled";i:1;}s:7:"credit2";a:2:{s:5:"title";s:6:"余额";s:7:"enabled";i:1;}s:7:"credit3";a:2:{s:5:"title";s:0:"";s:7:"enabled";i:0;}s:7:"credit4";a:2:{s:5:"title";s:0:"";s:7:"enabled";i:0;}s:7:"credit5";a:2:{s:5:"title";s:0:"";s:7:"enabled";i:0;}}s:15:"creditbehaviors";a:2:{s:8:"activity";s:7:"credit1";s:8:"currency";s:7:"credit2";}s:7:"welcome";s:0:"";s:7:"default";s:0:"";s:15:"default_message";s:0:"";s:9:"shortcuts";a:1:{s:12:"xsy_resource";a:2:{s:4:"name";s:12:"xsy_resource";s:4:"link";s:50:"./index.php?c=home&a=welcome&do=ext&m=xsy_resource";}}s:7:"payment";a:4:{s:6:"credit";a:1:{s:6:"switch";b:0;}s:6:"alipay";a:4:{s:6:"switch";b:0;s:7:"account";s:0:"";s:7:"partner";s:0:"";s:6:"secret";s:0:"";}s:6:"wechat";a:5:{s:6:"switch";b:0;s:7:"account";b:0;s:7:"signkey";s:0:"";s:7:"partner";s:0:"";s:3:"key";s:0:"";}s:8:"delivery";a:1:{s:6:"switch";b:0;}}s:4:"stat";s:0:"";s:12:"default_site";s:1:"1";s:4:"sync";s:1:"0";s:8:"recharge";s:0:"";s:9:"tplnotice";s:0:"";s:10:"grouplevel";s:1:"0";s:8:"mcplugin";s:0:"";s:15:"exchange_enable";s:1:"0";s:11:"coupon_type";s:1:"0";s:7:"menuset";s:0:"";}'),
('unicount:1', 's:1:"1";'),
('unimodules::', 'a:14:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('unisetting:2', 'b:0;'),
('unimodules:2:1', 'a:14:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('uniaccount:0', 'a:6:{s:4:"type";b:0;s:3:"uid";N;s:9:"starttime";N;s:7:"endtime";N;s:6:"groups";a:0:{}s:10:"grouplevel";b:0;}');
INSERT INTO `sltx_core_cache` (`key`, `value`) VALUES
('unimodules:2:', 'a:14:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('unisetting:0', 'b:0;'),
('unimodules::1', 'a:14:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('stat:todaylock:1', 'a:1:{s:6:"expire";i:1491619827;}'),
('ganboling', 'a:4:{s:5:"ms_id";s:9:"ganboling";s:4:"task";s:1888:"[{"id":"33","task_id":"34","task_d_id":"40","tesk_time":"10","tesk_num":"2","tesk_sort":"1","strategy_ID":"16","rand_time":64},{"id":"33","task_id":"34","task_d_id":"40","tesk_time":"10","tesk_num":"2","tesk_sort":"1","strategy_ID":"16","rand_time":65},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":59},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":64},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":62},{"id":"35","task_id":"34","task_d_id":"37","tesk_time":"5","tesk_num":"3","tesk_sort":"2","strategy_ID":"16","rand_time":63},{"id":"35","task_id":"34","task_d_id":"37","tesk_time":"5","tesk_num":"3","tesk_sort":"2","strategy_ID":"16","rand_time":61},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":64},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":59},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":65},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":65},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":59},{"id":"35","task_id":"34","task_d_id":"37","tesk_time":"5","tesk_num":"3","tesk_sort":"2","strategy_ID":"16","rand_time":59},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":60},{"id":"34","task_id":"34","task_d_id":"38","tesk_time":"4","tesk_num":"10","tesk_sort":"2","strategy_ID":"16","rand_time":61}]";s:10:"ms_task_id";i:0;s:4:"time";i:1489129880;}'),
('uniaccount:9', 'a:6:{s:4:"type";b:0;s:3:"uid";N;s:9:"starttime";N;s:7:"endtime";N;s:6:"groups";a:0:{}s:10:"grouplevel";b:0;}'),
('unisetting:9', 'b:0;'),
('unimodules:9:1', 'a:15:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:11:"ewei_shopv2";a:19:{s:3:"mid";s:2:"25";s:4:"name";s:11:"ewei_shopv2";s:4:"type";s:8:"business";s:5:"title";s:7:"sl_shop";s:7:"version";s:5:"3.9.1";s:7:"ability";s:7:"sl_shop";s:6:"author";s:2:"wq";s:3:"url";s:11:"temaiol.com";s:8:"settings";s:1:"0";s:10:"subscribes";a:14:{i:0;s:4:"text";i:1;s:5:"image";i:2;s:5:"voice";i:3;s:5:"video";i:4;s:10:"shortvideo";i:5;s:8:"location";i:6;s:4:"link";i:7;s:9:"subscribe";i:8;s:11:"unsubscribe";i:9;s:2:"qr";i:10;s:5:"trace";i:11;s:5:"click";i:12;s:4:"view";i:13;s:14:"merchant_order";}s:7:"handles";a:12:{i:0;s:4:"text";i:1;s:5:"image";i:2;s:5:"voice";i:3;s:5:"video";i:4;s:10:"shortvideo";i:5;s:8:"location";i:6;s:4:"link";i:7;s:9:"subscribe";i:8;s:2:"qr";i:9;s:5:"trace";i:10;s:5:"click";i:11;s:14:"merchant_order";}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('uniaccount:3', 'a:6:{s:4:"type";b:0;s:3:"uid";N;s:9:"starttime";N;s:7:"endtime";N;s:6:"groups";a:0:{}s:10:"grouplevel";b:0;}'),
('unisetting:3', 'b:0;'),
('unimodules:3:1', 'a:15:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:11:"ewei_shopv2";a:19:{s:3:"mid";s:2:"25";s:4:"name";s:11:"ewei_shopv2";s:4:"type";s:8:"business";s:5:"title";s:7:"sl_shop";s:7:"version";s:5:"3.9.1";s:7:"ability";s:7:"sl_shop";s:6:"author";s:2:"wq";s:3:"url";s:11:"temaiol.com";s:8:"settings";s:1:"0";s:10:"subscribes";a:14:{i:0;s:4:"text";i:1;s:5:"image";i:2;s:5:"voice";i:3;s:5:"video";i:4;s:10:"shortvideo";i:5;s:8:"location";i:6;s:4:"link";i:7;s:9:"subscribe";i:8;s:11:"unsubscribe";i:9;s:2:"qr";i:10;s:5:"trace";i:11;s:5:"click";i:12;s:4:"view";i:13;s:14:"merchant_order";}s:7:"handles";a:12:{i:0;s:4:"text";i:1;s:5:"image";i:2;s:5:"voice";i:3;s:5:"video";i:4;s:10:"shortvideo";i:5;s:8:"location";i:6;s:4:"link";i:7;s:9:"subscribe";i:8;s:2:"qr";i:9;s:5:"trace";i:10;s:5:"click";i:11;s:14:"merchant_order";}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}'),
('uniaccount:4', 'a:6:{s:4:"type";b:0;s:3:"uid";N;s:9:"starttime";N;s:7:"endtime";N;s:6:"groups";a:0:{}s:10:"grouplevel";b:0;}'),
('unisetting:4', 'b:0;'),
('unimodules:4:1', 'a:15:{s:5:"basic";a:19:{s:3:"mid";s:1:"1";s:4:"name";s:5:"basic";s:4:"type";s:6:"system";s:5:"title";s:18:"基本文字回复";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"和您进行简单对话";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"news";a:19:{s:3:"mid";s:1:"2";s:4:"name";s:4:"news";s:4:"type";s:6:"system";s:5:"title";s:24:"基本混合图文回复";s:7:"version";s:3:"1.0";s:7:"ability";s:33:"为你提供生动的图文资讯";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"music";a:19:{s:3:"mid";s:1:"3";s:4:"name";s:5:"music";s:4:"type";s:6:"system";s:5:"title";s:18:"基本音乐回复";s:7:"version";s:3:"1.0";s:7:"ability";s:39:"提供语音、音乐等音频类回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:7:"userapi";a:19:{s:3:"mid";s:1:"4";s:4:"name";s:7:"userapi";s:4:"type";s:6:"system";s:5:"title";s:21:"自定义接口回复";s:7:"version";s:3:"1.1";s:7:"ability";s:33:"更方便的第三方接口设置";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:8:"recharge";a:19:{s:3:"mid";s:1:"5";s:4:"name";s:8:"recharge";s:4:"type";s:6:"system";s:5:"title";s:24:"会员中心充值模块";s:7:"version";s:3:"1.0";s:7:"ability";s:24:"提供会员充值功能";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"custom";a:19:{s:3:"mid";s:1:"6";s:4:"name";s:6:"custom";s:4:"type";s:6:"system";s:5:"title";s:15:"多客服转接";s:7:"version";s:5:"1.0.0";s:7:"ability";s:36:"用来接入腾讯的多客服系统";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:17:"http://bbs.we7.cc";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"images";a:19:{s:3:"mid";s:1:"7";s:4:"name";s:6:"images";s:4:"type";s:6:"system";s:5:"title";s:18:"基本图片回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"video";a:19:{s:3:"mid";s:1:"8";s:4:"name";s:5:"video";s:4:"type";s:6:"system";s:5:"title";s:18:"基本视频回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供图片回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"voice";a:19:{s:3:"mid";s:1:"9";s:4:"name";s:5:"voice";s:4:"type";s:6:"system";s:5:"title";s:18:"基本语音回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"提供语音回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:5:"chats";a:19:{s:3:"mid";s:2:"10";s:4:"name";s:5:"chats";s:4:"type";s:6:"system";s:5:"title";s:18:"发送客服消息";s:7:"version";s:3:"1.0";s:7:"ability";s:77:"公众号可以在粉丝最后发送消息的48小时内无限制发送消息";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:6:"wxcard";a:19:{s:3:"mid";s:2:"11";s:4:"name";s:6:"wxcard";s:4:"type";s:6:"system";s:5:"title";s:18:"微信卡券回复";s:7:"version";s:3:"1.0";s:7:"ability";s:18:"微信卡券回复";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:9:"paycenter";a:19:{s:3:"mid";s:2:"12";s:4:"name";s:9:"paycenter";s:4:"type";s:6:"system";s:5:"title";s:9:"收银台";s:7:"version";s:3:"1.0";s:7:"ability";s:9:"收银台";s:6:"author";s:13:"WeEngine Team";s:3:"url";s:18:"http://www.we7.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";s:0:"";s:7:"handles";s:0:"";s:12:"isrulefields";s:1:"1";s:8:"issystem";s:1:"1";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:0:"";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:12:"xsy_resource";a:19:{s:3:"mid";s:2:"24";s:4:"name";s:12:"xsy_resource";s:4:"type";s:8:"services";s:5:"title";s:12:"脚本管理";s:7:"version";s:3:"1.0";s:7:"ability";s:15:"脚本管理器";s:6:"author";s:2:"gg";s:3:"url";s:20:"http://bbs.yinke.cc/";s:8:"settings";s:1:"0";s:10:"subscribes";a:0:{}s:7:"handles";a:0:{}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:11:"ewei_shopv2";a:19:{s:3:"mid";s:2:"25";s:4:"name";s:11:"ewei_shopv2";s:4:"type";s:8:"business";s:5:"title";s:7:"sl_shop";s:7:"version";s:5:"3.9.1";s:7:"ability";s:7:"sl_shop";s:6:"author";s:2:"wq";s:3:"url";s:11:"temaiol.com";s:8:"settings";s:1:"0";s:10:"subscribes";a:14:{i:0;s:4:"text";i:1;s:5:"image";i:2;s:5:"voice";i:3;s:5:"video";i:4;s:10:"shortvideo";i:5;s:8:"location";i:6;s:4:"link";i:7;s:9:"subscribe";i:8;s:11:"unsubscribe";i:9;s:2:"qr";i:10;s:5:"trace";i:11;s:5:"click";i:12;s:4:"view";i:13;s:14:"merchant_order";}s:7:"handles";a:12:{i:0;s:4:"text";i:1;s:5:"image";i:2;s:5:"voice";i:3;s:5:"video";i:4;s:10:"shortvideo";i:5;s:8:"location";i:6;s:4:"link";i:7;s:9:"subscribe";i:8;s:2:"qr";i:9;s:5:"trace";i:10;s:5:"click";i:11;s:14:"merchant_order";}s:12:"isrulefields";s:1:"0";s:8:"issystem";s:1:"0";s:6:"target";s:1:"0";s:6:"iscard";s:1:"0";s:11:"permissions";s:6:"a:0:{}";s:7:"enabled";i:1;s:6:"config";a:0:{}s:9:"isdisplay";i:1;}s:4:"core";a:5:{s:5:"title";s:24:"系统事件处理模块";s:4:"name";s:4:"core";s:8:"issystem";i:1;s:7:"enabled";i:1;s:9:"isdisplay";i:0;}}');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_cron`
--

CREATE TABLE IF NOT EXISTS `sltx_core_cron` (
  `id` int(10) unsigned NOT NULL,
  `cloudid` int(10) unsigned NOT NULL,
  `module` varchar(50) NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `lastruntime` int(10) unsigned NOT NULL,
  `nextruntime` int(10) unsigned NOT NULL,
  `weekday` tinyint(3) NOT NULL,
  `day` tinyint(3) NOT NULL,
  `hour` tinyint(3) NOT NULL,
  `minute` varchar(255) NOT NULL,
  `extra` varchar(5000) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_cron_record`
--

CREATE TABLE IF NOT EXISTS `sltx_core_cron_record` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `module` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `tid` int(10) unsigned NOT NULL,
  `note` varchar(500) NOT NULL,
  `tag` varchar(5000) NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_menu`
--

CREATE TABLE IF NOT EXISTS `sltx_core_menu` (
  `id` int(10) unsigned NOT NULL,
  `pid` int(10) unsigned NOT NULL,
  `title` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `append_title` varchar(30) NOT NULL,
  `append_url` varchar(255) NOT NULL,
  `displayorder` tinyint(3) unsigned NOT NULL,
  `type` varchar(15) NOT NULL,
  `is_display` tinyint(3) unsigned NOT NULL,
  `is_system` tinyint(3) unsigned NOT NULL,
  `permission_name` varchar(50) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_core_menu`
--

INSERT INTO `sltx_core_menu` (`id`, `pid`, `title`, `name`, `url`, `append_title`, `append_url`, `displayorder`, `type`, `is_display`, `is_system`, `permission_name`) VALUES
(1, 0, '基础设置', 'platform', '', 'fa fa-cog', '', 0, 'url', 1, 1, ''),
(2, 1, '基本功能', 'platform', '', '', '', 0, 'url', 1, 1, 'platform_basic_function'),
(3, 2, '文字回复', 'platform', './index.php?c=platform&a=reply&m=basic', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=basic', 0, 'url', 1, 1, 'platform_reply_basic'),
(4, 2, '图文回复', 'platform', './index.php?c=platform&a=reply&m=news', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=news', 0, 'url', 1, 1, 'platform_reply_news'),
(5, 2, '音乐回复', 'platform', './index.php?c=platform&a=reply&m=music', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=music', 0, 'url', 1, 1, 'platform_reply_music'),
(6, 2, '图片回复', 'platform', './index.php?c=platform&a=reply&m=images', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=images', 0, 'url', 1, 1, 'platform_reply_images'),
(7, 2, '语音回复', 'platform', './index.php?c=platform&a=reply&m=voice', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=voice', 0, 'url', 1, 1, 'platform_reply_voice'),
(8, 2, '视频回复', 'platform', './index.php?c=platform&a=reply&m=video', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=video', 0, 'url', 1, 1, 'platform_reply_video'),
(9, 2, '微信卡券回复', 'platform', './index.php?c=platform&a=reply&m=wxcard', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=wxcard', 0, 'url', 1, 1, 'platform_reply_wxcard'),
(10, 2, '自定义接口回复', 'platform', './index.php?c=platform&a=reply&m=userapi', 'fa fa-plus', './index.php?c=platform&a=reply&do=post&m=userapi', 0, 'url', 1, 1, 'platform_reply_userapi'),
(11, 2, '系统回复', 'platform', './index.php?c=platform&a=special&do=display&', '', '', 0, 'url', 1, 1, 'platform_reply_system'),
(12, 1, '高级功能', 'platform', '', '', '', 0, 'url', 1, 1, 'platform_high_function'),
(13, 12, '常用服务接入', 'platform', './index.php?c=platform&a=service&do=switch&', '', '', 0, 'url', 1, 1, 'platform_service'),
(14, 12, '自定义菜单', 'platform', './index.php?c=platform&a=menu&', '', '', 0, 'url', 1, 1, 'platform_menu'),
(15, 12, '特殊消息回复', 'platform', './index.php?c=platform&a=special&do=message&', '', '', 0, 'url', 1, 1, 'platform_special'),
(16, 12, '二维码管理', 'platform', './index.php?c=platform&a=qr&', '', '', 0, 'url', 1, 1, 'platform_qr'),
(17, 12, '多客服接入', 'platform', './index.php?c=platform&a=reply&m=custom', '', '', 0, 'url', 1, 1, 'platform_reply_custom'),
(18, 12, '长链接二维码', 'platform', './index.php?c=platform&a=url2qr&', '', '', 0, 'url', 1, 1, 'platform_url2qr'),
(19, 1, '数据统计', 'platform', '', '', '', 0, 'url', 1, 1, 'platform_stat'),
(20, 19, '聊天记录', 'platform', './index.php?c=platform&a=stat&do=history&', '', '', 0, 'url', 1, 1, 'platform_stat_history'),
(21, 19, '回复规则使用情况', 'platform', './index.php?c=platform&a=stat&do=rule&', '', '', 0, 'url', 1, 1, 'platform_stat_rule'),
(22, 19, '关键字命中情况', 'platform', './index.php?c=platform&a=stat&do=keyword&', '', '', 0, 'url', 1, 1, 'platform_stat_keyword'),
(23, 19, '参数', 'platform', './index.php?c=platform&a=stat&do=setting&', '', '', 0, 'url', 1, 1, 'platform_stat_setting'),
(24, 0, '微站功能', 'site', '', 'fa fa-life-bouy', '', 0, 'url', 1, 1, ''),
(25, 24, '微站管理', 'site', '', '', '', 0, 'url', 1, 1, 'site_manage'),
(26, 25, '站点管理', 'site', './index.php?c=site&a=multi&do=display&', 'fa fa-plus', './index.php?c=site&a=multi&do=post&', 0, 'url', 1, 1, 'site_multi_display'),
(27, 25, '站点添加/编辑', 'site', '', '', '', 0, 'permission', 0, 1, 'site_multi_post'),
(28, 25, '站点删除', 'site', '', '', '', 0, 'permission', 0, 1, 'site_multi_del'),
(29, 25, '模板管理', 'site', './index.php?c=site&a=style&do=template&', '', '', 0, 'url', 1, 1, 'site_style_template'),
(30, 25, '模块模板扩展', 'site', './index.php?c=site&a=style&do=module&', '', '', 0, 'url', 1, 1, 'site_style_module'),
(31, 24, '特殊页面管理', 'site', '', '', '', 0, 'url', 1, 1, 'site_special_page'),
(32, 31, '会员中心', 'site', './index.php?c=site&a=editor&do=uc&', '', '', 0, 'url', 1, 1, 'site_editor_uc'),
(33, 31, '专题页面', 'site', './index.php?c=site&a=editor&do=page&', 'fa fa-plus', './index.php?c=site&a=editor&do=design&', 0, 'url', 1, 1, 'site_editor_page'),
(34, 24, '功能组件', 'site', '', '', '', 0, 'url', 1, 1, 'site_article'),
(35, 34, '分类设置', 'site', './index.php?c=site&a=category&', '', '', 0, 'url', 1, 1, 'site_category'),
(36, 34, '文章管理', 'site', './index.php?c=site&a=article&', '', '', 0, 'url', 1, 1, 'site_article'),
(37, 0, '粉丝营销', 'mc', '', 'fa fa-gift', '', 0, 'url', 1, 1, ''),
(38, 37, '粉丝管理', 'mc', '', '', '', 0, 'url', 1, 1, 'mc_fans_manage'),
(39, 38, '粉丝分组', 'mc', './index.php?c=mc&a=fangroup&', '', '', 0, 'url', 1, 1, 'mc_fangroup'),
(40, 38, '粉丝', 'mc', './index.php?c=mc&a=fans&', '', '', 0, 'url', 1, 1, 'mc_fans'),
(41, 37, '会员中心', 'mc', '', '', '', 0, 'url', 1, 1, 'mc_members_manage'),
(42, 41, '会员中心关键字', 'mc', './index.php?c=platform&a=cover&do=mc&', '', '', 0, 'url', 1, 1, 'platform_cover_mc'),
(43, 41, '会员', 'mc', './index.php?c=mc&a=member', 'fa fa-plus', './index.php?c=mc&a=member&do=add', 0, 'url', 1, 1, 'mc_member'),
(44, 41, '会员组', 'mc', './index.php?c=mc&a=group&', '', '', 0, 'url', 1, 1, 'mc_group'),
(45, 37, '会员卡管理', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=cardmanage&op=display', '', '', 0, 'url', 1, 1, 'mc_card_manage'),
(46, 45, '会员卡关键字', 'mc', './index.php?c=platform&a=cover&eid=1', '', '', 0, 'url', 1, 1, 'platform_cover_card'),
(47, 45, '会员卡管理', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=cardmanage&op=display', '', '', 0, 'url', 1, 1, 'mc_card_manage'),
(48, 45, '会员卡设置', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=membercard&op=editor', '', '', 0, 'url', 1, 1, 'mc_card_editor'),
(49, 45, '会员卡其他功能', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=noticemanage&op=list', '', '', 0, 'url', 1, 1, 'mc_card_other'),
(50, 37, '积分兑换', 'mc', '', '', '', 0, 'url', 1, 1, 'activity_discount_manage'),
(51, 50, '卡券兑换', 'mc', './index.php?c=activity&a=exchange&do=display&type=coupon', '', '', 0, 'url', 1, 1, 'activity_coupon_exchange'),
(52, 50, '真实物品兑换', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=goodsexchange&op=display', '', '', 0, 'url', 1, 1, 'activity_goods_display'),
(53, 37, '微信素材&群发', 'mc', '', '', '', 0, 'url', 1, 1, 'material_manage'),
(54, 53, '素材&群发', 'mc', './index.php?c=material&a=display', '', '', 0, 'url', 1, 1, 'material_display'),
(55, 53, '定时群发', 'mc', './index.php?c=material&a=mass', '', '', 0, 'url', 1, 1, 'material_mass'),
(56, 37, '卡券管理', 'mc', '', '', '', 0, 'url', 1, 1, 'wechat_card_manage'),
(57, 56, '卡券列表', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=couponmanage&op=display', '', '', 0, 'url', 1, 1, 'activity_coupon_display'),
(58, 56, '卡券营销', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=couponmarket&op=display', '', '', 0, 'url', 1, 1, 'activity_coupon_market'),
(59, 56, '卡券核销', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=couponconsume&op=display', '', '', 0, 'url', 1, 1, 'activity_consume_coupon'),
(60, 37, '工作台', 'mc', '', '', '', 0, 'url', 1, 1, 'paycenter_manage'),
(61, 60, '门店列表', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=storelist&op=display', '', '', 0, 'url', 1, 1, 'activity_store_list'),
(62, 60, '店员列表', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=clerklist&op=display', '', '', 0, 'url', 1, 1, 'activity_clerk_list'),
(63, 60, '微信刷卡收款', 'mc', './index.php?c=site&a=entry&m=we7_coupon&do=paycenter&op=pay', '', '', 0, 'url', 1, 1, 'paycenter_wxmicro_pay'),
(64, 60, '店员操作关键字', 'mc', './index.php?c=platform&a=cover&do=clerk', '', '', 0, 'url', 1, 1, 'platform_cover_clerk'),
(65, 37, '统计中心', 'mc', '', '', '', 0, 'url', 1, 1, 'stat_center'),
(66, 65, '会员积分统计', 'mc', './index.php?c=stat&a=credit1', '', '', 0, 'url', 1, 1, 'stat_credit1'),
(67, 65, '会员余额统计', 'mc', './index.php?c=stat&a=credit2', '', '', 0, 'url', 1, 1, 'stat_credit2'),
(68, 65, '会员现金消费统计', 'mc', './index.php?c=stat&a=cash', '', '', 0, 'url', 1, 1, 'stat_cash'),
(69, 65, '会员卡统计', 'mc', './index.php?c=stat&a=card', '', '', 0, 'url', 1, 1, 'stat_card'),
(70, 65, '收银台收款统计', 'mc', './index.php?c=stat&a=paycenter', '', '', 0, 'url', 1, 1, 'stat_paycenter'),
(71, 0, '功能选项', 'setting', '', 'fa fa-umbrella', '', 0, 'url', 1, 1, ''),
(72, 71, '公众号选项', 'setting', '', '', '', 0, 'url', 1, 1, 'account_setting'),
(73, 72, '支付参数', 'setting', './index.php?c=profile&a=payment&', '', '', 0, 'url', 1, 1, 'profile_payment'),
(74, 72, '借用 oAuth 权限', 'setting', './index.php?c=mc&a=passport&do=oauth&', '', '', 0, 'url', 1, 1, 'mc_passport_oauth'),
(75, 72, '借用 JS 分享权限', 'setting', './index.php?c=profile&a=jsauth&', '', '', 0, 'url', 1, 1, 'profile_jsauth'),
(76, 72, '会员字段管理', 'setting', './index.php?c=mc&a=fields', '', '', 0, 'url', 1, 1, 'mc_fields'),
(77, 72, '微信通知设置', 'setting', './index.php?c=mc&a=tplnotice', '', '', 0, 'url', 1, 1, 'mc_tplnotice'),
(78, 72, '工作台菜单设置', 'setting', './index.php?c=profile&a=deskmenu', '', '', 0, 'url', 1, 1, 'profile_deskmenu'),
(79, 72, '会员扩展功能', 'setting', './index.php?c=mc&a=plugin', '', '', 0, 'url', 1, 1, 'mc_plugin'),
(80, 71, '会员及粉丝选项', 'setting', '', '', '', 0, 'url', 1, 1, 'mc_setting'),
(81, 80, '积分设置', 'setting', './index.php?c=mc&a=credit&', '', '', 0, 'url', 1, 1, 'mc_credit'),
(82, 80, '注册设置', 'setting', './index.php?c=mc&a=passport&do=passport&', '', '', 0, 'url', 1, 1, 'mc_passport_passport'),
(83, 80, '粉丝同步设置', 'setting', './index.php?c=mc&a=passport&do=sync&', '', '', 0, 'url', 1, 1, 'mc_passport_sync'),
(84, 80, 'UC站点整合', 'setting', './index.php?c=mc&a=uc&', '', '', 0, 'url', 1, 1, 'mc_uc'),
(85, 80, '邮件通知参数', 'setting', './index.php?c=profile&a=notify', '', '', 0, 'url', 1, 1, 'profile_notify'),
(86, 71, '其他功能选项', 'setting', '', '', '', 0, 'url', 1, 1, 'others_setting'),
(87, 0, '扩展功能', 'ext', '', 'fa fa-cubes', '', 0, 'url', 1, 1, ''),
(88, 87, '管理', 'ext', '', '', '', 0, 'url', 1, 1, ''),
(89, 88, '扩展功能管理', 'ext', './index.php?c=profile&a=module&', '', '', 0, 'url', 1, 1, 'profile_module');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_paylog`
--

CREATE TABLE IF NOT EXISTS `sltx_core_paylog` (
  `plid` bigint(11) unsigned NOT NULL,
  `type` varchar(20) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `acid` int(10) NOT NULL,
  `openid` varchar(40) NOT NULL,
  `uniontid` varchar(64) NOT NULL,
  `tid` varchar(128) NOT NULL,
  `fee` decimal(10,2) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `module` varchar(50) NOT NULL,
  `tag` varchar(2000) NOT NULL,
  `is_usecard` tinyint(3) unsigned NOT NULL,
  `card_type` tinyint(3) unsigned NOT NULL,
  `card_id` varchar(50) NOT NULL,
  `card_fee` decimal(10,2) unsigned NOT NULL,
  `encrypt_code` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_performance`
--

CREATE TABLE IF NOT EXISTS `sltx_core_performance` (
  `id` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL,
  `runtime` varchar(10) NOT NULL,
  `runurl` varchar(512) NOT NULL,
  `runsql` varchar(512) NOT NULL,
  `createtime` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_queue`
--

CREATE TABLE IF NOT EXISTS `sltx_core_queue` (
  `qid` bigint(20) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `message` varchar(2000) NOT NULL,
  `params` varchar(1000) NOT NULL,
  `keyword` varchar(1000) NOT NULL,
  `response` varchar(2000) NOT NULL,
  `module` varchar(50) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `dateline` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_resource`
--

CREATE TABLE IF NOT EXISTS `sltx_core_resource` (
  `mid` int(11) NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `media_id` varchar(100) NOT NULL,
  `trunk` int(10) unsigned NOT NULL,
  `type` varchar(10) NOT NULL,
  `dateline` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_sendsms_log`
--

CREATE TABLE IF NOT EXISTS `sltx_core_sendsms_log` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `result` varchar(255) NOT NULL,
  `createtime` int(11) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_sessions`
--

CREATE TABLE IF NOT EXISTS `sltx_core_sessions` (
  `sid` char(32) NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `openid` varchar(50) NOT NULL,
  `data` varchar(5000) NOT NULL,
  `expiretime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_core_sessions`
--

INSERT INTO `sltx_core_sessions` (`sid`, `uniacid`, `openid`, `data`, `expiretime`) VALUES
('65d522677f8d02a822441ab9cd16a15b', 1, '113.91.18.238', 'acid|s:1:"1";uniacid|i:1;token|a:4:{s:4:"XZj2";i:1484099928;s:4:"chay";i:1484099933;s:4:"u2tT";i:1484100121;s:4:"ZXb3";i:1484100123;}', 1484103723),
('8e06de4aa936ba985415f647a7341237', 1, '113.91.18.238', 'acid|s:1:"1";uniacid|i:1;token|a:1:{s:4:"P3Rb";i:1484184720;}', 1484188320),
('7c4521e54adeb57203c3fea0a7133382', 2, '113.91.18.238', 'acid|N;uniacid|i:2;token|a:1:{s:4:"S80z";i:1484190337;}', 1484193937),
('c865c55de7417689dc3c17a2a8a5091e', 0, '36.4.76.106', 'acid|N;uniacid|i:0;token|a:2:{s:4:"CVie";i:1484734634;s:4:"BJf0";i:1484734637;}', 1484738237),
('e4713e8405f023dfbc960d370ae7dbbe', 0, '101.226.125.119', 'acid|N;uniacid|i:0;token|a:1:{s:4:"W2u6";i:1484734636;}', 1484738236),
('ef76c952f15111691a49941cf97524eb', 0, '101.226.125.118', 'acid|N;uniacid|i:0;token|a:1:{s:4:"zwx4";i:1484734637;}', 1484738237),
('578cb9b9eda3800196e28492b3278c34', 0, '101.226.99.197', 'acid|N;uniacid|i:0;token|a:1:{s:4:"bhXJ";i:1484734642;}', 1484738242),
('1dd335537c204926c8cf068f8d51be26', 0, '140.207.185.112', 'acid|N;uniacid|i:0;token|a:1:{s:4:"PQqS";i:1484734644;}', 1484738244),
('5e0297c057b2b32ceb3fd2286dd064ef', 0, '101.226.89.123', 'acid|N;uniacid|i:0;token|a:1:{s:4:"fM11";i:1484734644;}', 1484738244),
('f12d7a0aa52c4c2fcb6a5e67d43ec6df', 0, '101.226.33.240', 'acid|N;uniacid|i:0;token|a:1:{s:4:"g66S";i:1484734646;}', 1484738246),
('e951e8b4dbd369c04cac2b5c5174dada', 0, '101.226.99.195', 'acid|N;uniacid|i:0;token|a:1:{s:4:"rGZs";i:1484734646;}', 1484738246),
('d9f4d54fb57ae9327959dd594c1020a8', 0, '36.4.78.114', 'acid|N;uniacid|i:0;token|a:4:{s:4:"XUTT";i:1485308115;s:4:"m6YQ";i:1485308116;s:4:"HRs1";i:1485308135;s:4:"rIgi";i:1485308137;}', 1485311737),
('3538f1406ea79bcd604cf67d109c4bf4', 0, '101.226.102.89', 'acid|N;uniacid|i:0;token|a:1:{s:4:"dbQS";i:1485308116;}', 1485311716),
('5a22fb6d2c668c19b38d6d9e75545c74', 0, '101.226.102.60', 'acid|N;uniacid|i:0;token|a:1:{s:4:"ab98";i:1485308116;}', 1485311716),
('ea11bf757affc092f8bf66de5ffc7a9a', 0, '101.226.68.213', 'acid|N;uniacid|i:0;token|a:1:{s:4:"SWO2";i:1485308120;}', 1485311720),
('c6caff4b28d3eb63cb308125dac72eb0', 0, '140.207.124.105', 'acid|N;uniacid|i:0;token|a:1:{s:4:"ck9U";i:1485308122;}', 1485311722),
('f32bb2486084a74590c0503370afeb7e', 0, '101.226.65.104', 'acid|N;uniacid|i:0;token|a:1:{s:4:"N34G";i:1485308125;}', 1485311725),
('24895327bcef157bdbb7b8ea8e178e4f', 0, '101.226.64.177', 'acid|N;uniacid|i:0;token|a:1:{s:4:"cs6F";i:1485308126;}', 1485311726),
('03eb46cf9da497cb6ff7f328864db2b4', 0, '101.226.33.202', 'acid|N;uniacid|i:0;token|a:1:{s:4:"W7yP";i:1485308126;}', 1485311726),
('4c1b782ac0038a087ff247cc523da9e6', 0, '101.226.125.114', 'acid|N;uniacid|i:0;token|a:1:{s:4:"qITO";i:1485308136;}', 1485311736),
('aac35dd6e090e1e46d26786bc72ee9aa', 0, '101.226.125.19', 'acid|N;uniacid|i:0;token|a:1:{s:4:"GLBq";i:1485308137;}', 1485311737),
('886cd83b2f5441995db2f92d725ee980', 0, '101.226.33.221', 'acid|N;uniacid|i:0;token|a:1:{s:4:"zcGY";i:1485308143;}', 1485311743),
('70cdb168119f0bb329b9670fba743070', 0, '101.226.33.200', 'acid|N;uniacid|i:0;token|a:1:{s:4:"lXJP";i:1485308145;}', 1485311745),
('ff3a4b1f3fc17f4b66bb45997af143a2', 0, '101.226.125.111', 'acid|N;uniacid|i:0;token|a:1:{s:4:"U3rn";i:1485308145;}', 1485311745),
('05560a246fdb19e0c566bb5f1958ce71', 0, '101.226.33.202', 'acid|N;uniacid|i:0;token|a:1:{s:4:"o89J";i:1485308146;}', 1485311746),
('0358c6a4acd94e7801ff31e9b123fef9', 0, '101.226.33.224', 'acid|N;uniacid|i:0;token|a:1:{s:4:"WxNX";i:1485308146;}', 1485311746),
('c93e7ebcf7a7349d685aee06f284e9af', 0, '101.226.64.177', 'acid|N;uniacid|i:0;token|a:1:{s:4:"yNPv";i:1485308173;}', 1485311773),
('55e70109cfb68aca4484248a84d5d7d1', 0, '101.226.66.174', 'acid|N;uniacid|i:0;token|a:1:{s:4:"qbkk";i:1485308175;}', 1485311775),
('2896f24c7c9bed5960f541b9a0ae35b6', 0, '101.226.89.117', 'acid|N;uniacid|i:0;token|a:1:{s:4:"gM79";i:1487143453;}', 1487147053),
('6422c8f2c8c13551d70077085594e6eb', 0, '101.226.33.220', 'acid|N;uniacid|i:0;token|a:1:{s:4:"ezDa";i:1487143454;}', 1487147054),
('d2b3ea5c42a8192a50aae03ed5a8fad2', 0, '180.153.201.79', 'acid|N;uniacid|i:0;token|a:1:{s:4:"elul";i:1487143455;}', 1487147055),
('62ffeefcee51a65a5114bc2777a311ae', 0, '14.30.131.79', 'acid|N;uniacid|i:0;token|a:2:{s:4:"sTWX";i:1487143691;s:4:"N5a5";i:1487143699;}', 1487147299),
('ffc09f4d2698edca6d920214f1f56a11', 0, '183.61.51.226', 'acid|N;uniacid|i:0;token|a:1:{s:4:"sXEm";i:1487143697;}', 1487147297),
('d3ef6e67c0b1de33cf25598a216af535', 0, '14.17.37.144', 'acid|N;uniacid|i:0;token|a:1:{s:4:"zcnl";i:1487143697;}', 1487147297),
('0614bdbe7b56c6099238a1141b83c8bc', 0, '180.153.206.22', 'acid|N;uniacid|i:0;token|a:1:{s:4:"Ju0T";i:1487143699;}', 1487147299),
('06d62fac5d25dd5c185efdec3c77d6a3', 0, '180.153.214.200', 'acid|N;uniacid|i:0;token|a:1:{s:4:"Ih37";i:1487143699;}', 1487147299),
('ba452e336d138ca446405549f4cee208', 0, '101.226.51.226', 'acid|N;uniacid|i:0;token|a:1:{s:4:"y52s";i:1487143701;}', 1487147301),
('a71700ca9472af2806af769b72ea82fb', 0, '101.226.33.220', 'acid|N;uniacid|i:0;token|a:1:{s:4:"PbZb";i:1487143701;}', 1487147301),
('a10a0d3aeea57450ea01766ed54b2bc7', 0, '140.207.185.109', 'acid|N;uniacid|i:0;token|a:1:{s:4:"B3T4";i:1487143707;}', 1487147307),
('5f03e94e2114494b33c805d0091c325f', 0, '101.226.33.237', 'acid|N;uniacid|i:0;token|a:1:{s:4:"k3RG";i:1487143707;}', 1487147307),
('b9d71d144ed4d8ad1541a6b80c3859d9', 0, '180.153.206.21', 'acid|N;uniacid|i:0;token|a:1:{s:4:"j6VF";i:1487143707;}', 1487147307),
('33c40a2a0269c61b6acb9e24641916e2', 0, '117.185.27.113', 'acid|N;uniacid|i:0;token|a:1:{s:4:"Ib44";i:1487143707;}', 1487147307),
('84fd6b02b2c0973899336b1340f613bd', 4, '113.118.169.150', 'acid|N;uniacid|i:4;token|a:1:{s:4:"A3i3";i:1487562664;}', 1487566264),
('478032a597b85318f8380d849bb84eed', 0, '180.153.214.178', 'acid|N;uniacid|i:0;token|a:1:{s:4:"VXIV";i:1488941694;}', 1488945294),
('89997b348f2c7d6b089f568072cb8689', 0, '180.153.214.199', 'acid|N;uniacid|i:0;token|a:1:{s:4:"K679";i:1488941695;}', 1488945295),
('cffcb2a481463043163429db56358e5a', 0, '113.91.3.121', 'acid|N;uniacid|i:0;token|a:2:{s:4:"jEGq";i:1488979194;s:4:"ec3j";i:1488979198;}', 1488982798),
('7ce1f127b89af22e70afd759b3825996', 0, '163.177.69.13', 'acid|N;uniacid|i:0;token|a:1:{s:4:"Ak9N";i:1488979197;}', 1488982797),
('e85b0f605f12734ef28fcee5276837d2', 0, '14.17.11.196', 'acid|N;uniacid|i:0;token|a:1:{s:4:"zfC0";i:1488979197;}', 1488982797),
('cc0f0e83d324a6f1dbdecd242c83223e', 0, '101.226.66.191', 'acid|N;uniacid|i:0;token|a:1:{s:4:"EvT0";i:1488979202;}', 1488982802),
('f6733791abc48c9a218f0e5b6cccaec1', 0, '117.185.27.115', 'acid|N;uniacid|i:0;token|a:1:{s:4:"VXns";i:1488979204;}', 1488982804),
('26f22d4ad35ccda9c537179b65fbf1d4', 0, '101.226.33.216', 'acid|N;uniacid|i:0;token|a:1:{s:4:"GYYk";i:1488979204;}', 1488982804);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_core_settings`
--

CREATE TABLE IF NOT EXISTS `sltx_core_settings` (
  `key` varchar(200) NOT NULL,
  `value` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_core_settings`
--

INSERT INTO `sltx_core_settings` (`key`, `value`) VALUES
('copyright', 'a:1:{s:6:"slides";a:3:{i:0;s:58:"https://img.alicdn.com/tps/TB1pfG4IFXXXXc6XXXXXXXXXXXX.jpg";i:1;s:58:"https://img.alicdn.com/tps/TB1sXGYIFXXXXc5XpXXXXXXXXXX.jpg";i:2;s:58:"https://img.alicdn.com/tps/TB1h9xxIFXXXXbKXXXXXXXXXXXX.jpg";}}'),
('authmode', 'i:1;'),
('close', 'a:2:{s:6:"status";s:1:"0";s:6:"reason";s:0:"";}'),
('register', 'a:4:{s:4:"open";i:0;s:6:"verify";i:1;s:4:"code";i:1;s:7:"groupid";i:1;}'),
('site', 'a:5:{s:3:"key";s:5:"62706";s:5:"token";s:32:"79139afad502fe5cf89f870363632f8e";s:3:"url";s:22:"http://we7.temaiol.com";s:7:"version";s:3:"0.8";s:15:"profile_perfect";b:1;}'),
('cloudip', 'a:2:{s:2:"ip";s:13:"112.90.51.175";s:6:"expire";i:1483816662;}'),
('remote', 'a:5:{s:4:"type";i:2;s:3:"ftp";a:9:{s:3:"ssl";i:0;s:4:"host";s:0:"";s:4:"port";s:2:"21";s:8:"username";s:0:"";s:8:"password";s:0:"";s:4:"pasv";i:0;s:3:"dir";s:0:"";s:3:"url";s:0:"";s:8:"overtime";i:0;}s:6:"alioss";a:5:{s:3:"key";s:16:"LTAIj8GQp5pTM2V3";s:6:"secret";s:30:"GOgx0yEIh9NGA2sfmKW2Zr5EcKog15";s:6:"bucket";s:7:"temaiol";s:3:"url";s:22:"http://oss.temaiol.com";s:6:"ossurl";s:28:"oss-cn-shenzhen.aliyuncs.com";}s:5:"qiniu";a:4:{s:9:"accesskey";s:0:"";s:9:"secretkey";s:0:"";s:6:"bucket";s:0:"";s:3:"url";s:0:"";}s:3:"cos";a:5:{s:5:"appid";s:0:"";s:8:"secretid";s:0:"";s:9:"secretkey";s:0:"";s:6:"bucket";s:0:"";s:3:"url";s:0:"";}}'),
('module_receive_ban', 'a:0:{}');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_coupon`
--

CREATE TABLE IF NOT EXISTS `sltx_coupon` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `card_id` varchar(50) NOT NULL,
  `type` varchar(15) NOT NULL,
  `logo_url` varchar(150) NOT NULL,
  `code_type` tinyint(3) unsigned NOT NULL,
  `brand_name` varchar(15) NOT NULL,
  `title` varchar(15) NOT NULL,
  `sub_title` varchar(20) NOT NULL,
  `color` varchar(15) NOT NULL,
  `notice` varchar(15) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `date_info` varchar(200) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `use_custom_code` tinyint(3) NOT NULL,
  `bind_openid` tinyint(3) unsigned NOT NULL,
  `can_share` tinyint(3) unsigned NOT NULL,
  `can_give_friend` tinyint(3) unsigned NOT NULL,
  `get_limit` tinyint(3) unsigned NOT NULL,
  `service_phone` varchar(20) NOT NULL,
  `extra` varchar(1000) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `is_display` tinyint(3) unsigned NOT NULL,
  `is_selfconsume` tinyint(3) unsigned NOT NULL,
  `promotion_url_name` varchar(10) NOT NULL,
  `promotion_url` varchar(100) NOT NULL,
  `promotion_url_sub_title` varchar(10) NOT NULL,
  `source` tinyint(3) unsigned NOT NULL,
  `dosage` int(10) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_coupon_activity`
--

CREATE TABLE IF NOT EXISTS `sltx_coupon_activity` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) NOT NULL,
  `msg_id` int(10) NOT NULL,
  `status` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` int(3) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `coupons` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `members` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_coupon_groups`
--

CREATE TABLE IF NOT EXISTS `sltx_coupon_groups` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) NOT NULL,
  `couponid` varchar(255) NOT NULL,
  `groupid` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_coupon_location`
--

CREATE TABLE IF NOT EXISTS `sltx_coupon_location` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `sid` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `branch_name` varchar(50) NOT NULL,
  `category` varchar(255) NOT NULL,
  `province` varchar(15) NOT NULL,
  `city` varchar(15) NOT NULL,
  `district` varchar(15) NOT NULL,
  `address` varchar(50) NOT NULL,
  `longitude` varchar(15) NOT NULL,
  `latitude` varchar(15) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `photo_list` varchar(10000) NOT NULL,
  `avg_price` int(10) unsigned NOT NULL,
  `open_time` varchar(50) NOT NULL,
  `recommend` varchar(255) NOT NULL,
  `special` varchar(255) NOT NULL,
  `introduction` varchar(255) NOT NULL,
  `offset_type` tinyint(3) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `message` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_coupon_modules`
--

CREATE TABLE IF NOT EXISTS `sltx_coupon_modules` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `couponid` int(10) unsigned NOT NULL,
  `module` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_coupon_record`
--

CREATE TABLE IF NOT EXISTS `sltx_coupon_record` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `card_id` varchar(50) NOT NULL,
  `openid` varchar(50) NOT NULL,
  `friend_openid` varchar(50) NOT NULL,
  `givebyfriend` tinyint(3) unsigned NOT NULL,
  `code` varchar(50) NOT NULL,
  `hash` varchar(32) NOT NULL,
  `addtime` int(10) unsigned NOT NULL,
  `usetime` int(10) unsigned NOT NULL,
  `status` tinyint(3) NOT NULL,
  `clerk_name` varchar(15) NOT NULL,
  `clerk_id` int(10) unsigned NOT NULL,
  `store_id` int(10) unsigned NOT NULL,
  `clerk_type` tinyint(3) unsigned NOT NULL,
  `couponid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `grantmodule` varchar(255) NOT NULL,
  `remark` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_coupon_store`
--

CREATE TABLE IF NOT EXISTS `sltx_coupon_store` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) NOT NULL,
  `couponid` varchar(255) NOT NULL,
  `storeid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_cover_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_cover_reply` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `multiid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `module` varchar(30) NOT NULL,
  `do` varchar(30) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_cover_reply`
--

INSERT INTO `sltx_cover_reply` (`id`, `uniacid`, `multiid`, `rid`, `module`, `do`, `title`, `description`, `thumb`, `url`) VALUES
(1, 1, 0, 7, 'mc', '', '进入个人中心', '', '', './index.php?c=mc&a=home&i=1'),
(2, 1, 1, 8, 'site', '', '进入首页', '', '', './index.php?c=home&i=1&t=1');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_custom_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_custom_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `start1` int(10) NOT NULL,
  `end1` int(10) NOT NULL,
  `start2` int(10) NOT NULL,
  `end2` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_images_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_images_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `mediaid` varchar(255) NOT NULL,
  `createtime` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `color` varchar(255) NOT NULL,
  `background` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `format_type` tinyint(3) unsigned NOT NULL,
  `format` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `fields` varchar(1000) NOT NULL,
  `snpos` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `business` text NOT NULL,
  `discount_type` tinyint(3) unsigned NOT NULL,
  `discount` varchar(3000) NOT NULL,
  `grant` varchar(3000) NOT NULL,
  `grant_rate` varchar(20) NOT NULL,
  `offset_rate` int(10) unsigned NOT NULL,
  `offset_max` int(10) NOT NULL,
  `nums_status` tinyint(3) unsigned NOT NULL,
  `nums_text` varchar(15) NOT NULL,
  `nums` varchar(1000) NOT NULL,
  `times_status` tinyint(3) unsigned NOT NULL,
  `times_text` varchar(15) NOT NULL,
  `times` varchar(1000) NOT NULL,
  `params` longtext NOT NULL,
  `html` longtext NOT NULL,
  `recommend_status` tinyint(3) unsigned NOT NULL,
  `sign_status` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_care`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_care` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `title` varchar(30) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `groupid` int(10) unsigned NOT NULL,
  `credit1` int(10) unsigned NOT NULL,
  `credit2` int(10) unsigned NOT NULL,
  `couponid` int(10) unsigned NOT NULL,
  `granttime` int(10) unsigned NOT NULL,
  `days` int(10) unsigned NOT NULL,
  `time` tinyint(3) unsigned NOT NULL,
  `show_in_card` tinyint(3) unsigned NOT NULL,
  `content` varchar(1000) NOT NULL,
  `sms_notice` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_credit_set`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_credit_set` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `sign` varchar(1000) NOT NULL,
  `share` varchar(500) NOT NULL,
  `content` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_members`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_members` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) DEFAULT NULL,
  `openid` varchar(50) NOT NULL,
  `cid` int(10) NOT NULL,
  `cardsn` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `nums` int(10) unsigned NOT NULL,
  `endtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_notices`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_notices` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `title` varchar(30) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `groupid` int(10) unsigned NOT NULL,
  `content` text NOT NULL,
  `addtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_notices_unread`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_notices_unread` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `notice_id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `is_new` tinyint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_recommend`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_recommend` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `title` varchar(30) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `displayorder` tinyint(3) unsigned NOT NULL,
  `addtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_record`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_record` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `type` varchar(15) NOT NULL,
  `model` tinyint(3) unsigned NOT NULL,
  `fee` decimal(10,2) unsigned NOT NULL,
  `tag` varchar(10) NOT NULL,
  `note` varchar(255) NOT NULL,
  `remark` varchar(200) NOT NULL,
  `addtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_card_sign_record`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_card_sign_record` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `credit` int(10) unsigned NOT NULL,
  `is_grant` tinyint(3) unsigned NOT NULL,
  `addtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_cash_record`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_cash_record` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `clerk_id` int(10) unsigned NOT NULL,
  `store_id` int(10) unsigned NOT NULL,
  `clerk_type` tinyint(3) unsigned NOT NULL,
  `fee` decimal(10,2) unsigned NOT NULL,
  `final_fee` decimal(10,2) unsigned NOT NULL,
  `credit1` int(10) unsigned NOT NULL,
  `credit1_fee` decimal(10,2) unsigned NOT NULL,
  `credit2` decimal(10,2) unsigned NOT NULL,
  `cash` decimal(10,2) unsigned NOT NULL,
  `return_cash` decimal(10,2) unsigned NOT NULL,
  `final_cash` decimal(10,2) unsigned NOT NULL,
  `remark` varchar(255) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `trade_type` varchar(20) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_mc_cash_record`
--

INSERT INTO `sltx_mc_cash_record` (`id`, `uniacid`, `uid`, `clerk_id`, `store_id`, `clerk_type`, `fee`, `final_fee`, `credit1`, `credit1_fee`, `credit2`, `cash`, `return_cash`, `final_cash`, `remark`, `createtime`, `trade_type`) VALUES
(1, 1, 16, 2, 0, 2, '155554.00', '155554.00', 0, '0.00', '155554.00', '0.00', '0.00', '0.00', '系统日志:会员消费【155554】元,使用余额支付【155554】元', 1490702950, '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_chats_record`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_chats_record` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `flag` tinyint(3) unsigned NOT NULL,
  `openid` varchar(32) NOT NULL,
  `msgtype` varchar(15) NOT NULL,
  `content` varchar(10000) NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_credits_recharge`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_credits_recharge` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `openid` varchar(50) NOT NULL,
  `tid` varchar(64) NOT NULL,
  `transid` varchar(30) NOT NULL,
  `fee` varchar(10) NOT NULL,
  `type` varchar(15) NOT NULL,
  `tag` varchar(10) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `backtype` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_credits_record`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_credits_record` (
  `id` int(11) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `uniacid` int(11) NOT NULL,
  `credittype` varchar(10) NOT NULL,
  `num` decimal(10,2) NOT NULL,
  `operator` int(10) unsigned NOT NULL,
  `module` varchar(30) NOT NULL,
  `clerk_id` int(10) unsigned NOT NULL,
  `store_id` int(10) unsigned NOT NULL,
  `clerk_type` tinyint(3) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `remark` varchar(200) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_mc_credits_record`
--

INSERT INTO `sltx_mc_credits_record` (`id`, `uid`, `uniacid`, `credittype`, `num`, `operator`, `module`, `clerk_id`, `store_id`, `clerk_type`, `createtime`, `remark`) VALUES
(1, 4, 1, 'credit1', '500.00', 2, 'system', 2, 0, 2, 1484734990, '手动添加'),
(11, 18, 1, 'credit2', '888.00', 2, 'system', 2, 0, 2, 1491010799, '系统后台: 添加888元'),
(3, 11, 1, 'credit2', '1000.00', 11, 'system', 0, 0, 1, 1490178169, ': 添加1000元'),
(4, 11, 1, 'credit1', '10.00', 11, 'system', 2, 0, 2, 1490250362, '系统后台: 添加10积分'),
(5, 16, 1, 'credit2', '88888.00', 2, 'system', 2, 0, 2, 1490702886, '系统后台: 添加88888元'),
(6, 16, 1, 'credit1', '66666.00', 2, 'system', 2, 0, 2, 1490702904, '系统后台: 添加66666积分'),
(7, 16, 1, 'credit2', '666666.00', 2, 'system', 2, 0, 2, 1490702915, '系统后台: 添加666666元'),
(8, 16, 1, 'credit2', '-155554.00', 0, 'system', 2, 0, 2, 1490702950, '系统日志:会员消费【155554】元,使用余额支付【155554】元'),
(9, 16, 1, 'credit2', '66666.00', 2, 'system', 2, 0, 2, 1490702960, '系统后台: 添加66666元'),
(12, 19, 1, 'credit2', '1000.00', 2, 'system', 2, 0, 2, 1491213700, '系统后台: 添加1000元');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_fans_groups`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_fans_groups` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `groups` varchar(10000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_fans_tag_mapping`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_fans_tag_mapping` (
  `id` int(11) unsigned NOT NULL,
  `fanid` int(11) unsigned NOT NULL,
  `tagid` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_groups`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_groups` (
  `groupid` int(11) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `title` varchar(20) NOT NULL,
  `credit` int(10) unsigned NOT NULL,
  `isdefault` tinyint(4) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_mc_groups`
--

INSERT INTO `sltx_mc_groups` (`groupid`, `uniacid`, `title`, `credit`, `isdefault`) VALUES
(1, 1, '默认会员组', 0, 1),
(2, 1, '普通会员组', 100, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_handsel`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_handsel` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) NOT NULL,
  `touid` int(10) unsigned NOT NULL,
  `fromuid` varchar(32) NOT NULL,
  `module` varchar(30) NOT NULL,
  `sign` varchar(100) NOT NULL,
  `action` varchar(20) NOT NULL,
  `credit_value` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_mapping_fans`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_mapping_fans` (
  `fanid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `openid` varchar(50) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `groupid` varchar(30) NOT NULL,
  `salt` char(8) NOT NULL,
  `follow` tinyint(1) unsigned NOT NULL,
  `followtime` int(10) unsigned NOT NULL,
  `unfollowtime` int(10) unsigned NOT NULL,
  `tag` varchar(1000) NOT NULL,
  `updatetime` int(10) unsigned DEFAULT NULL,
  `unionid` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_mapping_ucenter`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_mapping_ucenter` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `centeruid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_mass_record`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_mass_record` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `groupname` varchar(50) NOT NULL,
  `fansnum` int(10) unsigned NOT NULL,
  `msgtype` varchar(10) NOT NULL,
  `content` varchar(10000) NOT NULL,
  `group` int(10) NOT NULL,
  `attach_id` int(10) unsigned NOT NULL,
  `media_id` varchar(100) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `cron_id` int(10) unsigned NOT NULL,
  `sendtime` int(10) unsigned NOT NULL,
  `finalsendtime` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_members`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_members` (
  `uid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `realname` varchar(10) NOT NULL,
  `password` varchar(32) NOT NULL,
  `ms_code` varchar(128) NOT NULL,
  `strategy_id` int(11) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `salt` varchar(8) NOT NULL,
  `groupid` int(11) NOT NULL,
  `credit1` decimal(10,2) unsigned NOT NULL,
  `credit2` decimal(10,2) unsigned NOT NULL,
  `credit3` decimal(10,2) unsigned NOT NULL,
  `credit4` decimal(10,2) unsigned NOT NULL,
  `credit5` decimal(10,2) unsigned NOT NULL,
  `credit6` decimal(10,2) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `qq` varchar(15) NOT NULL,
  `vip` tinyint(3) unsigned NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `birthyear` smallint(6) unsigned NOT NULL,
  `birthmonth` tinyint(3) unsigned NOT NULL,
  `birthday` tinyint(3) unsigned NOT NULL,
  `constellation` varchar(10) NOT NULL,
  `zodiac` varchar(5) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `idcard` varchar(30) NOT NULL,
  `studentid` varchar(50) NOT NULL,
  `grade` varchar(10) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zipcode` varchar(10) NOT NULL,
  `nationality` varchar(30) NOT NULL,
  `resideprovince` varchar(30) NOT NULL,
  `residecity` varchar(30) NOT NULL,
  `residedist` varchar(30) NOT NULL,
  `graduateschool` varchar(50) NOT NULL,
  `company` varchar(50) NOT NULL,
  `education` varchar(10) NOT NULL,
  `occupation` varchar(30) NOT NULL,
  `position` varchar(30) NOT NULL,
  `revenue` varchar(10) NOT NULL,
  `affectivestatus` varchar(30) NOT NULL,
  `lookingfor` varchar(255) NOT NULL,
  `bloodtype` varchar(5) NOT NULL,
  `height` varchar(5) NOT NULL,
  `weight` varchar(5) NOT NULL,
  `alipay` varchar(30) NOT NULL,
  `msn` varchar(30) NOT NULL,
  `taobao` varchar(30) NOT NULL,
  `site` varchar(30) NOT NULL,
  `bio` text NOT NULL,
  `interest` text NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_mc_members`
--

INSERT INTO `sltx_mc_members` (`uid`, `uniacid`, `realname`, `password`, `ms_code`, `strategy_id`, `mobile`, `email`, `salt`, `groupid`, `credit1`, `credit2`, `credit3`, `credit4`, `credit5`, `credit6`, `createtime`, `nickname`, `avatar`, `qq`, `vip`, `gender`, `birthyear`, `birthmonth`, `birthday`, `constellation`, `zodiac`, `telephone`, `idcard`, `studentid`, `grade`, `address`, `zipcode`, `nationality`, `resideprovince`, `residecity`, `residedist`, `graduateschool`, `company`, `education`, `occupation`, `position`, `revenue`, `affectivestatus`, `lookingfor`, `bloodtype`, `height`, `weight`, `alipay`, `msn`, `taobao`, `site`, `bio`, `interest`) VALUES
(21, 1, 'test_2', '2f5d1d864147d3cb5743942acde161e1', '', 49, '13232456542', '', 'Ll11bBGL', 1, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1491471291, '', '', '', 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
(16, 1, 'luoshui', 'cfec64530d11ab1362b24d2a409f30cb', '', 47, '18818888852', '', 'DPnbV4fn', 1, '66666.00', '666666.00', '0.00', '0.00', '0.00', '0.00', 1490702866, '', '', '', 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
(13, 1, 'kobe_test', 'e38965cbf7b254e30aa4409e012ab247', '', 28, '18589003355', '', 'R1CkTDJl', 1, '10000.00', '10000.00', '0.00', '0.00', '0.00', '0.00', 1489625116, '', '', '', 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
(20, 1, 'test_1', '9e39abb9deca404515745ae52cff2fa8', '', 47, '13254127412', '', 'H781T39N', 1, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1491213756, '', '', '', 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
(19, 1, 'ceshi', '9848564f904bc8f2cb120d6774416afc', '', 52, '13674121234', '', 'LI7lN07S', 1, '0.00', '1000.00', '0.00', '0.00', '0.00', '0.00', 1491200067, '', '', '', 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
(11, 1, 'gangan', '29004f771d1da9fd246852b78179ca24', 'gan888888', 28, '15815599951', '88888888@qq.com', 'qT6npnb3', 2, '10.00', '1000.00', '0.00', '0.00', '0.00', '100.00', 1485163472, '', '', '', 0, 0, 1980, 0, 0, '水瓶座', '鼠', '', '', '', '', '', '', '', '', '', '', '', '', '博士', '', '', '', '', '', 'A', '', '', '', '', '', '', '', ''),
(18, 1, 'zhang', 'aa7f099f237b89d65163ae9aff21e545', '', 49, '18688866686', '', 'TrO2wIlU', 1, '0.00', '888.00', '0.00', '0.00', '0.00', '0.00', 1491010788, '', '', '', 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_member_address`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_member_address` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(50) unsigned NOT NULL,
  `username` varchar(20) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `zipcode` varchar(6) NOT NULL,
  `province` varchar(32) NOT NULL,
  `city` varchar(32) NOT NULL,
  `district` varchar(32) NOT NULL,
  `address` varchar(512) NOT NULL,
  `isdefault` tinyint(1) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_mc_member_address`
--

INSERT INTO `sltx_mc_member_address` (`id`, `uniacid`, `uid`, `username`, `mobile`, `zipcode`, `province`, `city`, `district`, `address`, `isdefault`) VALUES
(1, 1, 1, '乖乖', '15815599951', '518000', '广东省', '深圳市', '南山区', '乖乖', 1),
(2, 1, 11, '乖乖', '15815500000', '518000', '广东省', '深圳市', '南山区', '顶顶顶顶顶等等', 1);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_member_fields`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_member_fields` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) NOT NULL,
  `fieldid` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `displayorder` smallint(6) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_mc_member_fields`
--

INSERT INTO `sltx_mc_member_fields` (`id`, `uniacid`, `fieldid`, `title`, `available`, `displayorder`) VALUES
(1, 1, 1, '真实姓名', 1, 0),
(2, 1, 2, '昵称', 1, 1),
(3, 1, 3, '头像', 1, 1),
(4, 1, 4, 'QQ号', 1, 0),
(5, 1, 5, '手机号码', 1, 0),
(6, 1, 6, 'VIP级别', 1, 0),
(7, 1, 7, '性别', 1, 0),
(8, 1, 8, '出生生日', 1, 0),
(9, 1, 9, '星座', 1, 0),
(10, 1, 10, '生肖', 1, 0),
(11, 1, 11, '固定电话', 1, 0),
(12, 1, 12, '证件号码', 1, 0),
(13, 1, 13, '学号', 1, 0),
(14, 1, 14, '班级', 1, 0),
(15, 1, 15, '邮寄地址', 1, 0),
(16, 1, 16, '邮编', 1, 0),
(17, 1, 17, '国籍', 1, 0),
(18, 1, 18, '居住地址', 1, 0),
(19, 1, 19, '毕业学校', 1, 0),
(20, 1, 20, '公司', 1, 0),
(21, 1, 21, '学历', 1, 0),
(22, 1, 22, '职业', 1, 0),
(23, 1, 23, '职位', 1, 0),
(24, 1, 24, '年收入', 1, 0),
(25, 1, 25, '情感状态', 1, 0),
(26, 1, 26, ' 交友目的', 1, 0),
(27, 1, 27, '血型', 1, 0),
(28, 1, 28, '身高', 1, 0),
(29, 1, 29, '体重', 1, 0),
(30, 1, 30, '支付宝帐号', 1, 0),
(31, 1, 31, 'MSN', 1, 0),
(32, 1, 32, '电子邮箱', 1, 0),
(33, 1, 33, '阿里旺旺', 1, 0),
(34, 1, 34, '主页', 1, 0),
(35, 1, 35, '自我介绍', 1, 0),
(36, 1, 36, '兴趣爱好', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_member_property`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_member_property` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(11) NOT NULL,
  `property` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mc_oauth_fans`
--

CREATE TABLE IF NOT EXISTS `sltx_mc_oauth_fans` (
  `id` int(10) unsigned NOT NULL,
  `oauth_openid` varchar(50) NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `openid` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_menu_event`
--

CREATE TABLE IF NOT EXISTS `sltx_menu_event` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `keyword` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `picmd5` varchar(32) NOT NULL,
  `openid` varchar(128) NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_mobilenumber`
--

CREATE TABLE IF NOT EXISTS `sltx_mobilenumber` (
  `id` int(11) NOT NULL,
  `rid` int(10) NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL,
  `dateline` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_modules`
--

CREATE TABLE IF NOT EXISTS `sltx_modules` (
  `mid` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `version` varchar(10) NOT NULL,
  `ability` varchar(500) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `author` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `settings` tinyint(1) NOT NULL,
  `subscribes` varchar(500) NOT NULL,
  `handles` varchar(500) NOT NULL,
  `isrulefields` tinyint(1) NOT NULL,
  `issystem` tinyint(1) unsigned NOT NULL,
  `target` int(10) unsigned NOT NULL,
  `iscard` tinyint(3) unsigned NOT NULL,
  `permissions` varchar(5000) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_modules`
--

INSERT INTO `sltx_modules` (`mid`, `name`, `type`, `title`, `version`, `ability`, `description`, `author`, `url`, `settings`, `subscribes`, `handles`, `isrulefields`, `issystem`, `target`, `iscard`, `permissions`) VALUES
(1, 'basic', 'system', '基本文字回复', '1.0', '和您进行简单对话', '一问一答得简单对话. 当访客的对话语句中包含指定关键字, 或对话语句完全等于特定关键字, 或符合某些特定的格式时. 系统自动应答设定好的回复内容.', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(2, 'news', 'system', '基本混合图文回复', '1.0', '为你提供生动的图文资讯', '一问一答得简单对话, 但是回复内容包括图片文字等更生动的媒体内容. 当访客的对话语句中包含指定关键字, 或对话语句完全等于特定关键字, 或符合某些特定的格式时. 系统自动应答设定好的图文回复内容.', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(3, 'music', 'system', '基本音乐回复', '1.0', '提供语音、音乐等音频类回复', '在回复规则中可选择具有语音、音乐等音频类的回复内容，并根据用户所设置的特定关键字精准的返回给粉丝，实现一问一答得简单对话。', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(4, 'userapi', 'system', '自定义接口回复', '1.1', '更方便的第三方接口设置', '自定义接口又称第三方接口，可以让开发者更方便的接入微擎系统，高效的与微信公众平台进行对接整合。', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(5, 'recharge', 'system', '会员中心充值模块', '1.0', '提供会员充值功能', '', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 0, 1, 0, 0, ''),
(6, 'custom', 'system', '多客服转接', '1.0.0', '用来接入腾讯的多客服系统', '', 'WeEngine Team', 'http://bbs.we7.cc', 0, 'a:0:{}', 'a:6:{i:0;s:5:"image";i:1;s:5:"voice";i:2;s:5:"video";i:3;s:8:"location";i:4;s:4:"link";i:5;s:4:"text";}', 1, 1, 0, 0, ''),
(7, 'images', 'system', '基本图片回复', '1.0', '提供图片回复', '在回复规则中可选择具有图片的回复内容，并根据用户所设置的特定关键字精准的返回给粉丝图片。', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(8, 'video', 'system', '基本视频回复', '1.0', '提供图片回复', '在回复规则中可选择具有视频的回复内容，并根据用户所设置的特定关键字精准的返回给粉丝视频。', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(9, 'voice', 'system', '基本语音回复', '1.0', '提供语音回复', '在回复规则中可选择具有语音的回复内容，并根据用户所设置的特定关键字精准的返回给粉丝语音。', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(10, 'chats', 'system', '发送客服消息', '1.0', '公众号可以在粉丝最后发送消息的48小时内无限制发送消息', '', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 0, 1, 0, 0, ''),
(11, 'wxcard', 'system', '微信卡券回复', '1.0', '微信卡券回复', '微信卡券回复', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(12, 'paycenter', 'system', '收银台', '1.0', '收银台', '收银台', 'WeEngine Team', 'http://www.we7.cc/', 0, '', '', 1, 1, 0, 0, ''),
(24, 'xsy_resource', 'services', '脚本管理', '1.0', '脚本管理器', '脚本管理器', 'gg', 'http://bbs.yinke.cc/', 0, 'a:0:{}', 'a:0:{}', 0, 0, 0, 0, 'a:0:{}');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_modules_bindings`
--

CREATE TABLE IF NOT EXISTS `sltx_modules_bindings` (
  `eid` int(11) NOT NULL,
  `module` varchar(30) NOT NULL,
  `entry` varchar(10) NOT NULL,
  `call` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `do` varchar(30) NOT NULL,
  `state` varchar(200) NOT NULL,
  `direct` int(11) NOT NULL,
  `url` varchar(100) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `displayorder` tinyint(255) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_modules_bindings`
--

INSERT INTO `sltx_modules_bindings` (`eid`, `module`, `entry`, `call`, `title`, `do`, `state`, `direct`, `url`, `icon`, `displayorder`) VALUES
(39, 'xsy_resource', 'menu', '', '脚本管理', 'manager', '', 0, '', '', 0),
(38, 'xsy_resource', 'cover', '', '入口', 'index', '', 0, '', '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_modules_recycle`
--

CREATE TABLE IF NOT EXISTS `sltx_modules_recycle` (
  `id` int(10) NOT NULL,
  `modulename` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_modules_recycle`
--

INSERT INTO `sltx_modules_recycle` (`id`, `modulename`) VALUES
(1, 'we7_coupon');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_ms_alive_table`
--

CREATE TABLE IF NOT EXISTS `sltx_ms_alive_table` (
  `id` int(11) NOT NULL,
  `account` char(64) NOT NULL,
  `ms_id` char(64) NOT NULL,
  `ms_type` char(32) NOT NULL,
  `strategy_id` int(11) NOT NULL,
  `running_script_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `error_info` text CHARACTER SET utf8 NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `sltx_ms_alive_table`
--

INSERT INTO `sltx_ms_alive_table` (`id`, `account`, `ms_id`, `ms_type`, `strategy_id`, `running_script_id`, `time`, `error_info`, `user_id`) VALUES
(11, 'kobe_test', 'WXKJ2QU9IPAD', 'ip5', 28, 34, 1490779705, '', 13),
(12, 'ceshi', '83128K9SDZZ', 'ip4', 52, 281, 1491786612, '', 16),
(13, 'ceshi', '841288W1DZZ', 'ip4', 52, 317, 1491786543, '', 16),
(14, 'ceshi', '87123DSHDZZ', 'ip4', 52, 317, 1491786575, '', 16),
(15, 'ceshi', '5K3393YUA4S', 'ip4', 52, 331, 1491789131, '', 16),
(16, 'ceshi', '87043YKWA4S', 'ip4', 52, 332, 1491789151, '', 16),
(17, 'zhang', 'DX3KLF8TDP0N', 'ip4', 49, 317, 1491788661, '', 18),
(18, 'zhang', '5K120D1JA4S', 'ip4', 49, 317, 1491788757, '', 18),
(19, 'zhang', '880331BEA4S', 'ip4', 49, 317, 1491788520, '', 18),
(20, 'zhang', '850328XSA4S', 'ip4', 49, 317, 1491788554, '', 18),
(21, 'zhang', '84115ZWPA4S', 'ip4', 49, 317, 1491788500, '', 18),
(22, 'test_2', '871264KPA4T', 'ip4', 49, 317, 1491785699, '', 20),
(23, 'test_2', 'DNQH2AJSDP0N', 'ip4', 49, 281, 1491785507, '', 21),
(24, 'test_2', '82121H5KA4S', 'ip4', 49, 281, 1491785660, '', 21),
(25, 'test_2', '87134FWQDZZ', 'ip4', 49, 281, 1491788250, '', 21),
(26, 'test_2', 'C39GP0QCDPMW', 'ip4', 49, 317, 1491785840, '', 21),
(27, 'test_2', '7T1218NGDZZ', 'ip4', 49, 317, 1491786265, '', 21),
(28, 'test_2', 'DX5JLRNMDP0N', 'ip4', 49, 317, 1491787326, '', 21),
(29, 'test_2', 'DX6JFVMXDP0N', 'ip4', 49, 326, 1491744792, '', 21),
(30, 'test_2', '88123UKJA4T', 'ip4', 49, 317, 1491787373, '', 21),
(31, 'test_2', 'C38H1ACADPMW', 'ip4', 49, 317, 1491787282, '', 21),
(32, 'test_2', 'DNRGRWY2DP0N', 'ip4', 49, 317, 1491787774, '', 21),
(33, 'test_2', '841382H9DZZ', 'ip4', 49, 317, 1491787555, '', 21),
(34, 'test_2', 'QR137BS8A4S', 'ip4', 49, 317, 1491787710, '', 21),
(35, 'test_2', 'C38GXXN0DPMW', 'ip4', 49, 317, 1491788595, '', 21),
(36, 'test_2', 'DX7L6B5YDP0N', 'ip4', 49, 317, 1491788448, '', 21),
(37, 'test_2', 'C7GJK00QDPMW', 'ip4', 49, 317, 1491787520, '', 21);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_ms_allot_table`
--

CREATE TABLE IF NOT EXISTS `sltx_ms_allot_table` (
  `id` int(11) NOT NULL,
  `ms_id` char(64) NOT NULL COMMENT '序列号',
  `task_list` text NOT NULL,
  `ms_task_index` int(11) NOT NULL COMMENT '当前任务id',
  `time` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1449 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `sltx_ms_allot_table`
--

INSERT INTO `sltx_ms_allot_table` (`id`, `ms_id`, `task_list`, `ms_task_index`, `time`) VALUES
(1371, '841288W1DZZ', '[{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491726783},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491726808},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491726852},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491726894},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491726919},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491726968},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727002},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727027},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727072},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727097},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727141},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727166},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727204},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727229},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727268},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727312},{"id":"507","task_id":"331","task_d_id":"296","task_time":"20","task_num":"1","task_pri":"1","strategy_id":"52","time":1491727340},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727374},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727404},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727447},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727472},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727517},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727542},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727587},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727612},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727659},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727692},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727718},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727747},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727789},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491727814},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491727848},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491727902},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491727932},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491727954},{"id":"513","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491728013},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491728063},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491728180},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491728280},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491728306},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491728344},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491728386},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491728432},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491728445},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491728450},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491728501},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491728553},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491728587},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491728644},{"id":"517","task_id":"331","task_d_id":"306","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491728679},{"id":"512","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491728741},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491728791},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491728835},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491728887},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491729008},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491729038},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491729057},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491729107},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491729147},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491729247},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491729289},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491729305},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491729319},{"id":"511","task_id":"331","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"3","strategy_id":"52","time":1491729377},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491729627},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491729650},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491729693},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491729728},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491729743},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491729788},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491729847},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491729887},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491729930},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491729935},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491729958},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491730017},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491730056},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491730091},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491730144},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491730245},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491730360},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491730401},{"id":"524","task_id":"331","task_d_id":"295","task_time":"600","task_num":"1","task_pri":"5","strategy_id":"52","time":1491730423},{"id":"529","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"6","strategy_id":"52","time":1491731023},{"id":"528","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"52","time":1491738236}]', 84, 0),
(1396, 'DX6JFVMXDP0N', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491744792},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491744842},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491748442},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491748492},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491752092},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491752142},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491755742},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491755792},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491759392},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491759442},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491766642}]', 0, 0),
(1423, 'DNQH2AJSDP0N', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491770604},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491770654},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491774254},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491774304},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491777904},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491777954},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491781554},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491781604},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491785204},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491785254},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491785504}]', 10, 0),
(1424, '82121H5KA4S', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491771007},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491771057},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491774657},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491774707},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491778307},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491778357},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491781957},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491782007},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491785607},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491785657},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792857}]', 9, 0),
(1427, '87134FWQDZZ', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491773598},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491773648},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491777248},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491777298},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491780898},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491780948},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491784548},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491784598},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491788198},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491788248},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491795448}]', 9, 0),
(1428, 'C39GP0QCDPMW', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491774836},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491774886},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491778486},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491778536},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491782136},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491782186},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491785786},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491785836},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491789436},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491789486},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491789736}]', 7, 0),
(1429, 'C38H1ACADPMW', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491776277},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491776327},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491779927},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491779977},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491783577},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491783627},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491787227},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491787277},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491790877},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491790927},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491798127}]', 7, 0),
(1430, 'DX5JLRNMDP0N', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491776322},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491776372},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491779972},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491780022},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491783622},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491783672},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491787272},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491787322},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491790922},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491790972},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491798172}]', 7, 0),
(1431, '88123UKJA4T', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491776372},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491776422},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491780022},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491780072},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491783672},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491783722},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491787322},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491787372},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491790972},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791022},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791272}]', 7, 0),
(1432, 'C7GJK00QDPMW', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491776519},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491776569},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491780169},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491780219},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491783819},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491783869},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491787469},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491787519},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491791119},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791169},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791419}]', 7, 0),
(1433, '841382H9DZZ', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491776550},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491776600},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491780200},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491780250},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491783850},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491783900},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491787500},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491787550},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491791150},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791200},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791450}]', 7, 0),
(1434, 'DNRGRWY2DP0N', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491776770},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491776820},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491780420},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491780470},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491784070},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491784120},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491787720},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491787770},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491791370},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791420},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491791670}]', 7, 0),
(1435, 'DX7L6B5YDP0N', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491777445},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491777495},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781095},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491781145},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491784745},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491784795},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491788395},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491788445},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792045},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792095},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792345}]', 7, 0),
(1436, '880331BEA4S', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491777497},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491777547},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781147},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491781197},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491784797},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491784847},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491788447},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491788497},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792097},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792147},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792397}]', 7, 0),
(1437, '84115ZWPA4S', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491777499},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491777549},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781149},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491781199},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491784799},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491784849},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491788449},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491788499},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792099},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792149},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491799349}]', 7, 0),
(1438, '850328XSA4S', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491777549},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491777599},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781199},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491781249},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491784849},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491784899},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491788499},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491788549},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792149},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792199},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792449}]', 7, 0),
(1439, 'C38GXXN0DPMW', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491777593},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491777643},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781243},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491781293},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491784893},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491784943},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491788543},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491788593},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792193},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792243},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491799443}]', 7, 0),
(1440, 'DX3KLF8TDP0N', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491777660},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491777710},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781310},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491781360},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491784960},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491785010},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491788610},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491788660},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792260},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792310},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792560}]', 7, 0),
(1441, '5K120D1JA4S', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491777731},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491777781},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781381},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491781431},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491785031},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491785081},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491788681},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491788731},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792331},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792381},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792631}]', 7, 0),
(1442, '871264KPA4T', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491778348},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491778398},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491781998},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491782048},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491785648},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491785698},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491789298},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491789348},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491792948},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491792998},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491800198}]', 5, 0);
INSERT INTO `sltx_ms_allot_table` (`id`, `ms_id`, `task_list`, `ms_task_index`, `time`) VALUES
(1443, '87123DSHDZZ', '[{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779101},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779126},{"id":"507","task_id":"331","task_d_id":"296","task_time":"20","task_num":"1","task_pri":"1","strategy_id":"52","time":1491779159},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779197},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779231},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779256},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779297},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779331},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779365},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779404},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779438},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779469},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779494},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779528},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779570},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779595},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779629},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779671},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779717},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779744},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779770},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779817},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779842},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779879},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779917},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779945},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491779982},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780027},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780052},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780089},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780138},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491780163},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491780269},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491780282},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491780341},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491780381},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491780418},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491780454},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491780501},{"id":"513","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491780545},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491780606},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491780641},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491780692},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491780699},{"id":"512","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491780745},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491780809},{"id":"517","task_id":"331","task_d_id":"306","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491780820},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491780882},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491780924},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491781035},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491781046},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491781095},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491781130},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491781184},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491781192},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491781297},{"id":"511","task_id":"331","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"3","strategy_id":"52","time":1491781343},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491781599},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491781645},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491781653},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491781658},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491781773},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491781832},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491781873},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491781911},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491781924},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491781960},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491782010},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491782029},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491782039},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491782080},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491782101},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491782144},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491782179},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491782193},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491782238},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491782290},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491782344},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491782444},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491782550},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491782600},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491782635},{"id":"524","task_id":"331","task_d_id":"295","task_time":"600","task_num":"1","task_pri":"5","strategy_id":"52","time":1491782691},{"id":"528","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"52","time":1491783297},{"id":"529","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"6","strategy_id":"52","time":1491786907}]', 83, 0),
(1444, '83128K9SDZZ', '[{"id":"507","task_id":"331","task_d_id":"296","task_time":"20","task_num":"1","task_pri":"1","strategy_id":"52","time":1491780356},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780376},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780410},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780459},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780484},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780533},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780561},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780602},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780628},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780674},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780704},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780730},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780777},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780802},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780847},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780872},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780919},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780950},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491780981},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781006},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781047},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781072},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781117},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781164},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781195},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781220},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781256},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781284},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781323},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781348},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491781386},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491781422},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491781468},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491781516},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491781551},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491781567},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491781680},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491781800},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491781834},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491781855},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491781891},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491781910},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491781945},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491781993},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491782047},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491782090},{"id":"513","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491782129},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491782196},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491782236},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491782266},{"id":"517","task_id":"331","task_d_id":"306","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491782324},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491782374},{"id":"512","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491782395},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491782449},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491782464},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491782512},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491782620},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491782655},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491782682},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491782687},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491782732},{"id":"511","task_id":"331","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"3","strategy_id":"52","time":1491782842},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491783107},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491783145},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491783189},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783196},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491783251},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491783290},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491783390},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491783440},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783489},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491783528},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491783583},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783620},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491783634},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491783734},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491783785},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783838},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783851},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783856},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783900},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491783927},{"id":"524","task_id":"331","task_d_id":"295","task_time":"600","task_num":"1","task_pri":"5","strategy_id":"52","time":1491783962},{"id":"529","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"6","strategy_id":"52","time":1491784578},{"id":"528","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"52","time":1491791779}]', 83, 0),
(1445, 'QR137BS8A4S', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491780358},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491780408},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491784008},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491784058},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491787658},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491787708},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491791308},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491791358},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491794958},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491795008},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491802208}]', 5, 0),
(1446, '7T1218NGDZZ', '[{"id":"476","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"1","strategy_id":"49","time":1491782492},{"id":"471","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"2","strategy_id":"49","time":1491782542},{"id":"477","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"3","strategy_id":"49","time":1491786142},{"id":"472","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"4","strategy_id":"49","time":1491786192},{"id":"478","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"5","strategy_id":"49","time":1491789792},{"id":"473","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"49","time":1491789842},{"id":"479","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"7","strategy_id":"49","time":1491793442},{"id":"474","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"8","strategy_id":"49","time":1491793492},{"id":"480","task_id":"326","task_d_id":"330","task_time":"50","task_num":"1","task_pri":"9","strategy_id":"49","time":1491797092},{"id":"481","task_id":"326","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"10","strategy_id":"49","time":1491797142},{"id":"475","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"10","strategy_id":"49","time":1491797392}]', 3, 0),
(1447, '5K3393YUA4S', '[{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787036},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787061},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787086},{"id":"507","task_id":"331","task_d_id":"296","task_time":"20","task_num":"1","task_pri":"1","strategy_id":"52","time":1491787126},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787146},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787195},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787220},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787266},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787293},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787318},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787357},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787396},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787444},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787473},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787504},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787532},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787581},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787606},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787647},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787672},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787709},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787758},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787787},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787820},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787845},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787890},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787930},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787955},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787996},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491788030},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491788057},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788094},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491788151},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491788254},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788288},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788334},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788372},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491788429},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788443},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491788478},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491788505},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788605},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788656},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788697},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491788756},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788786},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788821},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788880},{"id":"512","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491788915},{"id":"513","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491788988},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491789038},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491789061},{"id":"517","task_id":"331","task_d_id":"306","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491789073},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491789129},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789166},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789219},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789226},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789256},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789366},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789395},{"id":"511","task_id":"331","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"3","strategy_id":"52","time":1491789400},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789668},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789768},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491789782},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491789829},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491789886},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491789891},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491790013},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790052},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491790087},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491790210},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790247},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790268},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790303},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790352},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790402},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790440},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790496},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790531},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790574},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790583},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790635},{"id":"524","task_id":"331","task_d_id":"295","task_time":"600","task_num":"1","task_pri":"5","strategy_id":"52","time":1491790642},{"id":"528","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"52","time":1491791259},{"id":"529","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"6","strategy_id":"52","time":1491794859}]', 53, 0),
(1448, '87043YKWA4S', '[{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787090},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787115},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787140},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787179},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787213},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787246},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787271},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787312},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787352},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787380},{"id":"507","task_id":"331","task_d_id":"296","task_time":"20","task_num":"1","task_pri":"1","strategy_id":"52","time":1491787416},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787455},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787488},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787513},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787560},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787585},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787624},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787655},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787694},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787726},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787758},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787797},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787827},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787870},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787903},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787932},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491787957},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491788004},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491788029},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491788063},{"id":"506","task_id":"331","task_d_id":"294","task_time":"25","task_num":"30","task_pri":"1","strategy_id":"52","time":1491788104},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491788142},{"id":"512","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491788154},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788211},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788264},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491788305},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491788411},{"id":"514","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"2","strategy_id":"52","time":1491788420},{"id":"517","task_id":"331","task_d_id":"306","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491788532},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788582},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491788630},{"id":"513","task_id":"331","task_d_id":"304","task_time":"50","task_num":"1","task_pri":"2","strategy_id":"52","time":1491788674},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788744},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788779},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788830},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491788870},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788878},{"id":"508","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491788934},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491788971},{"id":"520","task_id":"331","task_d_id":"302","task_time":"35","task_num":"3","task_pri":"2","strategy_id":"52","time":1491789028},{"id":"522","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"2","strategy_id":"52","time":1491789067},{"id":"518","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"2","strategy_id":"52","time":1491789102},{"id":"525","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"2","strategy_id":"52","time":1491789145},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789150},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491789166},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789212},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491789226},{"id":"511","task_id":"331","task_d_id":"307","task_time":"250","task_num":"1","task_pri":"3","strategy_id":"52","time":1491789278},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789528},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789568},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789591},{"id":"519","task_id":"331","task_d_id":"305","task_time":"30","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789699},{"id":"515","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"3","strategy_id":"52","time":1491789744},{"id":"526","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"3","strategy_id":"52","time":1491789844},{"id":"509","task_id":"331","task_d_id":"308","task_time":"35","task_num":"3","task_pri":"3","strategy_id":"52","time":1491789863},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491789907},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790007},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790022},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790076},{"id":"516","task_id":"331","task_d_id":"327","task_time":"100","task_num":"2","task_pri":"4","strategy_id":"52","time":1491790126},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790226},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790254},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790265},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790300},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790345},{"id":"527","task_id":"332","task_d_id":"0","task_time":"5","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790392},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790419},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491790458},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790493},{"id":"521","task_id":"331","task_d_id":"302","task_time":"35","task_num":"2","task_pri":"4","strategy_id":"52","time":1491790542},{"id":"523","task_id":"331","task_d_id":"303","task_time":"35","task_num":"5","task_pri":"4","strategy_id":"52","time":1491790595},{"id":"510","task_id":"331","task_d_id":"308","task_time":"35","task_num":"4","task_pri":"4","strategy_id":"52","time":1491790635},{"id":"524","task_id":"331","task_d_id":"295","task_time":"600","task_num":"1","task_pri":"5","strategy_id":"52","time":1491790690},{"id":"529","task_id":"281","task_d_id":"0","task_time":"7200","task_num":"1","task_pri":"6","strategy_id":"52","time":1491791297},{"id":"528","task_id":"317","task_d_id":"0","task_time":"3600","task_num":"1","task_pri":"6","strategy_id":"52","time":1491798497}]', 53, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_ms_setting`
--

CREATE TABLE IF NOT EXISTS `sltx_ms_setting` (
  `id` int(11) NOT NULL,
  `close` int(11) NOT NULL COMMENT '网站维护中：1开启，0关闭'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `sltx_ms_setting`
--

INSERT INTO `sltx_ms_setting` (`id`, `close`) VALUES
(1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_ms_strategy`
--

CREATE TABLE IF NOT EXISTS `sltx_ms_strategy` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `owner` int(11) NOT NULL,
  `full_time` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  `is_ramd` int(11) NOT NULL,
  `idle` int(11) DEFAULT NULL,
  `info` varchar(255) CHARACTER SET utf8 NOT NULL,
  `temple_name` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '对应的模版名称'
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `sltx_ms_strategy`
--

INSERT INTO `sltx_ms_strategy` (`id`, `name`, `owner`, `full_time`, `cost`, `is_ramd`, `idle`, `info`, `temple_name`) VALUES
(28, 'kobe测试服务器', 2, 600, 1, 1, 64, '无', '242'),
(38, 'test', 1, 44, 22, 1, 64, '乖乖', '254'),
(49, '微信养号', 2, 22100, 100, 1, 64, '1小时回复一次 一天转发3次朋友圈', ''),
(51, '删除文件夹', 2, 100, 111, 1, 64, '删除文件夹', ''),
(52, '微信加粉', 2, 15000, 88, 1, 64, '一天运行5次', '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_ms_strategy_task_list`
--

CREATE TABLE IF NOT EXISTS `sltx_ms_strategy_task_list` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `task_d_id` int(11) NOT NULL,
  `task_time` int(11) NOT NULL,
  `task_num` int(11) NOT NULL,
  `task_pri` int(11) NOT NULL,
  `strategy_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=530 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `sltx_ms_strategy_task_list`
--

INSERT INTO `sltx_ms_strategy_task_list` (`id`, `task_id`, `task_d_id`, `task_time`, `task_num`, `task_pri`, `strategy_id`) VALUES
(61, 34, 35, 10, 43, 1, 28),
(83, 262, 272, 3, 3, 3, 38),
(442, 329, 0, 100, 1, 1, 51),
(471, 317, 0, 3600, 1, 2, 49),
(472, 317, 0, 3600, 1, 4, 49),
(473, 317, 0, 3600, 1, 6, 49),
(474, 317, 0, 3600, 1, 8, 49),
(475, 281, 0, 7200, 1, 10, 49),
(476, 326, 330, 50, 1, 1, 49),
(477, 326, 330, 50, 1, 3, 49),
(478, 326, 330, 50, 1, 5, 49),
(479, 326, 330, 50, 1, 7, 49),
(480, 326, 330, 50, 1, 9, 49),
(481, 326, 307, 250, 1, 10, 49),
(506, 331, 294, 25, 30, 1, 52),
(507, 331, 296, 20, 1, 1, 52),
(508, 331, 308, 35, 3, 2, 52),
(509, 331, 308, 35, 3, 3, 52),
(510, 331, 308, 35, 4, 4, 52),
(511, 331, 307, 250, 1, 3, 52),
(512, 331, 304, 50, 1, 2, 52),
(513, 331, 304, 50, 1, 2, 52),
(514, 331, 327, 100, 2, 2, 52),
(515, 331, 327, 100, 2, 3, 52),
(516, 331, 327, 100, 2, 4, 52),
(517, 331, 306, 50, 1, 2, 52),
(518, 331, 305, 30, 2, 2, 52),
(519, 331, 305, 30, 2, 3, 52),
(520, 331, 302, 35, 3, 2, 52),
(521, 331, 302, 35, 2, 4, 52),
(522, 331, 303, 35, 5, 2, 52),
(523, 331, 303, 35, 5, 4, 52),
(524, 331, 295, 600, 1, 5, 52),
(525, 332, 0, 5, 4, 2, 52),
(526, 332, 0, 5, 4, 3, 52),
(527, 332, 0, 5, 4, 4, 52),
(528, 317, 0, 3600, 1, 6, 52),
(529, 281, 0, 7200, 1, 6, 52);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_music_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_music_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `url` varchar(300) NOT NULL,
  `hqurl` varchar(300) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_news_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_news_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `parent_id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  `url` varchar(255) NOT NULL,
  `displayorder` int(10) NOT NULL,
  `incontent` tinyint(1) NOT NULL,
  `createtime` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_paycenter_order`
--

CREATE TABLE IF NOT EXISTS `sltx_paycenter_order` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `pid` int(10) unsigned NOT NULL,
  `clerk_id` int(10) unsigned NOT NULL,
  `store_id` int(10) unsigned NOT NULL,
  `clerk_type` tinyint(3) unsigned NOT NULL,
  `uniontid` varchar(40) NOT NULL,
  `transaction_id` varchar(40) NOT NULL,
  `type` varchar(10) NOT NULL,
  `trade_type` varchar(10) NOT NULL,
  `body` varchar(255) NOT NULL,
  `fee` varchar(15) NOT NULL,
  `final_fee` decimal(10,2) unsigned NOT NULL,
  `credit1` int(10) unsigned NOT NULL,
  `credit1_fee` decimal(10,2) unsigned NOT NULL,
  `credit2` decimal(10,2) unsigned NOT NULL,
  `cash` decimal(10,2) unsigned NOT NULL,
  `remark` varchar(255) NOT NULL,
  `auth_code` varchar(30) NOT NULL,
  `openid` varchar(50) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `follow` tinyint(3) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `credit_status` tinyint(3) unsigned NOT NULL,
  `paytime` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_profile_fields`
--

CREATE TABLE IF NOT EXISTS `sltx_profile_fields` (
  `id` int(10) unsigned NOT NULL,
  `field` varchar(255) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `displayorder` smallint(6) NOT NULL,
  `required` tinyint(1) NOT NULL,
  `unchangeable` tinyint(1) NOT NULL,
  `showinregister` tinyint(1) NOT NULL,
  `field_length` int(10) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_profile_fields`
--

INSERT INTO `sltx_profile_fields` (`id`, `field`, `available`, `title`, `description`, `displayorder`, `required`, `unchangeable`, `showinregister`, `field_length`) VALUES
(1, 'realname', 1, '真实姓名', '', 0, 1, 1, 1, 0),
(2, 'nickname', 1, '昵称', '', 1, 1, 0, 1, 0),
(3, 'avatar', 1, '头像', '', 1, 0, 0, 0, 0),
(4, 'qq', 1, 'QQ号', '', 0, 0, 0, 1, 0),
(5, 'mobile', 1, '手机号码', '', 0, 0, 0, 0, 0),
(6, 'vip', 1, 'VIP级别', '', 0, 0, 0, 0, 0),
(7, 'gender', 1, '性别', '', 0, 0, 0, 0, 0),
(8, 'birthyear', 1, '出生生日', '', 0, 0, 0, 0, 0),
(9, 'constellation', 1, '星座', '', 0, 0, 0, 0, 0),
(10, 'zodiac', 1, '生肖', '', 0, 0, 0, 0, 0),
(11, 'telephone', 1, '固定电话', '', 0, 0, 0, 0, 0),
(12, 'idcard', 1, '证件号码', '', 0, 0, 0, 0, 0),
(13, 'studentid', 1, '学号', '', 0, 0, 0, 0, 0),
(14, 'grade', 1, '班级', '', 0, 0, 0, 0, 0),
(15, 'address', 1, '邮寄地址', '', 0, 0, 0, 0, 0),
(16, 'zipcode', 1, '邮编', '', 0, 0, 0, 0, 0),
(17, 'nationality', 1, '国籍', '', 0, 0, 0, 0, 0),
(18, 'resideprovince', 1, '居住地址', '', 0, 0, 0, 0, 0),
(19, 'graduateschool', 1, '毕业学校', '', 0, 0, 0, 0, 0),
(20, 'company', 1, '公司', '', 0, 0, 0, 0, 0),
(21, 'education', 1, '学历', '', 0, 0, 0, 0, 0),
(22, 'occupation', 1, '职业', '', 0, 0, 0, 0, 0),
(23, 'position', 1, '职位', '', 0, 0, 0, 0, 0),
(24, 'revenue', 1, '年收入', '', 0, 0, 0, 0, 0),
(25, 'affectivestatus', 1, '情感状态', '', 0, 0, 0, 0, 0),
(26, 'lookingfor', 1, ' 交友目的', '', 0, 0, 0, 0, 0),
(27, 'bloodtype', 1, '血型', '', 0, 0, 0, 0, 0),
(28, 'height', 1, '身高', '', 0, 0, 0, 0, 0),
(29, 'weight', 1, '体重', '', 0, 0, 0, 0, 0),
(30, 'alipay', 1, '支付宝帐号', '', 0, 0, 0, 0, 0),
(31, 'msn', 1, 'MSN', '', 0, 0, 0, 0, 0),
(32, 'email', 1, '电子邮箱', '', 0, 0, 0, 0, 0),
(33, 'taobao', 1, '阿里旺旺', '', 0, 0, 0, 0, 0),
(34, 'site', 1, '主页', '', 0, 0, 0, 0, 0),
(35, 'bio', 1, '自我介绍', '', 0, 0, 0, 0, 0),
(36, 'interest', 1, '兴趣爱好', '', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_qrcode`
--

CREATE TABLE IF NOT EXISTS `sltx_qrcode` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `type` varchar(10) NOT NULL,
  `extra` int(10) unsigned NOT NULL,
  `qrcid` bigint(20) NOT NULL,
  `scene_str` varchar(64) NOT NULL,
  `name` varchar(50) NOT NULL,
  `keyword` varchar(100) NOT NULL,
  `model` tinyint(1) unsigned NOT NULL,
  `ticket` varchar(250) NOT NULL,
  `url` varchar(256) NOT NULL,
  `expire` int(10) unsigned NOT NULL,
  `subnum` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_qrcode_stat`
--

CREATE TABLE IF NOT EXISTS `sltx_qrcode_stat` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `qid` int(10) unsigned NOT NULL,
  `openid` varchar(50) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL,
  `qrcid` bigint(20) unsigned NOT NULL,
  `scene_str` varchar(64) NOT NULL,
  `name` varchar(50) NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_rule`
--

CREATE TABLE IF NOT EXISTS `sltx_rule` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `module` varchar(50) NOT NULL,
  `displayorder` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_rule`
--

INSERT INTO `sltx_rule` (`id`, `uniacid`, `name`, `module`, `displayorder`, `status`) VALUES
(1, 0, '城市天气', 'userapi', 255, 1),
(2, 0, '百度百科', 'userapi', 255, 1),
(3, 0, '即时翻译', 'userapi', 255, 1),
(4, 0, '今日老黄历', 'userapi', 255, 1),
(5, 0, '看新闻', 'userapi', 255, 1),
(6, 0, '快递查询', 'userapi', 255, 1),
(7, 1, '个人中心入口设置', 'cover', 0, 1),
(8, 1, '微擎团队入口设置', 'cover', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_rule_keyword`
--

CREATE TABLE IF NOT EXISTS `sltx_rule_keyword` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `module` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL,
  `displayorder` tinyint(3) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_rule_keyword`
--

INSERT INTO `sltx_rule_keyword` (`id`, `rid`, `uniacid`, `module`, `content`, `type`, `displayorder`, `status`) VALUES
(1, 1, 0, 'userapi', '^.+天气$', 3, 255, 1),
(2, 2, 0, 'userapi', '^百科.+$', 3, 255, 1),
(3, 2, 0, 'userapi', '^定义.+$', 3, 255, 1),
(4, 3, 0, 'userapi', '^@.+$', 3, 255, 1),
(5, 4, 0, 'userapi', '日历', 1, 255, 1),
(6, 4, 0, 'userapi', '万年历', 1, 255, 1),
(7, 4, 0, 'userapi', '黄历', 1, 255, 1),
(8, 4, 0, 'userapi', '几号', 1, 255, 1),
(9, 5, 0, 'userapi', '新闻', 1, 255, 1),
(10, 6, 0, 'userapi', '^(申通|圆通|中通|汇通|韵达|顺丰|EMS) *[a-z0-9]{1,}$', 3, 255, 1),
(11, 7, 1, 'cover', '个人中心', 1, 0, 1),
(12, 8, 1, 'cover', '首页', 1, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_article`
--

CREATE TABLE IF NOT EXISTS `sltx_site_article` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `kid` int(10) unsigned NOT NULL,
  `iscommend` tinyint(1) NOT NULL,
  `ishot` tinyint(1) unsigned NOT NULL,
  `pcate` int(10) unsigned NOT NULL,
  `ccate` int(10) unsigned NOT NULL,
  `template` varchar(300) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `content` mediumtext NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `incontent` tinyint(1) NOT NULL,
  `source` varchar(255) NOT NULL,
  `author` varchar(50) NOT NULL,
  `displayorder` int(10) unsigned NOT NULL,
  `linkurl` varchar(500) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `click` int(10) unsigned NOT NULL,
  `type` varchar(10) NOT NULL,
  `credit` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_category`
--

CREATE TABLE IF NOT EXISTS `sltx_site_category` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `nid` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `parentid` int(10) unsigned NOT NULL,
  `displayorder` tinyint(3) unsigned NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL,
  `icon` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `styleid` int(10) unsigned NOT NULL,
  `linkurl` varchar(500) NOT NULL,
  `ishomepage` tinyint(1) NOT NULL,
  `icontype` tinyint(1) unsigned NOT NULL,
  `css` varchar(500) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_multi`
--

CREATE TABLE IF NOT EXISTS `sltx_site_multi` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `title` varchar(30) NOT NULL,
  `styleid` int(10) unsigned NOT NULL,
  `site_info` text NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `bindhost` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_site_multi`
--

INSERT INTO `sltx_site_multi` (`id`, `uniacid`, `title`, `styleid`, `site_info`, `status`, `bindhost`) VALUES
(1, 1, '微擎团队', 1, '', 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_nav`
--

CREATE TABLE IF NOT EXISTS `sltx_site_nav` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `multiid` int(10) unsigned NOT NULL,
  `section` tinyint(4) NOT NULL,
  `module` varchar(50) NOT NULL,
  `displayorder` smallint(5) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `position` tinyint(4) NOT NULL,
  `url` varchar(255) NOT NULL,
  `icon` varchar(500) NOT NULL,
  `css` varchar(1000) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `categoryid` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_page`
--

CREATE TABLE IF NOT EXISTS `sltx_site_page` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `multiid` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `params` longtext NOT NULL,
  `html` longtext NOT NULL,
  `type` tinyint(1) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `goodnum` int(10) unsigned NOT NULL,
  `multipage` longtext NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_site_page`
--

INSERT INTO `sltx_site_page` (`id`, `uniacid`, `multiid`, `title`, `description`, `params`, `html`, `type`, `status`, `createtime`, `goodnum`, `multipage`) VALUES
(1, 1, 0, '快捷菜单', '', '{"navStyle":"2","bgColor":"#f4f4f4","menus":[{"title":"\\u4f1a\\u5458\\u5361","url":".\\/index.php?c=mc&a=bond&do=card&i=1","submenus":[],"icon":{"name":"fa fa-credit-card","color":"#969696"},"image":"","hoverimage":"","hovericon":[]},{"title":"\\u5151\\u6362","url":".\\/index.php?c=activity&a=coupon&do=display&&i=1","submenus":[],"icon":{"name":"fa fa-money","color":"#969696"},"image":"","hoverimage":"","hovericon":[]},{"title":"\\u4ed8\\u6b3e","url":"\\" data-target=\\"#scan\\" data-toggle=\\"modal\\" href=\\"javascript:void();","submenus":[],"icon":{"name":"fa fa-qrcode","color":"#969696"},"image":"","hoverimage":"","hovericon":""},{"title":"\\u4e2a\\u4eba\\u4e2d\\u5fc3","url":".\\/index.php?i=1&c=mc&","submenus":[],"icon":{"name":"fa fa-user","color":"#969696"},"image":"","hoverimage":"","hovericon":[]}],"extend":[],"position":{"homepage":true,"usercenter":true,"page":true,"article":true},"ignoreModules":[]}', '<div style="background-color: rgb(244, 244, 244);" class="js-quickmenu nav-menu-app has-nav-0  has-nav-4"   ><ul class="nav-group clearfix"><li class="nav-group-item " ><a href="./index.php?c=mc&a=bond&do=card&i=1" style="background-position: center 2px;" ><i style="color: rgb(150, 150, 150);"  class="fa fa-credit-card"  js-onclass-name="" js-onclass-color="" ></i><span style="color: rgb(150, 150, 150);" class=""  js-onclass-color="">会员卡</span></a></li><li class="nav-group-item " ><a href="./index.php?c=activity&a=coupon&do=display&&i=1" style="background-position: center 2px;" ><i style="color: rgb(150, 150, 150);"  class="fa fa-money"  js-onclass-name="" js-onclass-color="" ></i><span style="color: rgb(150, 150, 150);" class=""  js-onclass-color="">兑换</span></a></li><li class="nav-group-item " ><a href="" data-target="#scan" data-toggle="modal" href="javascript:void();" style="background-position: center 2px;" ><i style="color: rgb(150, 150, 150);"  class="fa fa-qrcode"  js-onclass-name="" js-onclass-color="" ></i><span style="color: rgb(150, 150, 150);" class=""  js-onclass-color="">付款</span></a></li><li class="nav-group-item " ><a href="./index.php?i=1&c=mc&" style="background-position: center 2px;" ><i style="color: rgb(150, 150, 150);"  class="fa fa-user"  js-onclass-name="" js-onclass-color="" ></i><span style="color: rgb(150, 150, 150);" class=""  js-onclass-color="">个人中心</span></a></li></ul></div>', 4, 1, 1440242655, 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_slide`
--

CREATE TABLE IF NOT EXISTS `sltx_site_slide` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `multiid` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `displayorder` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_styles`
--

CREATE TABLE IF NOT EXISTS `sltx_site_styles` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `templateid` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_site_styles`
--

INSERT INTO `sltx_site_styles` (`id`, `uniacid`, `templateid`, `name`) VALUES
(1, 1, 1, '微站默认模板_gC5C');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_styles_vars`
--

CREATE TABLE IF NOT EXISTS `sltx_site_styles_vars` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `templateid` int(10) unsigned NOT NULL,
  `styleid` int(10) unsigned NOT NULL,
  `variable` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `description` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_site_templates`
--

CREATE TABLE IF NOT EXISTS `sltx_site_templates` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `version` varchar(64) NOT NULL,
  `description` varchar(500) NOT NULL,
  `author` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `type` varchar(20) NOT NULL,
  `sections` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_site_templates`
--

INSERT INTO `sltx_site_templates` (`id`, `name`, `title`, `version`, `description`, `author`, `url`, `type`, `sections`) VALUES
(1, 'default', '微站默认模板', '', '由微擎提供默认微站模板套系', '微擎团队', 'http://we7.cc', '1', 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_stat_fans`
--

CREATE TABLE IF NOT EXISTS `sltx_stat_fans` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `new` int(10) unsigned NOT NULL,
  `cancel` int(10) unsigned NOT NULL,
  `cumulate` int(10) NOT NULL,
  `date` varchar(8) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_stat_fans`
--

INSERT INTO `sltx_stat_fans` (`id`, `uniacid`, `new`, `cancel`, `cumulate`, `date`) VALUES
(1, 1, 0, 0, 0, '20170109'),
(2, 1, 0, 0, 0, '20170108'),
(3, 1, 0, 0, 0, '20170107'),
(4, 1, 0, 0, 0, '20170106'),
(5, 1, 0, 0, 0, '20170105'),
(6, 1, 0, 0, 0, '20170104'),
(7, 1, 0, 0, 0, '20170103'),
(8, 1, 0, 0, 0, '20170110'),
(9, 1, 0, 0, 0, '20170112'),
(10, 1, 0, 0, 0, '20170111'),
(11, 1, 0, 0, 0, '20170113'),
(12, 1, 0, 0, 0, '20170116'),
(13, 1, 0, 0, 0, '20170115'),
(14, 1, 0, 0, 0, '20170114'),
(15, 1, 0, 0, 0, '20170122'),
(16, 1, 0, 0, 0, '20170121'),
(17, 1, 0, 0, 0, '20170120'),
(18, 1, 0, 0, 0, '20170119'),
(19, 1, 0, 0, 0, '20170118'),
(20, 1, 0, 0, 0, '20170117'),
(21, 1, 0, 0, 0, '20170123'),
(22, 1, 0, 0, 0, '20170204'),
(23, 1, 0, 0, 0, '20170203'),
(24, 1, 0, 0, 0, '20170202'),
(25, 1, 0, 0, 0, '20170201'),
(26, 1, 0, 0, 0, '20170131'),
(27, 1, 0, 0, 0, '20170130'),
(28, 1, 0, 0, 0, '20170129'),
(29, 1, 0, 0, 0, '20170205'),
(30, 1, 0, 0, 0, '20170208'),
(31, 1, 0, 0, 0, '20170207'),
(32, 1, 0, 0, 0, '20170206'),
(33, 1, 0, 0, 0, '20170213'),
(34, 1, 0, 0, 0, '20170212'),
(35, 1, 0, 0, 0, '20170211'),
(36, 1, 0, 0, 0, '20170210'),
(37, 1, 0, 0, 0, '20170209'),
(38, 1, 0, 0, 0, '20170214'),
(39, 1, 0, 0, 0, '20170215'),
(40, 1, 0, 0, 0, '20170219'),
(41, 1, 0, 0, 0, '20170218'),
(42, 1, 0, 0, 0, '20170217'),
(43, 1, 0, 0, 0, '20170216'),
(44, 1, 0, 0, 0, '20170221'),
(45, 1, 0, 0, 0, '20170220'),
(46, 1, 0, 0, 0, '20170222'),
(47, 1, 0, 0, 0, '20170223'),
(48, 1, 0, 0, 0, '20170227'),
(49, 1, 0, 0, 0, '20170226'),
(50, 1, 0, 0, 0, '20170225'),
(51, 1, 0, 0, 0, '20170224'),
(52, 1, 0, 0, 0, '20170301'),
(53, 1, 0, 0, 0, '20170228'),
(54, 1, 0, 0, 0, '20170302'),
(55, 1, 0, 0, 0, '20170306'),
(56, 1, 0, 0, 0, '20170305'),
(57, 1, 0, 0, 0, '20170304'),
(58, 1, 0, 0, 0, '20170303'),
(59, 1, 0, 0, 0, '20170307'),
(60, 1, 0, 0, 0, '20170308'),
(61, 1, 0, 0, 0, '20170309'),
(62, 1, 0, 0, 0, '20170312'),
(63, 1, 0, 0, 0, '20170311'),
(64, 1, 0, 0, 0, '20170310'),
(65, 1, 0, 0, 0, '20170313'),
(66, 1, 0, 0, 0, '20170314'),
(67, 1, 0, 0, 0, '20170317'),
(68, 1, 0, 0, 0, '20170316'),
(69, 1, 0, 0, 0, '20170315'),
(70, 1, 0, 0, 0, '20170321'),
(71, 1, 0, 0, 0, '20170320'),
(72, 1, 0, 0, 0, '20170319'),
(73, 1, 0, 0, 0, '20170318'),
(74, 1, 0, 0, 0, '20170322'),
(75, 1, 0, 0, 0, '20170324'),
(76, 1, 0, 0, 0, '20170323'),
(77, 1, 0, 0, 0, '20170325'),
(78, 1, 0, 0, 0, '20170326'),
(79, 1, 0, 0, 0, '20170327'),
(80, 1, 0, 0, 0, '20170328'),
(81, 1, 0, 0, 0, '20170329'),
(82, 1, 0, 0, 0, '20170330'),
(83, 1, 0, 0, 0, '20170331'),
(84, 1, 0, 0, 0, '20170402'),
(85, 1, 0, 0, 0, '20170401'),
(86, 1, 0, 0, 0, '20170405'),
(87, 1, 0, 0, 0, '20170404'),
(88, 1, 0, 0, 0, '20170403'),
(89, 1, 0, 0, 0, '20170407'),
(90, 1, 0, 0, 0, '20170406');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_stat_keyword`
--

CREATE TABLE IF NOT EXISTS `sltx_stat_keyword` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `rid` varchar(10) NOT NULL,
  `kid` int(10) unsigned NOT NULL,
  `hit` int(10) unsigned NOT NULL,
  `lastupdate` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_stat_msg_history`
--

CREATE TABLE IF NOT EXISTS `sltx_stat_msg_history` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `kid` int(10) unsigned NOT NULL,
  `from_user` varchar(50) NOT NULL,
  `module` varchar(50) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `type` varchar(10) NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_stat_rule`
--

CREATE TABLE IF NOT EXISTS `sltx_stat_rule` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `hit` int(10) unsigned NOT NULL,
  `lastupdate` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_account`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_account` (
  `uniacid` int(10) unsigned NOT NULL,
  `groupid` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `default_acid` int(10) unsigned NOT NULL,
  `rank` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_uni_account`
--

INSERT INTO `sltx_uni_account` (`uniacid`, `groupid`, `name`, `description`, `default_acid`, `rank`) VALUES
(1, 0, '顺联控制台', '一个朝气蓬勃的团队', 1, 5);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_account_group`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_account_group` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `groupid` int(10) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_uni_account_group`
--

INSERT INTO `sltx_uni_account_group` (`id`, `uniacid`, `groupid`) VALUES
(1, 1, -1),
(2, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_account_menus`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_account_menus` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `menuid` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `title` varchar(30) NOT NULL,
  `sex` tinyint(3) unsigned NOT NULL,
  `group_id` int(10) NOT NULL,
  `client_platform_type` tinyint(3) unsigned NOT NULL,
  `area` varchar(50) NOT NULL,
  `data` text NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `isdeleted` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_account_modules`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_account_modules` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `module` varchar(50) NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL,
  `settings` text NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_uni_account_modules`
--

INSERT INTO `sltx_uni_account_modules` (`id`, `uniacid`, `module`, `enabled`, `settings`) VALUES
(1, 1, 'basic', 1, ''),
(2, 1, 'news', 1, ''),
(3, 1, 'music', 1, ''),
(4, 1, 'userapi', 1, ''),
(5, 1, 'recharge', 1, ''),
(12, 1, 'xsy_resource', 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_account_users`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_account_users` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `role` varchar(255) NOT NULL,
  `rank` tinyint(3) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_uni_account_users`
--

INSERT INTO `sltx_uni_account_users` (`id`, `uniacid`, `uid`, `role`, `rank`) VALUES
(2, 1, 2, 'operator', 5);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_group`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_group` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `modules` varchar(15000) NOT NULL,
  `templates` varchar(5000) NOT NULL,
  `uniacid` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_uni_group`
--

INSERT INTO `sltx_uni_group` (`id`, `name`, `modules`, `templates`, `uniacid`) VALUES
(1, '体验套餐服务', 'a:2:{i:0;s:12:"xsy_resource";i:1;s:11:"ewei_shopv2";}', 'N;', 0),
(2, '', 'a:1:{i:0;s:12:"xsy_resource";}', 'N;', 1);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_settings`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_settings` (
  `uniacid` int(10) unsigned NOT NULL,
  `passport` varchar(200) NOT NULL,
  `oauth` varchar(100) NOT NULL,
  `jsauth_acid` int(10) unsigned NOT NULL,
  `uc` varchar(500) NOT NULL,
  `notify` varchar(2000) NOT NULL,
  `creditnames` varchar(500) NOT NULL,
  `creditbehaviors` varchar(500) NOT NULL,
  `welcome` varchar(60) NOT NULL,
  `default` varchar(60) NOT NULL,
  `default_message` varchar(2000) NOT NULL,
  `shortcuts` text NOT NULL,
  `payment` varchar(2000) NOT NULL,
  `stat` varchar(300) NOT NULL,
  `default_site` int(10) unsigned DEFAULT NULL,
  `sync` tinyint(3) unsigned NOT NULL,
  `recharge` varchar(500) NOT NULL,
  `tplnotice` varchar(1000) NOT NULL,
  `grouplevel` tinyint(3) unsigned NOT NULL,
  `mcplugin` varchar(500) NOT NULL,
  `exchange_enable` tinyint(3) unsigned NOT NULL,
  `coupon_type` tinyint(3) unsigned NOT NULL,
  `menuset` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_uni_settings`
--

INSERT INTO `sltx_uni_settings` (`uniacid`, `passport`, `oauth`, `jsauth_acid`, `uc`, `notify`, `creditnames`, `creditbehaviors`, `welcome`, `default`, `default_message`, `shortcuts`, `payment`, `stat`, `default_site`, `sync`, `recharge`, `tplnotice`, `grouplevel`, `mcplugin`, `exchange_enable`, `coupon_type`, `menuset`) VALUES
(1, 'a:3:{s:8:"focusreg";i:0;s:4:"item";s:5:"email";s:4:"type";s:8:"password";}', 'a:2:{s:6:"status";s:1:"0";s:7:"account";s:1:"0";}', 0, 'a:1:{s:6:"status";i:0;}', 'a:1:{s:3:"sms";a:2:{s:7:"balance";i:0;s:9:"signature";s:0:"";}}', 'a:5:{s:7:"credit1";a:2:{s:5:"title";s:6:"积分";s:7:"enabled";i:1;}s:7:"credit2";a:2:{s:5:"title";s:6:"余额";s:7:"enabled";i:1;}s:7:"credit3";a:2:{s:5:"title";s:0:"";s:7:"enabled";i:0;}s:7:"credit4";a:2:{s:5:"title";s:0:"";s:7:"enabled";i:0;}s:7:"credit5";a:2:{s:5:"title";s:0:"";s:7:"enabled";i:0;}}', 'a:2:{s:8:"activity";s:7:"credit1";s:8:"currency";s:7:"credit2";}', '', '', '', 'a:1:{s:12:"xsy_resource";a:2:{s:4:"name";s:12:"xsy_resource";s:4:"link";s:50:"./index.php?c=home&a=welcome&do=ext&m=xsy_resource";}}', 'a:4:{s:6:"credit";a:1:{s:6:"switch";b:0;}s:6:"alipay";a:4:{s:6:"switch";b:0;s:7:"account";s:0:"";s:7:"partner";s:0:"";s:6:"secret";s:0:"";}s:6:"wechat";a:5:{s:6:"switch";b:0;s:7:"account";b:0;s:7:"signkey";s:0:"";s:7:"partner";s:0:"";s:3:"key";s:0:"";}s:8:"delivery";a:1:{s:6:"switch";b:0;}}', '', 1, 0, '', '', 0, '', 0, 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_uni_verifycode`
--

CREATE TABLE IF NOT EXISTS `sltx_uni_verifycode` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `receiver` varchar(50) NOT NULL,
  `verifycode` varchar(6) NOT NULL,
  `total` tinyint(3) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_userapi_cache`
--

CREATE TABLE IF NOT EXISTS `sltx_userapi_cache` (
  `id` int(10) unsigned NOT NULL,
  `key` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `lastupdate` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_userapi_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_userapi_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `description` varchar(300) NOT NULL,
  `apiurl` varchar(300) NOT NULL,
  `token` varchar(32) NOT NULL,
  `default_text` varchar(100) NOT NULL,
  `cachetime` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_userapi_reply`
--

INSERT INTO `sltx_userapi_reply` (`id`, `rid`, `description`, `apiurl`, `token`, `default_text`, `cachetime`) VALUES
(1, 1, '"城市名+天气", 如: "北京天气"', 'weather.php', '', '', 0),
(2, 2, '"百科+查询内容" 或 "定义+查询内容", 如: "百科姚明", "定义自行车"', 'baike.php', '', '', 0),
(3, 3, '"@查询内容(中文或英文)"', 'translate.php', '', '', 0),
(4, 4, '"日历", "万年历", "黄历"或"几号"', 'calendar.php', '', '', 0),
(5, 5, '"新闻"', 'news.php', '', '', 0),
(6, 6, '"快递+单号", 如: "申通1200041125"', 'express.php', '', '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_users`
--

CREATE TABLE IF NOT EXISTS `sltx_users` (
  `uid` int(10) unsigned NOT NULL,
  `groupid` int(10) unsigned NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(200) NOT NULL,
  `salt` varchar(10) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `status` tinyint(4) NOT NULL,
  `joindate` int(10) unsigned NOT NULL,
  `joinip` varchar(15) NOT NULL,
  `lastvisit` int(10) unsigned NOT NULL,
  `lastip` varchar(15) NOT NULL,
  `remark` varchar(500) NOT NULL,
  `starttime` int(10) unsigned NOT NULL,
  `endtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_users`
--

INSERT INTO `sltx_users` (`uid`, `groupid`, `username`, `password`, `salt`, `type`, `status`, `joindate`, `joinip`, `lastvisit`, `lastip`, `remark`, `starttime`, `endtime`) VALUES
(1, 0, 'admin', '049377aa16553cbab998895a22ca99c41cc4eb02', '2a83c190', 0, 0, 1483615024, '', 1491787973, '113.91.19.102', '', 0, 0),
(2, 1, 'kobe', '9161b7613e3784d3f21e05a1933bf29a4ce1b0b0', 'w3L6344s', 0, 2, 1484029447, '113.91.18.238', 1491656473, '113.90.72.193', '', 1484029447, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_users_failed_login`
--

CREATE TABLE IF NOT EXISTS `sltx_users_failed_login` (
  `id` int(10) unsigned NOT NULL,
  `ip` varchar(15) NOT NULL,
  `username` varchar(32) NOT NULL,
  `count` tinyint(1) unsigned NOT NULL,
  `lastupdate` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_users_group`
--

CREATE TABLE IF NOT EXISTS `sltx_users_group` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `package` varchar(5000) NOT NULL,
  `maxaccount` int(10) unsigned NOT NULL,
  `maxsubaccount` int(10) unsigned NOT NULL,
  `timelimit` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_users_group`
--

INSERT INTO `sltx_users_group` (`id`, `name`, `package`, `maxaccount`, `maxsubaccount`, `timelimit`) VALUES
(1, '普通管理员', 'a:2:{i:0;i:1;i:1;i:-1;}', 0, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_users_invitation`
--

CREATE TABLE IF NOT EXISTS `sltx_users_invitation` (
  `id` int(10) unsigned NOT NULL,
  `code` varchar(64) NOT NULL,
  `fromuid` int(10) unsigned NOT NULL,
  `inviteuid` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_users_permission`
--

CREATE TABLE IF NOT EXISTS `sltx_users_permission` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `type` varchar(30) NOT NULL,
  `permission` varchar(10000) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_users_permission`
--

INSERT INTO `sltx_users_permission` (`id`, `uniacid`, `uid`, `type`, `permission`, `url`) VALUES
(1, 1, 2, 'system', 'mc_member|mc_group', ''),
(3, 1, 2, 'xsy_resource', 'xsy_resource_menu_manager', '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_users_profile`
--

CREATE TABLE IF NOT EXISTS `sltx_users_profile` (
  `id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `realname` varchar(10) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `qq` varchar(15) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `fakeid` varchar(30) NOT NULL,
  `vip` tinyint(3) unsigned NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `birthyear` smallint(6) unsigned NOT NULL,
  `birthmonth` tinyint(3) unsigned NOT NULL,
  `birthday` tinyint(3) unsigned NOT NULL,
  `constellation` varchar(10) NOT NULL,
  `zodiac` varchar(5) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `idcard` varchar(30) NOT NULL,
  `studentid` varchar(50) NOT NULL,
  `grade` varchar(10) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zipcode` varchar(10) NOT NULL,
  `nationality` varchar(30) NOT NULL,
  `resideprovince` varchar(30) NOT NULL,
  `residecity` varchar(30) NOT NULL,
  `residedist` varchar(30) NOT NULL,
  `graduateschool` varchar(50) NOT NULL,
  `company` varchar(50) NOT NULL,
  `education` varchar(10) NOT NULL,
  `occupation` varchar(30) NOT NULL,
  `position` varchar(30) NOT NULL,
  `revenue` varchar(10) NOT NULL,
  `affectivestatus` varchar(30) NOT NULL,
  `lookingfor` varchar(255) NOT NULL,
  `bloodtype` varchar(5) NOT NULL,
  `height` varchar(5) NOT NULL,
  `weight` varchar(5) NOT NULL,
  `alipay` varchar(30) NOT NULL,
  `msn` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `taobao` varchar(30) NOT NULL,
  `site` varchar(30) NOT NULL,
  `bio` text NOT NULL,
  `interest` text NOT NULL,
  `workerid` varchar(64) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_users_profile`
--

INSERT INTO `sltx_users_profile` (`id`, `uid`, `createtime`, `realname`, `nickname`, `avatar`, `qq`, `mobile`, `fakeid`, `vip`, `gender`, `birthyear`, `birthmonth`, `birthday`, `constellation`, `zodiac`, `telephone`, `idcard`, `studentid`, `grade`, `address`, `zipcode`, `nationality`, `resideprovince`, `residecity`, `residedist`, `graduateschool`, `company`, `education`, `occupation`, `position`, `revenue`, `affectivestatus`, `lookingfor`, `bloodtype`, `height`, `weight`, `alipay`, `msn`, `email`, `taobao`, `site`, `bio`, `interest`, `workerid`) VALUES
(1, 2, 0, '8888', '8888', '', '781287777', '', '', 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `sltx_video_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_video_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `mediaid` varchar(255) NOT NULL,
  `createtime` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_voice_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_voice_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `mediaid` varchar(255) NOT NULL,
  `createtime` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_wechat_attachment`
--

CREATE TABLE IF NOT EXISTS `sltx_wechat_attachment` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned NOT NULL,
  `acid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `media_id` varchar(255) NOT NULL,
  `width` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL,
  `type` varchar(15) NOT NULL,
  `model` varchar(25) NOT NULL,
  `tag` varchar(5000) NOT NULL,
  `createtime` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_wechat_news`
--

CREATE TABLE IF NOT EXISTS `sltx_wechat_news` (
  `id` int(10) unsigned NOT NULL,
  `uniacid` int(10) unsigned DEFAULT NULL,
  `attach_id` int(10) unsigned NOT NULL,
  `thumb_media_id` varchar(60) NOT NULL,
  `thumb_url` varchar(255) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(30) NOT NULL,
  `digest` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `content_source_url` varchar(200) NOT NULL,
  `show_cover_pic` tinyint(3) unsigned NOT NULL,
  `url` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_wxcard_reply`
--

CREATE TABLE IF NOT EXISTS `sltx_wxcard_reply` (
  `id` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `title` varchar(30) NOT NULL,
  `card_id` varchar(50) NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `brand_name` varchar(30) NOT NULL,
  `logo_url` varchar(255) NOT NULL,
  `success` varchar(255) NOT NULL,
  `error` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sltx_xsy_resource_file`
--

CREATE TABLE IF NOT EXISTS `sltx_xsy_resource_file` (
  `id` int(11) NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  `type` char(32) NOT NULL COMMENT 'file：脚本，data：数据',
  `owner_id` int(11) DEFAULT NULL,
  `origin_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `time` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=333 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_xsy_resource_file`
--

INSERT INTO `sltx_xsy_resource_file` (`id`, `info`, `type`, `owner_id`, `origin_name`, `name`, `path`, `time`) VALUES
(242, '测试  客户模版', 'excel', 13, 'xxxxxx.xlsx', 'a5870d0538152a168b7f409f7ff2ef30.xlsx', 'http://oss.temaiol.com/file/1/20170328/a5870d0538152a168b7f409f7ff2ef30.xlsx', 1490702368),
(281, '等待2小时', 'file', 16, 'idle-kong.lua', '6d340cb41a72ab8b0a4b2de972c965e5.lua', 'http://oss.temaiol.com/file/1/20170329/6d340cb41a72ab8b0a4b2de972c965e5.lua', 1490789670),
(65, 'delete 测试', 'file', 10, 'sl_func_test.lua', '00137f6265c4bfa678d2a9231d79c65d.lua', 'http://oss.temaiol.com/file/1/20170315/00137f6265c4bfa678d2a9231d79c65d.lua', 1489563842),
(25, '空闲任务：用来填充任务间隙', 'file', 10, 'idle.lua', '47ab2708176bf72628a1c37caac4a888.lua', 'http://oss.temaiol.com/file/1/20170124/47ab2708176bf72628a1c37caac4a888.lua', 1485227338),
(64, '休眠3s', 'idle', 10, 'idle3s.lua', 'dd241b2ed9c42daeb3ea8a6497d2ed77.lua', 'http://oss.temaiol.com/file/1/20170314/dd241b2ed9c42daeb3ea8a6497d2ed77.lua', 1489460071),
(34, '服务器测试脚本,请勿删', 'file', 10, 'sl_func_xxxxxxxx.lua', '37ba7711a1697ba68aa079d8ed00df44.lua', 'http://oss.temaiol.com/file/1/20170306/37ba7711a1697ba68aa079d8ed00df44.lua', 1488802969),
(256, '用户配置-策略二', 'excel', 16, '用户数据_策略2.xlsx', '42a2dc08da21131d64dc1caf9eb89132.xlsx', 'http://oss.temaiol.com/file/1/20170329/42a2dc08da21131d64dc1caf9eb89132.xlsx', 1490772104),
(294, '增加联系人', 'data', 16, 'config_5.2.lua', '5f7fbcc1030245116e7508d8b80391bd.lua', 'http://oss.temaiol.com/file/1/20170401/5f7fbcc1030245116e7508d8b80391bd.lua', 1491039915),
(295, '删除联系人', 'data', 16, 'config_5.3.lua', '29986947a204d4cf67ce71138d00d78e.lua', 'http://oss.temaiol.com/file/1/20170401/29986947a204d4cf67ce71138d00d78e.lua', 1491039928),
(296, '删除照片', 'data', 16, 'config_5.1.lua', 'ad53a086d852cca410c6d1e0524e6839.lua', 'http://oss.temaiol.com/file/1/20170401/ad53a086d852cca410c6d1e0524e6839.lua', 1491039942),
(297, '群发消息', 'data', 16, 'config_4.3.lua', '39f56c5980c698e38ffffc0aab8b6990.lua', 'http://oss.temaiol.com/file/1/20170401/39f56c5980c698e38ffffc0aab8b6990.lua', 1491040002),
(298, '清楚缓存', 'data', 16, 'config_4.2.lua', '5f2ce000a34d62912604082b05f7a76f.lua', 'http://oss.temaiol.com/file/1/20170401/5f2ce000a34d62912604082b05f7a76f.lua', 1491040018),
(299, '修改签名名字', 'data', 16, 'config_4.1.lua', 'c747b3586e4b50ee8a465cbe51ebbece.lua', 'http://oss.temaiol.com/file/1/20170401/c747b3586e4b50ee8a465cbe51ebbece.lua', 1491040041),
(300, '保存图片到相册发朋友圈', 'data', 16, 'config_3.31.lua', '7283c712281fca3d052671ff2b96db2d.lua', 'http://oss.temaiol.com/file/1/20170401/7283c712281fca3d052671ff2b96db2d.lua', 1491040061),
(301, '站街扫街', 'data', 16, 'config_3.4.lua', '6237fb508fe5771667129c0d35a06e88.lua', 'http://oss.temaiol.com/file/1/20170401/6237fb508fe5771667129c0d35a06e88.lua', 1491040077),
(302, '漂流瓶', 'data', 16, 'config_3.2.lua', 'f749aeffdc1c51a9465cc37729227d0f.lua', 'http://oss.temaiol.com/file/1/20170401/f749aeffdc1c51a9465cc37729227d0f.lua', 1491040144),
(303, '附近人打招呼', 'data', 16, 'config_3.1.lua', '4e019cb050ba4152be1ecf4d6479c88a.lua', 'http://oss.temaiol.com/file/1/20170401/4e019cb050ba4152be1ecf4d6479c88a.lua', 1491040159),
(304, '关注公众号', 'data', 16, 'config_2.12.lua', '99fac1a42c3b69aef056c8285625f2d4.lua', 'http://oss.temaiol.com/file/1/20170401/99fac1a42c3b69aef056c8285625f2d4.lua', 1491040183),
(305, '搜索手机号微信号加好友', 'data', 16, 'config_2.11.lua', '288994ae9b4e4ea46502792c2985c01e.lua', 'http://oss.temaiol.com/file/1/20170401/288994ae9b4e4ea46502792c2985c01e.lua', 1491040210),
(306, '转发公众号文章', 'data', 16, 'config_2.5.lua', '7ed092663826d747a7cfc3574ececa21.lua', 'http://oss.temaiol.com/file/1/20170401/7ed092663826d747a7cfc3574ececa21.lua', 1491040224),
(307, '转发说说 文章', 'data', 16, 'config_2.4.lua', '27356130fd8da0cd5500d1d3b624c1f9.lua', 'http://oss.temaiol.com/file/1/20170401/27356130fd8da0cd5500d1d3b624c1f9.lua', 1491040246),
(308, '通讯录加好友', 'data', 16, 'config_2.2.lua', 'aedfdfcca4120395ba9a2d59e5c3cbc1.lua', 'http://oss.temaiol.com/file/1/20170401/aedfdfcca4120395ba9a2d59e5c3cbc1.lua', 1491040265),
(310, '用户数据_策略一', 'excel', 16, '用户数据_策略1.xlsx', '65d85af98433e8d63bec77685800f93a.xlsx', 'http://oss.temaiol.com/file/1/20170401/65d85af98433e8d63bec77685800f93a.xlsx', 1491040301),
(312, '用户数据_策略二', 'excel', 16, '用户数据_策略2.xlsx', 'dd4bf9bb8b0b1c6490c4c80d7c3a5430.xlsx', 'http://oss.temaiol.com/file/1/20170401/dd4bf9bb8b0b1c6490c4c80d7c3a5430.xlsx', 1491040567),
(317, '等待1小时', 'file', 16, 'idle-kong1.lua', '492383f45cfe669ecda8fd370801bd75.lua', 'http://oss.temaiol.com/file/1/20170403/492383f45cfe669ecda8fd370801bd75.lua', 1491205511),
(330, '随机发消息', 'data', 16, 'config_1.12.lua', '79d205d02c82b83f671947e347df3fe2.lua', 'http://oss.temaiol.com/file/1/20170407/79d205d02c82b83f671947e347df3fe2.lua', 1491553736),
(332, '等待一下', 'file', 16, 'time_1.lua', '11ad6f10387a9ed08b81314d91a7bae9.lua', 'http://oss.temaiol.com/file/1/20170407/11ad6f10387a9ed08b81314d91a7bae9.lua', 1491567852),
(331, '微信加粉3.3', 'file', 16, 'sl_func_wx_jiafen.lua.E2', '68d71b19335042e0cf3e9d0150fa23b9.E2', 'http://oss.temaiol.com/file/1/20170407/68d71b19335042e0cf3e9d0150fa23b9.E2', 1491567690),
(326, '微信加粉3.2', 'file', 16, 'sl_func_wx_jiafen.lua.E2', 'defc6f3163bc388fb1cfe5ac6d5ecd1c.E2', 'http://oss.temaiol.com/file/1/20170406/defc6f3163bc388fb1cfe5ac6d5ecd1c.E2', 1491467496),
(327, '智能回复', 'data', 16, 'config_1.1.lua', 'f1c93db12c3141751a0c497b6e1f48bb.lua', 'http://oss.temaiol.com/file/1/20170406/f1c93db12c3141751a0c497b6e1f48bb.lua', 1491467520),
(329, '删除文件夹', 'file', 16, 'shanchuwenjian.lua', 'a47337fd9942a670aff20616e8a9ff54.lua', 'http://oss.temaiol.com/file/1/20170406/a47337fd9942a670aff20616e8a9ff54.lua', 1491468043);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_xsy_resource_file_log`
--

CREATE TABLE IF NOT EXISTS `sltx_xsy_resource_file_log` (
  `id` int(11) NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `script_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=494 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sltx_xsy_resource_file_log`
--

INSERT INTO `sltx_xsy_resource_file_log` (`id`, `action`, `script_id`, `file_name`, `owner_id`, `time`) VALUES
(1, 'insert', 1, '小程序教程.txt', 2, 1484128788),
(2, 'update', 1, '小程序教程.txt', 2, 1484128846),
(3, 'insert', 2, '微信开发者工具.txt', 1, 1484128864),
(4, 'insert', 3, '修改记录.txt', 2, 1484128887),
(5, 'update', 3, '修改记录.txt', 2, 1484128896),
(6, 'update', 2, '微信开发者工具.txt', 1, 1484128905),
(7, 'update', 3, '修改记录.txt', 2, 1484129084),
(8, 'update', 2, '微信开发者工具.txt', 1, 1484129088),
(9, 'update', 1, '小程序教程.txt', 2, 1484129091),
(10, 'update', 3, '修改记录.txt', 2, 1484129096),
(11, 'update', 1, '小程序教程.txt', 2, 1484129099),
(12, 'update', 2, '微信开发者工具.txt', 1, 1484129107),
(13, 'del', 3, '修改记录.txt', 2, 1484184447),
(14, 'del', 1, '小程序教程.txt', 2, 1484184453),
(15, 'insert', 4, 'b8006d95bef1a5b9cddda9c8eacc8b1d.gif', 1, 1484184950),
(16, 'insert', 5, 'test_task_1.lua', 4, 1484560711),
(17, 'del', 4, 'b8006d95bef1a5b9cddda9c8eacc8b1d.gif', 1, 1484708329),
(18, 'del', 2, '微信开发者工具.txt', 1, 1484708331),
(19, 'insert', 6, 'test_task_1.lua', 1, 1484708352),
(20, 'insert', 7, 'test_task_1.lua', 2, 1484708366),
(21, 'insert', 8, 'test_task_1.lua', 5, 1484708380),
(22, 'insert', 9, 'idle.lua', 4, 1484727780),
(23, 'insert', 10, 'idle_data.lua', 4, 1484727895),
(24, 'insert', 11, 'idle_data_1.lua', 4, 1484737682),
(25, 'insert', 12, 'test_task_1.lua', 10, 1484903870),
(26, 'del', 5, 'test_task_1.lua', 4, 1484903959),
(27, 'del', 6, 'test_task_1.lua', 1, 1484903964),
(28, 'del', 8, 'test_task_1.lua', 5, 1484903966),
(29, 'del', 7, 'test_task_1.lua', 2, 1484903970),
(30, 'insert', 13, 'test_task_1.lua', 10, 1484903988),
(31, 'insert', 14, '修改记录.txt', 10, 1484905035),
(32, 'insert', 15, '修改记录.txt', 10, 1484905046),
(33, 'insert', 16, '小程序教程.txt', 10, 1484905056),
(34, 'insert', 17, '微信开发者工具.txt', 10, 1484905070),
(35, 'insert', 18, '小程序教程.txt', 10, 1484992031),
(36, 'insert', 19, 'idle.lua', 11, 1485224013),
(37, 'insert', 20, 'idle.lua', 10, 1485224040),
(38, 'insert', 21, 'idle2.lua', 10, 1485224058),
(39, 'insert', 22, 'idle3.lua', 10, 1485224069),
(40, 'insert', 23, 'idle4.lua', 10, 1485224084),
(41, 'del', 23, 'idle4.lua', 10, 1485227270),
(42, 'insert', 24, 'idle4.lua', 10, 1485227287),
(43, 'del', 22, 'idle3.lua', 10, 1485227292),
(44, 'del', 21, 'idle2.lua', 10, 1485227295),
(45, 'del', 20, 'idle.lua', 10, 1485227298),
(46, 'del', 19, 'idle.lua', 11, 1485227301),
(47, 'insert', 25, 'idle.lua', 10, 1485227338),
(48, 'insert', 26, 'idle2.lua', 10, 1485227353),
(49, 'insert', 27, 'idle3.lua', 10, 1485227362),
(50, 'del', 24, 'idle4.lua', 10, 1485227834),
(51, 'insert', 28, 'idle4.lua', 10, 1485227847),
(52, 'del', 28, 'idle4.lua', 10, 1487756572),
(53, 'del', 18, '小程序教程.txt', 10, 1487913341),
(54, 'insert', 29, 'add_contact_config.lua', 10, 1487913396),
(55, 'update', 29, 'add_contact_config.lua', 10, 1487913427),
(56, 'del', 29, 'add_contact_config.lua', 10, 1487913452),
(57, 'insert', 30, 'sl_func_phone_book_opt.lua', 10, 1487913484),
(58, 'insert', 31, 'add_contact_config.lua', 10, 1487913516),
(59, 'insert', 32, 'delete_contact_config.lua', 10, 1487913540),
(60, 'insert', 33, 'sl_func_phone_book_opt_1.lua', 10, 1487913680),
(61, 'del', 17, '微信开发者工具.txt', 10, 1487924600),
(62, 'del', 16, '小程序教程.txt', 10, 1487924611),
(63, 'del', 15, '修改记录.txt', 10, 1487924620),
(64, 'del', 11, 'idle_data_1.lua', 4, 1487924645),
(65, 'del', 12, 'test_task_1.lua', 10, 1487924652),
(66, 'del', 10, 'idle_data.lua', 4, 1487924666),
(67, 'del', 13, 'test_task_1.lua', 10, 1487924674),
(68, 'del', 14, '修改记录.txt', 10, 1487924683),
(69, 'del', 26, 'idle2.lua', 10, 1487924743),
(70, 'del', 27, 'idle3.lua', 10, 1487924749),
(71, 'update', 25, 'idle.lua', 10, 1487924764),
(72, 'update', 25, 'idle.lua', 10, 1487924806),
(73, 'del', 33, 'sl_func_phone_book_opt_1.lua', 10, 1488777873),
(74, 'del', 32, 'delete_contact_config.lua', 10, 1488801653),
(75, 'del', 31, 'add_contact_config.lua', 10, 1488801659),
(76, 'del', 30, 'sl_func_phone_book_opt.lua', 10, 1488801666),
(77, 'insert', 34, 'sl_func_xxxxxxxx.lua', 10, 1488802969),
(78, 'insert', 35, 'config_zengjialianxiren.lua', 10, 1488803028),
(79, 'insert', 36, 'config_shanchusuoyoulianxiren.lua', 10, 1488803116),
(80, 'del', 36, 'config_shanchusuoyoulianxiren.lua', 10, 1488803153),
(81, 'insert', 37, 'config_shanchusuoyoulianxiren.lua', 11, 1488803200),
(82, 'insert', 38, 'config_weixinjianpingzi.lua', 11, 1488803228),
(83, 'insert', 39, 'config_weixintianjialianxiren.lua', 10, 1488803255),
(84, 'insert', 40, 'config_weixinzhanjie.lua', 11, 1488803395),
(85, 'insert', 41, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488851546),
(86, 'del', 41, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488851570),
(87, 'insert', 42, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488851633),
(88, 'del', 42, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488851667),
(89, 'insert', 43, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488852502),
(90, 'insert', 44, '苹果.png', 11, 1488852516),
(91, 'del', 44, '苹果.png', 11, 1488852633),
(92, 'del', 43, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488852633),
(93, 'insert', 45, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488852652),
(94, 'insert', 46, 'message.png', 11, 1488852663),
(95, 'del', 46, 'message.png', 11, 1488852678),
(96, 'del', 45, 'u=2282661344,627107105&fm=23&gp=0.jpg', 11, 1488852678),
(97, 'insert', 47, 'timg (2).jpg', 11, 1488871182),
(98, 'insert', 48, 'timg (1).jpg', 11, 1488871182),
(99, 'insert', 49, '中控访问接口地址demo.txt', 11, 1488871503),
(100, 'insert', 50, 'readme.txt', 11, 1488871834),
(101, 'del', 50, 'readme.txt', 11, 1488871925),
(102, 'del', 49, '中控访问接口地址demo.txt', 11, 1488871925),
(103, 'del', 47, 'timg (2).jpg', 11, 1488871925),
(104, 'del', 48, 'timg (1).jpg', 11, 1488871925),
(105, 'insert', 51, '开发常用.txt', 11, 1488871991),
(106, 'del', 51, '开发常用.txt', 11, 1488872016),
(107, 'insert', 52, '开发常用.txt', 11, 1488872044),
(108, 'insert', 53, '开发常用.txt', 11, 1488872138),
(109, 'del', 53, '开发常用.txt', 11, 1488872144),
(110, 'del', 52, '开发常用.txt', 11, 1488872147),
(111, 'insert', 54, '20130531040849266333.jpg', 11, 1488872244),
(112, 'insert', 55, '49e49307607ac02221fc7.jpg', 11, 1488872244),
(113, 'insert', 56, '20121231134021_SRwHd.thumb.600_0.jpeg', 11, 1488872244),
(114, 'insert', 57, '016.jpg', 11, 1488872244),
(115, 'insert', 58, 'u=1548033705,436210072&fm=21&gp=0.jpg', 11, 1488872244),
(116, 'insert', 59, '20130812101458317.jpg', 11, 1488872244),
(117, 'del', 58, 'u=1548033705,436210072&fm=21&gp=0.jpg', 11, 1488872275),
(118, 'del', 59, '20130812101458317.jpg', 11, 1488872275),
(119, 'del', 55, '49e49307607ac02221fc7.jpg', 11, 1488872275),
(120, 'del', 56, '20121231134021_SRwHd.thumb.600_0.jpeg', 11, 1488872275),
(121, 'del', 57, '016.jpg', 11, 1488872275),
(122, 'del', 54, '20130531040849266333.jpg', 11, 1488872275),
(123, 'insert', 60, 'idle.lua', 11, 1489027262),
(124, 'insert', 61, 'idle2.lua', 11, 1489027299),
(125, 'insert', 62, 'idle3.lua', 11, 1489027299),
(126, 'insert', 63, 'idle4.lua', 11, 1489027299),
(127, 'update', 60, 'idle.lua', 11, 1489027307),
(128, 'del', 63, 'idle4.lua', 11, 1489459850),
(129, 'del', 62, 'idle3.lua', 11, 1489459861),
(130, 'del', 61, 'idle2.lua', 11, 1489459861),
(131, 'del', 60, 'idle.lua', 11, 1489459861),
(132, 'insert', 64, 'idle3s.lua', 10, 1489460071),
(133, 'insert', 65, 'sl_func_test.lua', 10, 1489563842),
(134, 'insert', 66, 'sl_func_server.lua', 10, 1489563881),
(135, 'insert', 67, 'config.lua', 10, 1489563932),
(136, 'insert', 68, 'dianhuaben_operate.lua', 10, 1489563933),
(137, 'insert', 69, 'package.lua', 10, 1489563933),
(138, 'insert', 70, '订单数据.xls', 14, 1490263131),
(139, 'insert', 71, '订单数据.xls', 14, 1490264430),
(140, 'insert', 72, 'ceshi.xls', 14, 1490323262),
(141, 'insert', 73, '测试模板.xls', 14, 1490345962),
(142, 'del', 79, '测试模板.xls', 11, 1490498716),
(143, 'del', 78, 'ceshi.xls', 11, 1490498716),
(144, 'del', 77, '测试模板.xls', 11, 1490498716),
(145, 'del', 76, '测试模板.xls', 11, 1490498716),
(146, 'del', 75, '测试模板.xls', 11, 1490498716),
(147, 'del', 74, 'ceshi.xls', 11, 1490498716),
(148, 'del', 73, '测试模板.xls', 14, 1490498716),
(149, 'del', 72, 'ceshi.xls', 14, 1490498716),
(150, 'del', 71, '订单数据.xls', 14, 1490498716),
(151, 'del', 70, '订单数据.xls', 14, 1490498716),
(152, 'del', 69, 'package.lua', 10, 1490500960),
(153, 'del', 68, 'dianhuaben_operate.lua', 10, 1490500960),
(154, 'del', 67, 'config.lua', 10, 1490500960),
(155, 'insert', 80, '数据模版1.xls', 15, 1490501072),
(156, 'del', 102, '数据模版.xls', 11, 1490617016),
(157, 'del', 101, '数据模版.xls', 11, 1490617016),
(158, 'del', 100, '数据模版.xls', 11, 1490617016),
(159, 'del', 99, '数据模版.xls', 11, 1490617016),
(160, 'del', 98, '数据模版.xls', 11, 1490617016),
(161, 'del', 97, '数据模版.xls', 11, 1490617016),
(162, 'del', 96, '数据模版.xls', 11, 1490617016),
(163, 'del', 95, '数据模版.xls', 11, 1490617016),
(164, 'del', 94, '数据模版.xls', 11, 1490617016),
(165, 'del', 93, '数据模版.xls', 11, 1490617016),
(166, 'del', 212, '数据模版.xls', 11, 1490617033),
(167, 'del', 211, '数据模版.xls', 11, 1490617033),
(168, 'del', 210, '数据模版.xls', 11, 1490617033),
(169, 'del', 209, '数据模版.xls', 11, 1490617033),
(170, 'del', 208, '数据模版.xls', 11, 1490617033),
(171, 'del', 207, '数据模版.xls', 11, 1490617033),
(172, 'del', 206, '数据模版.xls', 11, 1490617033),
(173, 'del', 205, '数据模版.xls', 11, 1490617033),
(174, 'del', 204, '数据模版.xls', 11, 1490617033),
(175, 'del', 203, '数据模版.xls', 11, 1490617033),
(176, 'del', 202, '数据模版.xls', 11, 1490617055),
(177, 'del', 201, '数据模版.xls', 11, 1490617055),
(178, 'del', 200, '数据模版.xls', 11, 1490617055),
(179, 'del', 199, '数据模版.xls', 11, 1490617055),
(180, 'del', 198, '数据模版.xls', 11, 1490617055),
(181, 'del', 197, '数据模版.xls', 11, 1490617055),
(182, 'del', 196, '数据模版.xls', 11, 1490617055),
(183, 'del', 195, '数据模版.xls', 11, 1490617055),
(184, 'del', 194, '数据模版.xls', 11, 1490617055),
(185, 'del', 193, '数据模版.xls', 11, 1490617055),
(186, 'del', 192, '数据模版.xls', 11, 1490617074),
(187, 'del', 191, '数据模版.xls', 11, 1490617074),
(188, 'del', 190, '数据模版.xls', 11, 1490617074),
(189, 'del', 189, '数据模版.xls', 11, 1490617074),
(190, 'del', 188, '数据模版.xls', 11, 1490617074),
(191, 'del', 187, '数据模版.xls', 11, 1490617074),
(192, 'del', 186, '数据模版.xls', 11, 1490617074),
(193, 'del', 185, '数据模版.xls', 11, 1490617074),
(194, 'del', 184, '数据模版.xls', 11, 1490617074),
(195, 'del', 183, '数据模版.xls', 11, 1490617074),
(196, 'del', 182, '数据模版.xls', 11, 1490617090),
(197, 'del', 181, '数据模版.xls', 11, 1490617090),
(198, 'del', 180, '数据模版.xls', 11, 1490617090),
(199, 'del', 179, '数据模版.xls', 11, 1490617090),
(200, 'del', 178, '数据模版.xls', 11, 1490617090),
(201, 'del', 177, '数据模版.xls', 11, 1490617090),
(202, 'del', 176, '数据模版.xls', 11, 1490617090),
(203, 'del', 175, '数据模版.xls', 11, 1490617090),
(204, 'del', 174, '数据模版.xls', 11, 1490617090),
(205, 'del', 173, '数据模版.xls', 11, 1490617090),
(206, 'del', 172, '数据模版.xls', 11, 1490617106),
(207, 'del', 171, '数据模版.xls', 11, 1490617106),
(208, 'del', 170, '数据模版.xls', 11, 1490617106),
(209, 'del', 169, '数据模版.xls', 11, 1490617106),
(210, 'del', 168, '数据模版.xls', 11, 1490617106),
(211, 'del', 167, '数据模版.xls', 11, 1490617106),
(212, 'del', 166, '数据模版.xls', 11, 1490617106),
(213, 'del', 165, '数据模版.xls', 11, 1490617106),
(214, 'del', 164, '数据模版.xls', 11, 1490617106),
(215, 'del', 163, '数据模版.xls', 11, 1490617106),
(216, 'del', 162, '数据模版.xls', 11, 1490617123),
(217, 'del', 161, '数据模版.xls', 11, 1490617123),
(218, 'del', 160, '数据模版.xls', 11, 1490617123),
(219, 'del', 159, '数据模版.xls', 11, 1490617123),
(220, 'del', 158, '数据模版.xls', 11, 1490617123),
(221, 'del', 157, '数据模版.xls', 11, 1490617123),
(222, 'del', 156, '数据模版.xls', 11, 1490617123),
(223, 'del', 155, '数据模版.xls', 11, 1490617123),
(224, 'del', 154, '数据模版.xls', 11, 1490617123),
(225, 'del', 153, '数据模版.xls', 11, 1490617123),
(226, 'del', 152, '数据模版.xls', 11, 1490617139),
(227, 'del', 151, '数据模版.xls', 11, 1490617139),
(228, 'del', 150, '数据模版.xls', 11, 1490617139),
(229, 'del', 149, '数据模版.xls', 11, 1490617139),
(230, 'del', 148, '数据模版.xls', 11, 1490617139),
(231, 'del', 147, '数据模版.xls', 11, 1490617139),
(232, 'del', 146, '数据模版.xls', 11, 1490617139),
(233, 'del', 145, '数据模版.xls', 11, 1490617139),
(234, 'del', 144, '数据模版.xls', 11, 1490617139),
(235, 'del', 143, '数据模版.xls', 11, 1490617139),
(236, 'del', 142, '数据模版.xls', 11, 1490617156),
(237, 'del', 141, '数据模版.xls', 11, 1490617156),
(238, 'del', 140, '数据模版.xls', 11, 1490617156),
(239, 'del', 139, '数据模版.xls', 11, 1490617156),
(240, 'del', 138, '数据模版.xls', 11, 1490617156),
(241, 'del', 137, '数据模版.xls', 11, 1490617156),
(242, 'del', 136, '数据模版.xls', 11, 1490617156),
(243, 'del', 135, '数据模版.xls', 11, 1490617156),
(244, 'del', 134, '数据模版.xls', 11, 1490617156),
(245, 'del', 133, '数据模版.xls', 11, 1490617156),
(246, 'del', 132, '数据模版.xls', 11, 1490617173),
(247, 'del', 131, '数据模版.xls', 11, 1490617173),
(248, 'del', 130, '数据模版.xls', 11, 1490617173),
(249, 'del', 129, '数据模版.xls', 11, 1490617173),
(250, 'del', 128, '数据模版.xls', 11, 1490617173),
(251, 'del', 127, '数据模版.xls', 11, 1490617173),
(252, 'del', 126, '数据模版.xls', 11, 1490617173),
(253, 'del', 125, '数据模版.xls', 11, 1490617173),
(254, 'del', 124, '数据模版.xls', 11, 1490617173),
(255, 'del', 123, '数据模版.xls', 11, 1490617173),
(256, 'del', 122, '数据模版.xls', 11, 1490617189),
(257, 'del', 121, '数据模版.xls', 11, 1490617189),
(258, 'del', 120, '数据模版.xls', 11, 1490617189),
(259, 'del', 119, '数据模版.xls', 11, 1490617189),
(260, 'del', 118, '数据模版.xls', 11, 1490617189),
(261, 'del', 117, '数据模版.xls', 11, 1490617189),
(262, 'del', 116, '数据模版.xls', 11, 1490617189),
(263, 'del', 115, '测试模板.xls', 11, 1490617189),
(264, 'del', 114, '数据模版.xls', 11, 1490617189),
(265, 'del', 113, '数据模版.xls', 11, 1490617189),
(266, 'del', 112, '数据模版.xls', 11, 1490617202),
(267, 'del', 111, '数据模版.xls', 11, 1490617202),
(268, 'del', 110, '数据模版.xls', 11, 1490617202),
(269, 'del', 109, '数据模版.xls', 11, 1490617202),
(270, 'del', 108, '数据模版.xls', 11, 1490617202),
(271, 'del', 107, '测试模板.xls', 11, 1490617202),
(272, 'del', 106, '数据模版.xls', 11, 1490617202),
(273, 'del', 105, '数据模版.xls', 11, 1490617202),
(274, 'del', 104, '数据模版.xls', 11, 1490617202),
(275, 'del', 103, '数据模版.xls', 11, 1490617202),
(276, 'del', 92, '数据模版.xls', 11, 1490617226),
(277, 'del', 91, '数据模版.xls', 11, 1490617226),
(278, 'del', 90, '数据模版.xls', 11, 1490617226),
(279, 'del', 89, '数据模版.xls', 11, 1490617226),
(280, 'del', 88, '数据模版.xls', 11, 1490617226),
(281, 'del', 87, '数据模版.xls', 11, 1490617226),
(282, 'del', 86, '数据模版.xls', 11, 1490617226),
(283, 'del', 85, '数据模版.xls', 11, 1490617226),
(284, 'del', 84, '20170325034543305.xls', 15, 1490617226),
(285, 'del', 83, '数据模版1.xls', 15, 1490617226),
(286, 'del', 82, '20170325034543305.xls', 15, 1490617243),
(287, 'del', 81, '4f1d60c359ce137b1ff066ecf3ab70e8.xls', 15, 1490617243),
(288, 'del', 80, '数据模版1.xls', 15, 1490617243),
(289, 'insert', 213, '模版示例.xlsx', 10, 1490617304),
(290, 'insert', 216, '用户数据_策略1.xlsx', 10, 1490690566),
(291, 'insert', 217, '用户数据_策略2.xlsx', 10, 1490690602),
(292, 'insert', 218, 'sl_func_weixinxiaogongneng.lua', 10, 1490691378),
(293, 'insert', 219, 'config_2.4.lua', 10, 1490691479),
(294, 'del', 219, 'config_2.4.lua', 10, 1490691871),
(295, 'insert', 220, 'config.lua', 10, 1490692300),
(296, 'insert', 221, 'WeChar_main.lua', 10, 1490692331),
(297, 'del', 218, 'sl_func_weixinxiaogongneng.lua', 10, 1490692506),
(298, 'insert', 222, 'sl_func_weixinxiaogongneng.lua', 10, 1490692539),
(299, 'del', 221, 'WeChar_main.lua', 10, 1490693090),
(300, 'del', 222, 'sl_func_weixinxiaogongneng.lua', 10, 1490693107),
(301, 'del', 220, 'config.lua', 10, 1490693497),
(302, 'insert', 223, 'sl_func_weixinxiaogongneng.lua', 10, 1490693540),
(303, 'insert', 224, 'sl_func_test.lua', 10, 1490693562),
(304, 'del', 217, '用户数据_策略2.xlsx', 10, 1490697423),
(305, 'del', 216, '用户数据_策略1.xlsx', 10, 1490697426),
(306, 'insert', 225, '用户数据_策略1.xlsx', 10, 1490697454),
(307, 'insert', 226, '用户数据_策略2.xlsx', 10, 1490697478),
(308, 'del', 230, 'xxxxxx.xlsx', 13, 1490700687),
(309, 'del', 229, 'xxxxxx.xlsx', 13, 1490700687),
(310, 'del', 228, 'xxxxxx.xlsx', 13, 1490700687),
(311, 'del', 227, 'xxxxxx.xlsx', 13, 1490700687),
(312, 'del', 226, '用户数据_策略2.xlsx', 10, 1490700733),
(313, 'del', 225, '用户数据_策略1.xlsx', 10, 1490700733),
(314, 'insert', 231, 'xxxxxx.xlsx', 13, 1490700830),
(315, 'del', 224, 'sl_func_test.lua', 10, 1490700933),
(316, 'del', 231, 'xxxxxx.xlsx', 13, 1490701143),
(317, 'del', 223, 'sl_func_weixinxiaogongneng.lua', 10, 1490701154),
(318, 'insert', 232, 'sl_func_wx_jiafen.lua', 10, 1490701181),
(319, 'insert', 233, 'config_2.2.lua', 10, 1490701270),
(320, 'del', 215, '模版示例.xlsx', 13, 1490701278),
(321, 'del', 214, 'xxxx.xlsx', 13, 1490701282),
(322, 'insert', 234, 'config_2.4.lua', 10, 1490701307),
(323, 'del', 234, 'config_2.4.lua', 10, 1490702100),
(324, 'del', 233, 'config_2.2.lua', 10, 1490702105),
(325, 'insert', 235, 'config_2.2.lua', 10, 1490702131),
(326, 'insert', 236, 'config_2.4.lua', 10, 1490702162),
(327, 'del', 66, 'sl_func_server.lua', 10, 1490702199),
(328, 'insert', 237, 'config_2.5.lua', 10, 1490702247),
(329, 'insert', 238, 'config_2.11.lua', 10, 1490702279),
(330, 'update', 34, 'sl_func_xxxxxxxx.lua', 10, 1490702292),
(331, 'insert', 239, 'config_2.12.lua', 10, 1490702311),
(332, 'insert', 240, 'config_3.1.lua', 10, 1490702329),
(333, 'del', 213, '模版示例.xlsx', 10, 1490702332),
(334, 'insert', 241, 'config_3.2.lua', 10, 1490702349),
(335, 'insert', 242, 'xxxxxx.xlsx', 13, 1490702368),
(336, 'insert', 243, 'config_3.31.lua', 10, 1490702390),
(337, 'insert', 244, 'config_3.4.lua', 10, 1490702435),
(338, 'insert', 245, 'config_4.1.lua', 10, 1490702455),
(339, 'insert', 246, 'config_4.2.lua', 10, 1490702480),
(340, 'insert', 247, 'config_4.3.lua', 10, 1490702500),
(341, 'insert', 248, 'config_5.2.lua', 10, 1490702517),
(342, 'insert', 249, 'config_5.3.lua', 10, 1490702537),
(343, 'insert', 251, '用户数据_策略1.xlsx', 10, 1490702784),
(344, 'insert', 252, '用户数据_策略2.xlsx', 10, 1490702805),
(345, 'insert', 253, 'config_5.1.lua', 16, 1490703152),
(346, 'del', 252, '用户数据_策略2.xlsx', 10, 1490772036),
(347, 'del', 251, '用户数据_策略1.xlsx', 10, 1490772040),
(348, 'insert', 254, '用户数据_策略1.xlsx', 16, 1490772064),
(349, 'insert', 255, '用户数据_策略2.xlsx', 16, 1490772084),
(350, 'del', 255, '用户数据_策略2.xlsx', 16, 1490772088),
(351, 'insert', 256, '用户数据_策略2.xlsx', 16, 1490772104),
(352, 'del', 248, 'config_5.2.lua', 10, 1490772112),
(353, 'insert', 257, 'config_5.2.lua', 16, 1490772141),
(354, 'del', 253, 'config_5.1.lua', 16, 1490774532),
(355, 'insert', 258, 'config_5.1.lua', 16, 1490774547),
(356, 'del', 249, 'config_5.3.lua', 10, 1490774819),
(357, 'insert', 259, 'config_5.3.lua', 16, 1490774843),
(358, 'del', 247, 'config_4.3.lua', 10, 1490774852),
(359, 'insert', 260, 'config_4.3.lua', 16, 1490774866),
(360, 'del', 246, 'config_4.2.lua', 10, 1490774884),
(361, 'insert', 261, 'config_4.2.lua', 16, 1490774898),
(362, 'del', 232, 'sl_func_wx_jiafen.lua', 10, 1490774912),
(363, 'insert', 262, 'sl_func_wx_jiafen.lua', 16, 1490774938),
(364, 'del', 35, 'config_zengjialianxiren.lua', 10, 1490774959),
(365, 'del', 37, 'config_shanchusuoyoulianxiren.lua', 11, 1490774971),
(366, 'del', 38, 'config_weixinjianpingzi.lua', 11, 1490774981),
(367, 'del', 40, 'config_weixinzhanjie.lua', 11, 1490774997),
(368, 'del', 39, 'config_weixintianjialianxiren.lua', 10, 1490775010),
(369, 'del', 250, 'xxxxxx.xlsx', 13, 1490775071),
(370, 'del', 245, 'config_4.1.lua', 10, 1490775104),
(371, 'insert', 263, 'config_4.1.lua', 16, 1490775119),
(372, 'del', 244, 'config_3.4.lua', 10, 1490775133),
(373, 'insert', 264, 'config_3.4.lua', 16, 1490775144),
(374, 'del', 243, 'config_3.31.lua', 10, 1490775154),
(375, 'insert', 265, 'config_3.31.lua', 16, 1490775164),
(376, 'update', 241, 'config_3.2.lua', 10, 1490775179),
(377, 'del', 241, 'config_3.2.lua', 10, 1490775185),
(378, 'insert', 266, 'config_3.2.lua', 16, 1490775195),
(379, 'update', 240, 'config_3.1.lua', 10, 1490775213),
(380, 'del', 240, 'config_3.1.lua', 10, 1490775221),
(381, 'insert', 267, 'config_3.1.lua', 16, 1490775232),
(382, 'del', 239, 'config_2.12.lua', 10, 1490775250),
(383, 'insert', 268, 'config_2.12.lua', 16, 1490775259),
(384, 'del', 238, 'config_2.11.lua', 10, 1490775275),
(385, 'insert', 269, 'config_2.11.lua', 16, 1490775286),
(386, 'del', 237, 'config_2.5.lua', 10, 1490775298),
(387, 'insert', 270, 'config_2.5.lua', 16, 1490775307),
(388, 'del', 236, 'config_2.4.lua', 10, 1490775317),
(389, 'insert', 271, 'config_2.4.lua', 16, 1490775328),
(390, 'del', 235, 'config_2.2.lua', 10, 1490775352),
(391, 'insert', 272, 'config_2.2.lua', 16, 1490775362),
(392, 'del', 273, 'a5870d0538152a168b7f409f7ff2ef30 (1).xlsx', 11, 1490786035),
(393, 'del', 274, 'a5870d0538152a168b7f409f7ff2ef30 (1).xlsx', 11, 1490786039),
(394, 'del', 275, 'a5870d0538152a168b7f409f7ff2ef30.xlsx', 11, 1490786043),
(395, 'del', 276, 'a5870d0538152a168b7f409f7ff2ef30.xlsx', 11, 1490786046),
(396, 'del', 277, 'a5870d0538152a168b7f409f7ff2ef30.xlsx', 11, 1490786049),
(397, 'del', 279, 'a5870d0538152a168b7f409f7ff2ef30 (1).xlsx', 11, 1490786056),
(398, 'del', 278, 'a5870d0538152a168b7f409f7ff2ef30 (1).xlsx', 11, 1490786056),
(399, 'del', 262, 'sl_func_wx_jiafen.lua', 16, 1490788885),
(400, 'insert', 280, 'sl_func_wx_jiafen.lua', 16, 1490788907),
(401, 'insert', 281, 'idle-kong.lua', 16, 1490789670),
(402, 'insert', 282, 'sl_func_wx_jiafen.lua', 16, 1490837714),
(403, 'del', 282, 'sl_func_wx_jiafen.lua', 16, 1490842662),
(404, 'insert', 283, 'sl_func_wx_jiafen.lua', 16, 1490857779),
(405, 'update', 283, 'sl_func_wx_jiafen.lua', 16, 1490857788),
(406, 'del', 280, 'sl_func_wx_jiafen.lua', 16, 1490871094),
(407, 'insert', 285, 'sl_func_wx_jiafen.lua', 16, 1490951114),
(408, 'del', 257, 'config_5.2.lua', 16, 1490951894),
(409, 'insert', 286, 'config_5.2.lua', 16, 1490951913),
(410, 'insert', 287, 'sl_func_wx_jiafen.lua', 16, 1490956088),
(411, 'del', 285, 'sl_func_wx_jiafen.lua', 16, 1490956092),
(412, 'del', 284, '42a2dc08da21131d64dc1caf9eb89132.xlsx', 16, 1490956725),
(413, 'insert', 289, 'config_1.1.lua', 16, 1490964451),
(414, 'insert', 290, 'sl_func_wx_jiafen.lua', 16, 1490964488),
(415, 'del', 283, 'sl_func_wx_jiafen.lua', 16, 1490964522),
(416, 'del', 289, 'config_1.1.lua', 16, 1491010304),
(417, 'del', 290, 'sl_func_wx_jiafen.lua', 16, 1491010308),
(418, 'insert', 291, 'sl_func_wx_jiafen.lua', 16, 1491010338),
(419, 'insert', 292, 'config_1.1.lua', 16, 1491010356),
(420, 'insert', 293, 'config_2.11.lua', 16, 1491014113),
(421, 'del', 269, 'config_2.11.lua', 16, 1491014123),
(422, 'del', 287, 'sl_func_wx_jiafen.lua', 16, 1491014274),
(423, 'del', 254, '用户数据_策略1.xlsx', 16, 1491039855),
(424, 'del', 293, 'config_2.11.lua', 16, 1491039870),
(425, 'del', 292, 'config_1.1.lua', 16, 1491039870),
(426, 'del', 291, 'sl_func_wx_jiafen.lua', 16, 1491039870),
(427, 'del', 288, '42a2dc08da21131d64dc1caf9eb89132.xlsx', 16, 1491039870),
(428, 'del', 286, 'config_5.2.lua', 16, 1491039870),
(429, 'del', 272, 'config_2.2.lua', 16, 1491039870),
(430, 'del', 271, 'config_2.4.lua', 16, 1491039870),
(431, 'del', 270, 'config_2.5.lua', 16, 1491039870),
(432, 'del', 268, 'config_2.12.lua', 16, 1491039870),
(433, 'del', 267, 'config_3.1.lua', 16, 1491039883),
(434, 'del', 266, 'config_3.2.lua', 16, 1491039883),
(435, 'del', 265, 'config_3.31.lua', 16, 1491039883),
(436, 'del', 264, 'config_3.4.lua', 16, 1491039883),
(437, 'del', 263, 'config_4.1.lua', 16, 1491039883),
(438, 'del', 261, 'config_4.2.lua', 16, 1491039883),
(439, 'del', 260, 'config_4.3.lua', 16, 1491039883),
(440, 'del', 259, 'config_5.3.lua', 16, 1491039883),
(441, 'del', 258, 'config_5.1.lua', 16, 1491039883),
(442, 'insert', 294, 'config_5.2.lua', 16, 1491039915),
(443, 'insert', 295, 'config_5.3.lua', 16, 1491039928),
(444, 'insert', 296, 'config_5.1.lua', 16, 1491039942),
(445, 'insert', 297, 'config_4.3.lua', 16, 1491040002),
(446, 'insert', 298, 'config_4.2.lua', 16, 1491040018),
(447, 'insert', 299, 'config_4.1.lua', 16, 1491040041),
(448, 'insert', 300, 'config_3.31.lua', 16, 1491040061),
(449, 'insert', 301, 'config_3.4.lua', 16, 1491040077),
(450, 'insert', 302, 'config_3.2.lua', 16, 1491040144),
(451, 'insert', 303, 'config_3.1.lua', 16, 1491040159),
(452, 'insert', 304, 'config_2.12.lua', 16, 1491040183),
(453, 'insert', 305, 'config_2.11.lua', 16, 1491040210),
(454, 'insert', 306, 'config_2.5.lua', 16, 1491040224),
(455, 'insert', 307, 'config_2.4.lua', 16, 1491040246),
(456, 'insert', 308, 'config_2.2.lua', 16, 1491040265),
(457, 'insert', 309, 'config_1.1.lua', 16, 1491040281),
(458, 'insert', 310, '用户数据_策略1.xlsx', 16, 1491040301),
(459, 'insert', 311, 'sl_func_wx_jiafen.lua', 16, 1491040370),
(460, 'insert', 312, '用户数据_策略2.xlsx', 16, 1491040567),
(461, 'del', 311, 'sl_func_wx_jiafen.lua', 16, 1491042324),
(462, 'insert', 313, 'sl_func_wx_jiafen.lua', 16, 1491042351),
(463, 'insert', 314, 'sl_func_wx_jiafen.lua', 16, 1491044350),
(464, 'del', 314, 'sl_func_wx_jiafen.lua', 16, 1491044356),
(465, 'insert', 315, 'sl_func_wx_jiafen.lua', 16, 1491044372),
(466, 'del', 313, 'sl_func_wx_jiafen.lua', 16, 1491044641),
(467, 'del', 315, 'sl_func_wx_jiafen.lua', 16, 1491205387),
(468, 'insert', 316, 'sl_func_wx_jiafen.lua.E2', 16, 1491205408),
(469, 'insert', 317, 'idle-kong1.lua', 16, 1491205511),
(470, 'insert', 320, 'sl_func_wx_jiafen.lua', 16, 1491396923),
(471, 'del', 320, 'sl_func_wx_jiafen.lua', 16, 1491397539),
(472, 'insert', 321, 'sl_func_wx_jiafen.lua', 16, 1491397565),
(473, 'insert', 322, 'config_2.6.lua', 16, 1491397619),
(474, 'del', 322, 'config_2.6.lua', 16, 1491445117),
(475, 'del', 321, 'sl_func_wx_jiafen.lua', 16, 1491445121),
(476, 'insert', 323, 'sl_func_wx_jiafen.lua', 16, 1491445141),
(477, 'insert', 324, 'config_1.12.lua', 16, 1491445168),
(478, 'del', 323, 'sl_func_wx_jiafen.lua', 16, 1491445928),
(479, 'insert', 325, 'sl_func_wx_jiafen.lua', 16, 1491445950),
(480, 'insert', 326, 'sl_func_wx_jiafen.lua.E2', 16, 1491467496),
(481, 'insert', 327, 'config_1.1.lua', 16, 1491467520),
(482, 'insert', 328, 'shanchuwenjian.lua', 16, 1491467826),
(483, 'del', 328, 'shanchuwenjian.lua', 16, 1491468016),
(484, 'insert', 329, 'shanchuwenjian.lua', 16, 1491468043),
(485, 'del', 325, 'sl_func_wx_jiafen.lua', 16, 1491468261),
(486, 'del', 309, 'config_1.1.lua', 16, 1491468270),
(487, 'del', 316, 'sl_func_wx_jiafen.lua.E2', 16, 1491468507),
(488, 'del', 319, '65d85af98433e8d63bec77685800f93a.xlsx', 19, 1491468523),
(489, 'del', 318, '65d85af98433e8d63bec77685800f93a.xlsx', 19, 1491468526),
(490, 'insert', 330, 'config_1.12.lua', 16, 1491553736),
(491, 'del', 324, 'config_1.12.lua', 16, 1491553758),
(492, 'insert', 331, 'sl_func_wx_jiafen.lua.E2', 16, 1491567690),
(493, 'insert', 332, 'time_1.lua', 16, 1491567852);

-- --------------------------------------------------------

--
-- 表的结构 `sltx_xxx_user_strategy_table`
--

CREATE TABLE IF NOT EXISTS `sltx_xxx_user_strategy_table` (
  `id` int(32) NOT NULL COMMENT '自增id',
  `user_id` int(32) NOT NULL COMMENT '用户ID',
  `user_type` varchar(16) NOT NULL COMMENT '用户类型',
  `strategy_id` int(32) NOT NULL COMMENT '绑定的策略',
  `file_id` int(11) DEFAULT NULL,
  `user_config` text NOT NULL COMMENT '用户配置数据',
  `user_config_path` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COMMENT='用户的策略&数据表';

--
-- 转存表中的数据 `sltx_xxx_user_strategy_table`
--

INSERT INTO `sltx_xxx_user_strategy_table` (`id`, `user_id`, `user_type`, `strategy_id`, `file_id`, `user_config`, `user_config_path`) VALUES
(28, 19, '', 47, 319, '{"tmp_name":["\\u7b56\\u7565\\u4e00\\u5730\\u533a\\u6027\\u52a0\\u7c89"],"strategy":["1"],"pre_fix_phone_numb":["1865571"],"gongzhonghao":["\\u987a\\u8054\\u5929\\u4e0b","\\u6cd7\\u53bf\\u5546\\u5bb6\\u6d3b\\u52a8\\u9884\\u77e5"],"text_yanzheng":["\\u4f60\\u597d\\u5440","\\u54c8\\u55bd","\\u55e8","\\u4f60\\u597d"],"text_zhaohu":["\\u4f60\\u597d\\u5440","\\u54c8\\u55bd","\\u55e8","\\u4f60\\u597d"],"text_pengyou":["\\u300a\\uf8ff\\u300b\\u5fae\\u20dd\\u4fe1\\u20dd"],"gps_x":["40.046081","29.281445","30.632163","23.142756","32.071182","39.932892"],"gps_y":["116.625676","106.371483","104.149147","113.264432","118.783908","116.444108"],"place":["\\u5317\\u4eac","\\u91cd\\u5e86","\\u6210\\u90fd","\\u5e7f\\u5dde","\\u5357\\u4eac","\\u5317\\u4eac\\u671d\\u9633"],"text_gerenmingpian":["\\u300a\\uf8ff\\u300b\\u5fae\\u20dd\\u4fe1\\u20dd"],"text_huifu":["\\u4f60\\u597d","\\u5173\\u6ce8\\u4e00\\u4e0b\\u8fd9\\u4e2a\\u540d\\u7247\\u4f60\\u4f1a\\u7528\\u5230\\u7684","(\\uff61\\uff65\\u2200\\uff65)\\uff89\\uff9e\\u55e8"],"text_gzhmingpian":["\\u987a\\u8054\\u5929\\u4e0b","\\u6cd7\\u53bf\\u5546\\u5bb6\\u6d3b\\u52a8\\u9884\\u77e5"]}', 'http://oss.temaiol.com/memberlua/1/20170403/19_47_20170403060021637.lua'),
(26, 11, '', 28, 279, '{"tmp_name":["\\u7b56\\u7565\\u4e00\\u5730\\u533a\\u6027\\u52a0\\u7c89"],"pre_fix_phone_numb":["1865571"],"gongzhonghao":[],"text_zhaohu":["\\u4f60\\u597d\\u5440","\\u55e8","\\u54c8\\u55bd"],"text_pengyou":["eeee","sdsds","78299"],"gps_x":["40.046081","29.281445","30.6342163","23.142756","32.071182"],"gps_y":["116.625676","106.371483","104.149147","113.264432","118.783908"],"text_yanzheng":["\\u6253\\u62db\\u547c\\u5185\\u5bb9","\\u4f60\\u597d\\u5440","\\u55e8","\\u54c8\\u55bd"]}', 'http://oss.temaiol.com/memberlua/1/20170329/11_28_20170329063135521.lua'),
(25, 13, '', 28, 250, '{"tmp_name":["\\u7b56\\u7565\\u4e00\\u5730\\u533a\\u6027\\u52a0\\u7c89"],"pre_fix_phone_numb":["1865571"],"gongzhonghao":[],"text_zhaohu":["\\u4f60\\u597d\\u5440","\\u55e8","\\u54c8\\u55bd"],"text_pengyou":["eeee","sdsds","78299"],"gps_x":["40.046081","29.281445","30.6342163","23.142756","32.071182"],"gps_y":["116.625676","106.371483","104.149147","113.264432","118.783908"],"text_yanzheng":["\\u6253\\u62db\\u547c\\u5185\\u5bb9","\\u4f60\\u597d\\u5440","\\u55e8","\\u54c8\\u55bd"]}', 'http://oss.temaiol.com/memberlua/1/20170328/13_28_20170328080416242.lua'),
(24, 13, '', 26, 230, '{"tmp_name":["\\u7b56\\u7565\\u4e00\\u5730\\u533a\\u6027\\u52a0\\u7c89"],"pre_fix_phone_numb":["1865571"],"gongzhonghao":[],"text_zhaohu":["\\u4f60\\u597d\\u5440","\\u55e8","\\u54c8\\u55bd"],"text_pengyou":["eeee","sdsds","78299"],"gps_x":["40.046081","29.281445","30.6342163","23.142756","32.071182"],"gps_y":["116.625676","106.371483","104.149147","113.264432","118.783908"],"text_yanzheng":["\\u6253\\u62db\\u547c\\u5185\\u5bb9","\\u4f60\\u597d\\u5440","\\u55e8","\\u54c8\\u55bd"]}', 'http://oss.temaiol.com/memberlua/1/20170328/13_26_20170328071118820.lua'),
(23, 13, '', 24, 215, '{"tmp_name":["\\u52a0\\u7c89"],"mp_id":["xxxx_11","yyyy_221","kobe_huang"],"iphone_num":["18600000001","18600000002","18600000003","18600000004","18600000005","18600000006","18600000007","18600000008"],"position_x":["124.79968","134.79968","114.79968"],"position_y":["23.246656","23.246656","23.246656"],"num_strag":["186234","121222","121223"]}', 'http://oss.temaiol.com/memberlua/1/20170327/13_24_20170327083352970.lua'),
(27, 16, '', 44, 288, '{"tmp_name":["\\u7b56\\u7565\\u4e8c\\u7cbe\\u786e\\u52a0\\u7c89"],"strategy":["1"],"gongzhonghao":["\\u987a\\u8054\\u5929\\u4e0b","\\u6dd8\\u5b9d","\\u4eac\\u4e1c","\\u552f\\u54c1\\u4f1a"],"text_zhaohu":["\\u4f60\\u597d\\u5440","\\u54c8\\u55bd","\\u55e8","\\u4f60\\u597d"],"text_pengyou":["\\u300a\\uf8ff\\u300b\\u5fae\\u20dd\\u4fe1\\u20dd"],"phone_num":["13006663353","13006664527","13006664219","13006664206","13006664116","13006663772","13006663754","13006663570","13006663376","13006663360","13006663353","13006663317","13006663236","13006663179","13006663133","13006662921","13006662893","13006655095","13006660832","13006660522"],"text_yanzheng":["\\u4f60\\u597d\\u5440","\\u54c8\\u55bd","\\u55e8","\\u4f60\\u597d"],"text_pengyouquan":["\\u4eca\\u5929\\u5929\\u6c14\\u771f\\u597d","\\u4eca\\u5929\\u653e\\u5047\\u771f\\u723d","\\u4eca\\u5929\\u597d\\u5f00\\u5fc3\\uff0c\\u54c8\\u54c8\\u54c8"],"GPS_X":["40.046081","29.281445","30.632163","23.142756","32.071182","39.932892"],"GPS_Y":["116.625676","106.371483","104.149147","113.264432","118.783908","116.444108"],"place":["\\u5317\\u4eac","\\u91cd\\u5e86","\\u6210\\u90fd","\\u5e7f\\u5dde","\\u5357\\u4eac","\\u5317\\u4eac\\u671d\\u9633"]}', 'http://oss.temaiol.com/memberlua/1/20170331/16_44_20170331063800882.lua');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sltx_account`
--
ALTER TABLE `sltx_account`
  ADD PRIMARY KEY (`acid`),
  ADD KEY `idx_uniacid` (`uniacid`);

--
-- Indexes for table `sltx_account_wechats`
--
ALTER TABLE `sltx_account_wechats`
  ADD PRIMARY KEY (`acid`),
  ADD KEY `idx_key` (`key`);

--
-- Indexes for table `sltx_activity_clerks`
--
ALTER TABLE `sltx_activity_clerks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `password` (`password`),
  ADD KEY `openid` (`openid`);

--
-- Indexes for table `sltx_activity_clerk_menu`
--
ALTER TABLE `sltx_activity_clerk_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_activity_coupon_allocation`
--
ALTER TABLE `sltx_activity_coupon_allocation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`couponid`,`groupid`);

--
-- Indexes for table `sltx_activity_coupon_modules`
--
ALTER TABLE `sltx_activity_coupon_modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `couponid` (`couponid`);

--
-- Indexes for table `sltx_activity_exchange`
--
ALTER TABLE `sltx_activity_exchange`
  ADD PRIMARY KEY (`id`),
  ADD KEY `extra` (`extra`(333));

--
-- Indexes for table `sltx_activity_exchange_trades`
--
ALTER TABLE `sltx_activity_exchange_trades`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `uniacid` (`uniacid`,`uid`,`exid`);

--
-- Indexes for table `sltx_activity_exchange_trades_shipping`
--
ALTER TABLE `sltx_activity_exchange_trades_shipping`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `sltx_activity_modules`
--
ALTER TABLE `sltx_activity_modules`
  ADD PRIMARY KEY (`mid`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `module` (`module`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `sltx_activity_modules_record`
--
ALTER TABLE `sltx_activity_modules_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mid` (`mid`);

--
-- Indexes for table `sltx_activity_stores`
--
ALTER TABLE `sltx_activity_stores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `sltx_article_category`
--
ALTER TABLE `sltx_article_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `sltx_article_news`
--
ALTER TABLE `sltx_article_news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `title` (`title`),
  ADD KEY `cateid` (`cateid`);

--
-- Indexes for table `sltx_article_notice`
--
ALTER TABLE `sltx_article_notice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `title` (`title`),
  ADD KEY `cateid` (`cateid`);

--
-- Indexes for table `sltx_article_unread_notice`
--
ALTER TABLE `sltx_article_unread_notice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `notice_id` (`notice_id`);

--
-- Indexes for table `sltx_basic_reply`
--
ALTER TABLE `sltx_basic_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_business`
--
ALTER TABLE `sltx_business`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_lat_lng` (`lng`,`lat`);

--
-- Indexes for table `sltx_core_attachment`
--
ALTER TABLE `sltx_core_attachment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_core_cache`
--
ALTER TABLE `sltx_core_cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `sltx_core_cron`
--
ALTER TABLE `sltx_core_cron`
  ADD PRIMARY KEY (`id`),
  ADD KEY `createtime` (`createtime`),
  ADD KEY `nextruntime` (`nextruntime`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `cloudid` (`cloudid`);

--
-- Indexes for table `sltx_core_cron_record`
--
ALTER TABLE `sltx_core_cron_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `tid` (`tid`),
  ADD KEY `module` (`module`);

--
-- Indexes for table `sltx_core_menu`
--
ALTER TABLE `sltx_core_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_core_paylog`
--
ALTER TABLE `sltx_core_paylog`
  ADD PRIMARY KEY (`plid`),
  ADD KEY `idx_openid` (`openid`),
  ADD KEY `idx_tid` (`tid`),
  ADD KEY `idx_uniacid` (`uniacid`),
  ADD KEY `uniontid` (`uniontid`);

--
-- Indexes for table `sltx_core_performance`
--
ALTER TABLE `sltx_core_performance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_core_queue`
--
ALTER TABLE `sltx_core_queue`
  ADD PRIMARY KEY (`qid`),
  ADD KEY `uniacid` (`uniacid`,`acid`),
  ADD KEY `module` (`module`),
  ADD KEY `dateline` (`dateline`);

--
-- Indexes for table `sltx_core_resource`
--
ALTER TABLE `sltx_core_resource`
  ADD PRIMARY KEY (`mid`),
  ADD KEY `acid` (`uniacid`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `sltx_core_sendsms_log`
--
ALTER TABLE `sltx_core_sendsms_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_core_sessions`
--
ALTER TABLE `sltx_core_sessions`
  ADD PRIMARY KEY (`sid`);

--
-- Indexes for table `sltx_core_settings`
--
ALTER TABLE `sltx_core_settings`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `sltx_coupon`
--
ALTER TABLE `sltx_coupon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`acid`);

--
-- Indexes for table `sltx_coupon_activity`
--
ALTER TABLE `sltx_coupon_activity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_coupon_groups`
--
ALTER TABLE `sltx_coupon_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_coupon_location`
--
ALTER TABLE `sltx_coupon_location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`acid`);

--
-- Indexes for table `sltx_coupon_modules`
--
ALTER TABLE `sltx_coupon_modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`acid`),
  ADD KEY `couponid` (`couponid`);

--
-- Indexes for table `sltx_coupon_record`
--
ALTER TABLE `sltx_coupon_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`acid`),
  ADD KEY `card_id` (`card_id`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `sltx_coupon_store`
--
ALTER TABLE `sltx_coupon_store`
  ADD PRIMARY KEY (`id`),
  ADD KEY `couponid` (`couponid`);

--
-- Indexes for table `sltx_cover_reply`
--
ALTER TABLE `sltx_cover_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_custom_reply`
--
ALTER TABLE `sltx_custom_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_images_reply`
--
ALTER TABLE `sltx_images_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_mc_card`
--
ALTER TABLE `sltx_mc_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_mc_card_care`
--
ALTER TABLE `sltx_mc_card_care`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_mc_card_credit_set`
--
ALTER TABLE `sltx_mc_card_credit_set`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_mc_card_members`
--
ALTER TABLE `sltx_mc_card_members`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_mc_card_notices`
--
ALTER TABLE `sltx_mc_card_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `sltx_mc_card_notices_unread`
--
ALTER TABLE `sltx_mc_card_notices_unread`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `notice_id` (`notice_id`);

--
-- Indexes for table `sltx_mc_card_recommend`
--
ALTER TABLE `sltx_mc_card_recommend`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_mc_card_record`
--
ALTER TABLE `sltx_mc_card_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `addtime` (`addtime`);

--
-- Indexes for table `sltx_mc_card_sign_record`
--
ALTER TABLE `sltx_mc_card_sign_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `sltx_mc_cash_record`
--
ALTER TABLE `sltx_mc_cash_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `sltx_mc_chats_record`
--
ALTER TABLE `sltx_mc_chats_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`acid`),
  ADD KEY `openid` (`openid`),
  ADD KEY `createtime` (`createtime`);

--
-- Indexes for table `sltx_mc_credits_recharge`
--
ALTER TABLE `sltx_mc_credits_recharge`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_uniacid_uid` (`uniacid`,`uid`),
  ADD KEY `idx_tid` (`tid`);

--
-- Indexes for table `sltx_mc_credits_record`
--
ALTER TABLE `sltx_mc_credits_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `sltx_mc_fans_groups`
--
ALTER TABLE `sltx_mc_fans_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_mc_fans_tag_mapping`
--
ALTER TABLE `sltx_mc_fans_tag_mapping`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mapping` (`fanid`,`tagid`),
  ADD KEY `fanid_index` (`fanid`),
  ADD KEY `tagid_index` (`tagid`);

--
-- Indexes for table `sltx_mc_groups`
--
ALTER TABLE `sltx_mc_groups`
  ADD PRIMARY KEY (`groupid`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_mc_handsel`
--
ALTER TABLE `sltx_mc_handsel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`touid`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_mc_mapping_fans`
--
ALTER TABLE `sltx_mc_mapping_fans`
  ADD PRIMARY KEY (`fanid`),
  ADD UNIQUE KEY `openid` (`openid`),
  ADD KEY `acid` (`acid`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `nickname` (`nickname`),
  ADD KEY `updatetime` (`updatetime`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `sltx_mc_mapping_ucenter`
--
ALTER TABLE `sltx_mc_mapping_ucenter`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_mc_mass_record`
--
ALTER TABLE `sltx_mc_mass_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`acid`);

--
-- Indexes for table `sltx_mc_members`
--
ALTER TABLE `sltx_mc_members`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `groupid` (`groupid`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `email` (`email`),
  ADD KEY `mobile` (`mobile`);

--
-- Indexes for table `sltx_mc_member_address`
--
ALTER TABLE `sltx_mc_member_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_uinacid` (`uniacid`),
  ADD KEY `idx_uid` (`uid`);

--
-- Indexes for table `sltx_mc_member_fields`
--
ALTER TABLE `sltx_mc_member_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_uniacid` (`uniacid`),
  ADD KEY `idx_fieldid` (`fieldid`);

--
-- Indexes for table `sltx_mc_member_property`
--
ALTER TABLE `sltx_mc_member_property`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_mc_oauth_fans`
--
ALTER TABLE `sltx_mc_oauth_fans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_oauthopenid_acid` (`oauth_openid`,`acid`);

--
-- Indexes for table `sltx_menu_event`
--
ALTER TABLE `sltx_menu_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `picmd5` (`picmd5`);

--
-- Indexes for table `sltx_mobilenumber`
--
ALTER TABLE `sltx_mobilenumber`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_modules`
--
ALTER TABLE `sltx_modules`
  ADD PRIMARY KEY (`mid`),
  ADD KEY `idx_name` (`name`);

--
-- Indexes for table `sltx_modules_bindings`
--
ALTER TABLE `sltx_modules_bindings`
  ADD PRIMARY KEY (`eid`),
  ADD KEY `idx_module` (`module`);

--
-- Indexes for table `sltx_modules_recycle`
--
ALTER TABLE `sltx_modules_recycle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modulename` (`modulename`);

--
-- Indexes for table `sltx_ms_alive_table`
--
ALTER TABLE `sltx_ms_alive_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_ms_allot_table`
--
ALTER TABLE `sltx_ms_allot_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_ms_setting`
--
ALTER TABLE `sltx_ms_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_ms_strategy`
--
ALTER TABLE `sltx_ms_strategy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_ms_strategy_task_list`
--
ALTER TABLE `sltx_ms_strategy_task_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_music_reply`
--
ALTER TABLE `sltx_music_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_news_reply`
--
ALTER TABLE `sltx_news_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_paycenter_order`
--
ALTER TABLE `sltx_paycenter_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_profile_fields`
--
ALTER TABLE `sltx_profile_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_qrcode`
--
ALTER TABLE `sltx_qrcode`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_qrcid` (`qrcid`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `ticket` (`ticket`);

--
-- Indexes for table `sltx_qrcode_stat`
--
ALTER TABLE `sltx_qrcode_stat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_rule`
--
ALTER TABLE `sltx_rule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_rule_keyword`
--
ALTER TABLE `sltx_rule_keyword`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_content` (`content`),
  ADD KEY `idx_rid` (`rid`),
  ADD KEY `idx_uniacid_type_content` (`uniacid`,`type`,`content`);

--
-- Indexes for table `sltx_site_article`
--
ALTER TABLE `sltx_site_article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_iscommend` (`iscommend`),
  ADD KEY `idx_ishot` (`ishot`);

--
-- Indexes for table `sltx_site_category`
--
ALTER TABLE `sltx_site_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_site_multi`
--
ALTER TABLE `sltx_site_multi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `bindhost` (`bindhost`);

--
-- Indexes for table `sltx_site_nav`
--
ALTER TABLE `sltx_site_nav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `multiid` (`multiid`);

--
-- Indexes for table `sltx_site_page`
--
ALTER TABLE `sltx_site_page`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `multiid` (`multiid`);

--
-- Indexes for table `sltx_site_slide`
--
ALTER TABLE `sltx_site_slide`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `multiid` (`multiid`);

--
-- Indexes for table `sltx_site_styles`
--
ALTER TABLE `sltx_site_styles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_site_styles_vars`
--
ALTER TABLE `sltx_site_styles_vars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_site_templates`
--
ALTER TABLE `sltx_site_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_stat_fans`
--
ALTER TABLE `sltx_stat_fans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`,`date`);

--
-- Indexes for table `sltx_stat_keyword`
--
ALTER TABLE `sltx_stat_keyword`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_createtime` (`createtime`);

--
-- Indexes for table `sltx_stat_msg_history`
--
ALTER TABLE `sltx_stat_msg_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_createtime` (`createtime`);

--
-- Indexes for table `sltx_stat_rule`
--
ALTER TABLE `sltx_stat_rule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_createtime` (`createtime`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_uni_account`
--
ALTER TABLE `sltx_uni_account`
  ADD PRIMARY KEY (`uniacid`);

--
-- Indexes for table `sltx_uni_account_group`
--
ALTER TABLE `sltx_uni_account_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_uni_account_menus`
--
ALTER TABLE `sltx_uni_account_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `menuid` (`menuid`);

--
-- Indexes for table `sltx_uni_account_modules`
--
ALTER TABLE `sltx_uni_account_modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_module` (`module`),
  ADD KEY `idx_uniacid` (`uniacid`);

--
-- Indexes for table `sltx_uni_account_users`
--
ALTER TABLE `sltx_uni_account_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_memberid` (`uid`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_uni_group`
--
ALTER TABLE `sltx_uni_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`);

--
-- Indexes for table `sltx_uni_settings`
--
ALTER TABLE `sltx_uni_settings`
  ADD PRIMARY KEY (`uniacid`);

--
-- Indexes for table `sltx_uni_verifycode`
--
ALTER TABLE `sltx_uni_verifycode`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_userapi_cache`
--
ALTER TABLE `sltx_userapi_cache`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_userapi_reply`
--
ALTER TABLE `sltx_userapi_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_users`
--
ALTER TABLE `sltx_users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `sltx_users_failed_login`
--
ALTER TABLE `sltx_users_failed_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip_username` (`ip`,`username`);

--
-- Indexes for table `sltx_users_group`
--
ALTER TABLE `sltx_users_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_users_invitation`
--
ALTER TABLE `sltx_users_invitation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_code` (`code`);

--
-- Indexes for table `sltx_users_permission`
--
ALTER TABLE `sltx_users_permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_users_profile`
--
ALTER TABLE `sltx_users_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_video_reply`
--
ALTER TABLE `sltx_video_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_voice_reply`
--
ALTER TABLE `sltx_voice_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_wechat_attachment`
--
ALTER TABLE `sltx_wechat_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `media_id` (`media_id`),
  ADD KEY `acid` (`acid`);

--
-- Indexes for table `sltx_wechat_news`
--
ALTER TABLE `sltx_wechat_news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uniacid` (`uniacid`),
  ADD KEY `attach_id` (`attach_id`);

--
-- Indexes for table `sltx_wxcard_reply`
--
ALTER TABLE `sltx_wxcard_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `sltx_xsy_resource_file`
--
ALTER TABLE `sltx_xsy_resource_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_xsy_resource_file_log`
--
ALTER TABLE `sltx_xsy_resource_file_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sltx_xxx_user_strategy_table`
--
ALTER TABLE `sltx_xxx_user_strategy_table`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sltx_account`
--
ALTER TABLE `sltx_account`
  MODIFY `acid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_activity_clerks`
--
ALTER TABLE `sltx_activity_clerks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_clerk_menu`
--
ALTER TABLE `sltx_activity_clerk_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `sltx_activity_coupon_allocation`
--
ALTER TABLE `sltx_activity_coupon_allocation`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_coupon_modules`
--
ALTER TABLE `sltx_activity_coupon_modules`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_exchange`
--
ALTER TABLE `sltx_activity_exchange`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_exchange_trades`
--
ALTER TABLE `sltx_activity_exchange_trades`
  MODIFY `tid` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_exchange_trades_shipping`
--
ALTER TABLE `sltx_activity_exchange_trades_shipping`
  MODIFY `tid` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_modules`
--
ALTER TABLE `sltx_activity_modules`
  MODIFY `mid` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_modules_record`
--
ALTER TABLE `sltx_activity_modules_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_activity_stores`
--
ALTER TABLE `sltx_activity_stores`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_article_category`
--
ALTER TABLE `sltx_article_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_article_news`
--
ALTER TABLE `sltx_article_news`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_article_notice`
--
ALTER TABLE `sltx_article_notice`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_article_unread_notice`
--
ALTER TABLE `sltx_article_unread_notice`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_basic_reply`
--
ALTER TABLE `sltx_basic_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_business`
--
ALTER TABLE `sltx_business`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_core_attachment`
--
ALTER TABLE `sltx_core_attachment`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_core_cron`
--
ALTER TABLE `sltx_core_cron`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_core_cron_record`
--
ALTER TABLE `sltx_core_cron_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_core_menu`
--
ALTER TABLE `sltx_core_menu`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=90;
--
-- AUTO_INCREMENT for table `sltx_core_paylog`
--
ALTER TABLE `sltx_core_paylog`
  MODIFY `plid` bigint(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_core_performance`
--
ALTER TABLE `sltx_core_performance`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_core_queue`
--
ALTER TABLE `sltx_core_queue`
  MODIFY `qid` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_core_resource`
--
ALTER TABLE `sltx_core_resource`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_core_sendsms_log`
--
ALTER TABLE `sltx_core_sendsms_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_coupon`
--
ALTER TABLE `sltx_coupon`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_coupon_activity`
--
ALTER TABLE `sltx_coupon_activity`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_coupon_groups`
--
ALTER TABLE `sltx_coupon_groups`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_coupon_location`
--
ALTER TABLE `sltx_coupon_location`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_coupon_modules`
--
ALTER TABLE `sltx_coupon_modules`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_coupon_record`
--
ALTER TABLE `sltx_coupon_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_coupon_store`
--
ALTER TABLE `sltx_coupon_store`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_cover_reply`
--
ALTER TABLE `sltx_cover_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_custom_reply`
--
ALTER TABLE `sltx_custom_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_images_reply`
--
ALTER TABLE `sltx_images_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card`
--
ALTER TABLE `sltx_mc_card`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_care`
--
ALTER TABLE `sltx_mc_card_care`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_credit_set`
--
ALTER TABLE `sltx_mc_card_credit_set`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_members`
--
ALTER TABLE `sltx_mc_card_members`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_notices`
--
ALTER TABLE `sltx_mc_card_notices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_notices_unread`
--
ALTER TABLE `sltx_mc_card_notices_unread`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_recommend`
--
ALTER TABLE `sltx_mc_card_recommend`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_record`
--
ALTER TABLE `sltx_mc_card_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_card_sign_record`
--
ALTER TABLE `sltx_mc_card_sign_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_cash_record`
--
ALTER TABLE `sltx_mc_cash_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_mc_chats_record`
--
ALTER TABLE `sltx_mc_chats_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_credits_recharge`
--
ALTER TABLE `sltx_mc_credits_recharge`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_credits_record`
--
ALTER TABLE `sltx_mc_credits_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `sltx_mc_fans_groups`
--
ALTER TABLE `sltx_mc_fans_groups`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_fans_tag_mapping`
--
ALTER TABLE `sltx_mc_fans_tag_mapping`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_groups`
--
ALTER TABLE `sltx_mc_groups`
  MODIFY `groupid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_mc_handsel`
--
ALTER TABLE `sltx_mc_handsel`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_mapping_fans`
--
ALTER TABLE `sltx_mc_mapping_fans`
  MODIFY `fanid` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_mapping_ucenter`
--
ALTER TABLE `sltx_mc_mapping_ucenter`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_mass_record`
--
ALTER TABLE `sltx_mc_mass_record`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_members`
--
ALTER TABLE `sltx_mc_members`
  MODIFY `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `sltx_mc_member_address`
--
ALTER TABLE `sltx_mc_member_address`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_mc_member_fields`
--
ALTER TABLE `sltx_mc_member_fields`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `sltx_mc_member_property`
--
ALTER TABLE `sltx_mc_member_property`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mc_oauth_fans`
--
ALTER TABLE `sltx_mc_oauth_fans`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_menu_event`
--
ALTER TABLE `sltx_menu_event`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_mobilenumber`
--
ALTER TABLE `sltx_mobilenumber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_modules`
--
ALTER TABLE `sltx_modules`
  MODIFY `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `sltx_modules_bindings`
--
ALTER TABLE `sltx_modules_bindings`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=42;
--
-- AUTO_INCREMENT for table `sltx_modules_recycle`
--
ALTER TABLE `sltx_modules_recycle`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `sltx_ms_alive_table`
--
ALTER TABLE `sltx_ms_alive_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `sltx_ms_allot_table`
--
ALTER TABLE `sltx_ms_allot_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1449;
--
-- AUTO_INCREMENT for table `sltx_ms_setting`
--
ALTER TABLE `sltx_ms_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_ms_strategy`
--
ALTER TABLE `sltx_ms_strategy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT for table `sltx_ms_strategy_task_list`
--
ALTER TABLE `sltx_ms_strategy_task_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=530;
--
-- AUTO_INCREMENT for table `sltx_music_reply`
--
ALTER TABLE `sltx_music_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_news_reply`
--
ALTER TABLE `sltx_news_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_paycenter_order`
--
ALTER TABLE `sltx_paycenter_order`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_profile_fields`
--
ALTER TABLE `sltx_profile_fields`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `sltx_qrcode`
--
ALTER TABLE `sltx_qrcode`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_qrcode_stat`
--
ALTER TABLE `sltx_qrcode_stat`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_rule`
--
ALTER TABLE `sltx_rule`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `sltx_rule_keyword`
--
ALTER TABLE `sltx_rule_keyword`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `sltx_site_article`
--
ALTER TABLE `sltx_site_article`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_site_category`
--
ALTER TABLE `sltx_site_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_site_multi`
--
ALTER TABLE `sltx_site_multi`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_site_nav`
--
ALTER TABLE `sltx_site_nav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_site_page`
--
ALTER TABLE `sltx_site_page`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_site_slide`
--
ALTER TABLE `sltx_site_slide`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_site_styles`
--
ALTER TABLE `sltx_site_styles`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_site_styles_vars`
--
ALTER TABLE `sltx_site_styles_vars`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_site_templates`
--
ALTER TABLE `sltx_site_templates`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_stat_fans`
--
ALTER TABLE `sltx_stat_fans`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `sltx_stat_keyword`
--
ALTER TABLE `sltx_stat_keyword`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_stat_msg_history`
--
ALTER TABLE `sltx_stat_msg_history`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_stat_rule`
--
ALTER TABLE `sltx_stat_rule`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_uni_account`
--
ALTER TABLE `sltx_uni_account`
  MODIFY `uniacid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_uni_account_group`
--
ALTER TABLE `sltx_uni_account_group`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_uni_account_menus`
--
ALTER TABLE `sltx_uni_account_menus`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_uni_account_modules`
--
ALTER TABLE `sltx_uni_account_modules`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `sltx_uni_account_users`
--
ALTER TABLE `sltx_uni_account_users`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_uni_group`
--
ALTER TABLE `sltx_uni_group`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_uni_verifycode`
--
ALTER TABLE `sltx_uni_verifycode`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_userapi_cache`
--
ALTER TABLE `sltx_userapi_cache`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_userapi_reply`
--
ALTER TABLE `sltx_userapi_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `sltx_users`
--
ALTER TABLE `sltx_users`
  MODIFY `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sltx_users_failed_login`
--
ALTER TABLE `sltx_users_failed_login`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT for table `sltx_users_group`
--
ALTER TABLE `sltx_users_group`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sltx_users_invitation`
--
ALTER TABLE `sltx_users_invitation`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_users_permission`
--
ALTER TABLE `sltx_users_permission`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sltx_users_profile`
--
ALTER TABLE `sltx_users_profile`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sltx_video_reply`
--
ALTER TABLE `sltx_video_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_voice_reply`
--
ALTER TABLE `sltx_voice_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_wechat_attachment`
--
ALTER TABLE `sltx_wechat_attachment`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_wechat_news`
--
ALTER TABLE `sltx_wechat_news`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_wxcard_reply`
--
ALTER TABLE `sltx_wxcard_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sltx_xsy_resource_file`
--
ALTER TABLE `sltx_xsy_resource_file`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=333;
--
-- AUTO_INCREMENT for table `sltx_xsy_resource_file_log`
--
ALTER TABLE `sltx_xsy_resource_file_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=494;
--
-- AUTO_INCREMENT for table `sltx_xxx_user_strategy_table`
--
ALTER TABLE `sltx_xxx_user_strategy_table`
  MODIFY `id` int(32) NOT NULL AUTO_INCREMENT COMMENT '自增id',AUTO_INCREMENT=29;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
