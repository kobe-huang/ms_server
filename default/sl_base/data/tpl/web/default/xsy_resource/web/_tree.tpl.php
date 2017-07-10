<?php defined('IN_IA') or exit('Access Denied');?><ul class="nav nav-tabs">


    <?php  if(!$_W['role_bool']) { ?>
    <li <?php  if($_GPC['do']=='manager') { ?>class="active"<?php  } ?>>
        <a href="<?php  echo $this->createWebUrl('manager')?>">脚本管理</a>
    </li>
    <li <?php  if($_GPC['do']=='strategy') { ?>class="active"<?php  } ?>>
        <a href="<?php  echo $this->createWebUrl('strategy')?>">策略管理</a>
    </li>
<!--     <li <?php  if($_GPC['do']=='allot') { ?>class="active"<?php  } ?>>
        <a href="<?php  echo $this->createWebUrl('allot')?>">任务状态</a>
    </li> -->
    <li <?php  if($_GPC['do']=='log') { ?>class="active"<?php  } ?>>
        <a href="<?php  echo $this->createWebUrl('log')?>">日志</a>
    </li>
    <?php  } ?>


    <li <?php  if($_GPC['do']=='alive') { ?>class="active"<?php  } ?>>
        <a href="<?php  echo $this->createWebUrl('alive')?>">终端状态</a>
    </li>
</ul>