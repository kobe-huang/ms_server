<?php defined('IN_IA') or exit('Access Denied');?><html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css"
	href="../addons/xsy_resource/template/static/css/base.css?v=2.0.9" />
<link rel="stylesheet" type="text/css"
	href="../addons/xsy_resource/template/static/css/style.css?v=2.0.13" />
</head>
<style>
#shareit {
	-webkit-user-select: none;
	display: none;
	position: absolute;
	width: 100%;
	height: 100%;
	background: #888786;
	text-align: center;
	top: 0;
	left: 0;
	z-index: 105;
}

#shareit img {
	max-width: 100%;
}

.arrow {
	position: absolute;
	right: 10%;
	top: 5%;
}
</style>
</head>
<body>
	<div class="contaniner fixed-contb">
	<section class="detail">
	<article class="detail-article">
			<nav>
				<ul>
					<li id="contents" style="font-size:50px;"><?php  echo $file['name'];?></li>
				</ul>
			</nav>
	</article>
	</section>
	</div>
	 <?php  if($isweixin) { ?>
	 <div id="shareit">
		<a href="#" id="follow"> <img width="100%" height="100%"
			id="share-text" src="<?php echo XSY_RESOURCE_STATIC;?>/images/001.png">
		</a>
	</div>
	<script src="http://libs.baidu.com/jquery/1.9.0/jquery.min.js"></script>
	<script>
	$(function(){
		$("#share_btn").on("click", function() {
			$("#shareit").show();
		});

		$("#shareit").on("click", function() {
			$("#shareit").hide();
		})
	});
	</script>
	<footer class="detail-footer fixed-footer">
	<a id="share_btn" href="####" class="storebuy">去下载</a>
	</footer>
	
	<?php  } else { ?>
	<footer class="detail-footer fixed-footer">
	<a href="<?php  echo $file['path'];?>" class="storebuy">去下载</a>
	</footer>
	 <?php  } ?>
<script>var imgs = document.getElementsByTagName('img');for(var i=0, len=imgs.length; i < len; i++){imgs[i].onerror = function() {if (!this.getAttribute('check-src') && (this.src.indexOf('http://') > -1 || this.src.indexOf('https://') > -1)) {this.src = this.src.indexOf('http://120.76.215.162/sl_base/attachment/') == -1 ? this.src.replace('http://oss.temaiol.com/', 'http://120.76.215.162/sl_base/attachment/') : this.src.replace('http://120.76.215.162/sl_base/attachment/', 'http://oss.temaiol.com/');this.setAttribute('check-src', true);}}}</script></body>
</html>
