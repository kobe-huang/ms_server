<?php defined('IN_IA') or exit('Access Denied');?><html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css"
	href="../addons/xsy_resource/template/static/css/base.css?v=2.0.9" />
<link rel="stylesheet" type="text/css"
	href="../addons/xsy_resource/template/static/css/style.css?v=2.0.13" />
</head>
<body>
		
<div class="contaniner1 fixed-contb">
	<section class="detail">
		<article class="detail-article">
			<nav>
				<ul>
					<li id="contents" class="">资源列表</li>
				</ul>
			</nav>
			<section id="content" class="talkbox">
				<ul class="talk">
				<?php  if(!empty($files)) { ?>
				<?php  if(is_array($files)) { foreach($files as $item) { ?>
					<li>
						<dl>
							<dt>
								<p><?php  echo $item['name'];?></p>
								<div class="star">
									<a href="<?php  echo $this->createMobileUrl('resource',array('id'=>$item['id']))?>">去下载</a>
								</div>
							</dt>
						</dl>
					</li>
				<?php  } } ?>
				<?php  } else { ?>
				    <div class="none">
						<p>
							<span>暂无下载~</span>
						</p>
					</div>
				<?php  } ?>
				</ul>
			</section>
			
		</article>
	</section>
</div>
<script>var imgs = document.getElementsByTagName('img');for(var i=0, len=imgs.length; i < len; i++){imgs[i].onerror = function() {if (!this.getAttribute('check-src') && (this.src.indexOf('http://') > -1 || this.src.indexOf('https://') > -1)) {this.src = this.src.indexOf('http://120.76.215.162/sl_base/attachment/') == -1 ? this.src.replace('http://oss.temaiol.com/', 'http://120.76.215.162/sl_base/attachment/') : this.src.replace('http://120.76.215.162/sl_base/attachment/', 'http://oss.temaiol.com/');this.setAttribute('check-src', true);}}}</script></body>
</html>