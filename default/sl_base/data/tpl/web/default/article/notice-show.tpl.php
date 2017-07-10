<?php defined('IN_IA') or exit('Access Denied');?><?php (!empty($this) && $this instanceof WeModuleSite || 0) ? (include $this->template('common/header-cms', TEMPLATE_INCLUDEPATH)) : (include template('common/header-cms', TEMPLATE_INCLUDEPATH));?>
<div class="notice-show container">
	<?php  if($do == 'list') { ?>
		<ol class="breadcrumb">
			<li><a href="./index.php">系统首页</a></li>
			<li><a href="<?php  echo url('article/notice-show/list');?>">公告列表</a></li>
			<li class="active"><?php  if(!$cateid) { ?>所有公告<?php  } else { ?><?php  echo $categroys[$cateid]['title'];?><?php  } ?></li>
		</ol>
		<div class="category-btn">
			<a href="<?php  echo url('article/notice-show/list');?>" class="btn <?php  if(!$cateid) { ?>btn-primary<?php  } else { ?>btn-default<?php  } ?>">所有公告</a>
			<?php  if(is_array($categroys)) { foreach($categroys as $key => $categroy) { ?>
				<?php  if($key) { ?>
					<a href="<?php  echo url('article/notice-show/list', array('cateid' => $categroy['id']));?>" class="btn <?php  if($cateid == $categroy['id']) { ?>btn-primary<?php  } else { ?>btn-default<?php  } ?>"><?php  echo $categroy['title'];?></a>
				<?php  } ?>
			<?php  } } ?>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h5>公告列表</h5>
			</div>
			<div class="panel-body">
				<ul>
					<?php  if(is_array($data)) { foreach($data as $da) { ?>
						<li><a href="<?php  echo url('article/notice-show/detail', array('id' => $da['id']));?>"><?php  echo $da['title'];?></a><span class="date"><?php  echo date('Y-m-d', $da['createtime']);?></span></li>
					<?php  } } ?>
				</ul>
			</div>
		</div>
		<?php  echo $pager;?>
	<?php  } ?>
	<?php  if($do == 'detail') { ?>
		<ol class="breadcrumb">
			<li><a href="./index.php">系统首页</a></li>
			<li class="active"><a href="<?php  echo url('article/notice-show/list');?>">公告列表</a></li>
			<li class="active"><?php  echo $notice['title'];?></li>
		</ol>
		<div class="panel panel-default">
			<div class="panel-heading text-center">
				<h6><?php  echo $notice['title'];?></h6>
				<div class="small text-center text-muted">
					<span><?php  echo date('Y-m-d H:i', $notice['createtime']);?></span>
					<span>阅读：<?php  echo $notice['click'];?>次</span>
				</div>
			</div>
			<div class="panel-body">
				<?php  echo $notice['content'];?>
			</div>
		</div>
	<?php  } ?>
</div>
<?php (!empty($this) && $this instanceof WeModuleSite || 0) ? (include $this->template('common/footer-cms', TEMPLATE_INCLUDEPATH)) : (include template('common/footer-cms', TEMPLATE_INCLUDEPATH));?>
