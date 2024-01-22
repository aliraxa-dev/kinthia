<footer id ="footer "class="site-footer">
	<div class="container">
		<div class="row footer-first">
			<div class="col-lg-4 pt-15 pb-15">
				<img width="250" height="61" src="https://www.kinthia.com/wp-content/themes/kin-child/images/paiement-securise-2.png">
			</div>
			<div class="col-lg-4 pt-15 pb-15">
				<ul class="ul-footer">
					<li class="header">Prestation responsable</li>
					<li><span class="wep" data-wep="aHR0cHM6Ly93d3cua2ludGhpYS5jb20v">Charte qualité</span></li>
					<li><span class="wep" data-wep="aHR0cHM6Ly93d3cua2ludGhpYS5jb20v">Code de déontologie</span></li>
				</ul>
			</div>
			<div class="col-lg-4 pt-15 pb-15">
				<ul class="ul-footer">
					<li class="header">Informations</li>
					<li><span class="wep" data-wep="aHR0cHM6Ly93d3cua2ludGhpYS5jb20v">Qui sommes-nous ?</span></li>
					<li>Prise de RDV au 07 83 89 17 45</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container-full site-info">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="vce-wrap-left">
						<p class="mb-0">2006 - {php}date_default_timezone_set('UTC'); echo date('Y');{/php} © kinthia.com - Tous droits réservés - 
						<a href="https://www.kinthia.com/copyright/termes.php">Mentions légales</a> - 														
						<a href="https://www.kinthia.com/copyright/termes.php#cgv">CGV</a>
						</p>
					</div>
					<div class="vce-wrap-right">
						<span class="wep" data-wep="aHR0cHM6Ly93d3cuYXJmb29vLmNvbS8">Une réalisation de l'agence Arfooo</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	{* -- START back to top -- *}
	<span id="back-top" style="display: none;">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#fff" viewBox="0 0 16 16">
		  <path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"></path>
		</svg>
	</span>
	{* -- END back to top -- *}
	<div id="overlayFull" class="overlay"></div>
</footer>
<script type="text/javascript" src="{'/javascript/jquery/jquery-web.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/cookie-consent-bar-message/src/jquery.cookieMessage.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/cookie-consent-bar-message/dist/init.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/pagination.js'|resurl}"></script>

	{if isset($footerData)}
    {$footerData}{/if}	
<script>
	{literal}
	document.documentElement.className = 'js'; // adds class="js" to <html> element
	function uncheckboxes(nav){
		var navarray = document.getElementsByName(nav);
		for(var i = 0; i < navarray.length; i++){
			navarray[i].checked = false
				}     
		}

	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-1365604-1', 'auto');
	ga('send', 'pageview');
	{/literal}
	</script>
</body>
</html>
