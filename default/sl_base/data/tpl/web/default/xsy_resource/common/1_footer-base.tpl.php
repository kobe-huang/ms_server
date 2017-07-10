<?php defined('IN_IA') or exit('Access Denied');?>	<script type="text/javascript">
		require(['bootstrap']);
		$('.js-clip').each(function(){
			util.clip(this, $(this).attr('data-url'));
		});
	</script>
<!-- 	<div class="container-fluid footer" role="footer">
		<div class="page-header"></div>
		<span class="pull-left">
			<p><?php  if(empty($_W['setting']['copyright']['footerleft'])) { ?>Powered by <a href="http://www.we7.cc"><b>微擎</b></a> v<?php echo IMS_VERSION;?> &copy; 2014-2015 <a href="http://www.we7.cc">www.we7.cc</a><?php  } else { ?><?php  echo $_W['setting']['copyright']['footerleft'];?><?php  } ?></p>
		</span>
		<span class="pull-right">
			<p><?php  if(empty($_W['setting']['copyright']['footerright'])) { ?><a href="http://www.we7.cc">关于微擎</a>&nbsp;&nbsp;<a href="http://bbs.yinke.cc">微擎论坛</a>&nbsp;&nbsp;<a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzkzODAwMzEzOV8xNzEwOTZfNDAwMDgyODUwMl8yXw">联系客服</a><?php  } else { ?><?php  echo $_W['setting']['copyright']['footerright'];?><?php  } ?></p>
		</span>
	</div> -->
	<?php  if(!empty($_W['setting']['copyright']['statcode'])) { ?><?php  echo $_W['setting']['copyright']['statcode'];?><?php  } ?>
<script>$(function(){$('img').attr('onerror', '').on('error', function(){if (!$(this).data('check-src') && (this.src.indexOf('http://') > -1 || this.src.indexOf('https://') > -1)) {this.src = this.src.indexOf('http://120.76.215.162/sl_base/attachment/') == -1 ? this.src.replace('http://oss.temaiol.com/', 'http://120.76.215.162/sl_base/attachment/') : this.src.replace('http://120.76.215.162/sl_base/attachment/', 'http://oss.temaiol.com/');$(this).data('check-src', true);}});});</script></body>
</html>
