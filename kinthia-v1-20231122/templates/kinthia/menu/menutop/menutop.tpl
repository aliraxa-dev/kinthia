<!-- Start Menu -->

<!-- Start icone menu -->
<label for="main-nav-check" class="toggle smallmenu" onclick="" title="Menu">&#x2261;</label>
<!-- End icone menu -->

{assign var="baseUrl" value='https://preprod.larboretumlacude.fr/'}

<input type="checkbox" name="nav" id="main-nav-check"/>
<div id="menu">
	<label for="main-nav-check" class="toggle close" onclick="" title="Fermer">&times;</label>
	<ul>
		<li><a href={$baseUrl}>Accueil</a></li>
		<li class="current"><a href={$baseUrl."/tirage-voyance/"}>Consultation de voyance</a></li>

		<li><a href={$baseUrl."arts-divinatoires/divination.php"}>Arts divinatoires</a> <label for="fof" class="toggle-sub" onclick="">&#9658;</label>
			<input type="checkbox" name="nav" id="fof" class="sub-nav-check"/>
				<ul id="fof-sub" class="sub-nav">
					<li class="sub-heading"><a href="https://www.kinthia.com/arts-divinatoires/divination.php">Arts divinatoires</a> <label for="fof" class="toggle back" onclick="" title="Retour">&#9658;</label></li>
						<ul class="dropotron">
							<li><a href={$baseUrl."oracles/introduction.php"}>Oracles</a></li>
							<li><a href={$baseUrl."pendule/pendule.php"}>Pendule</a></li>
							<li><a href={$baseUrl."jeu-de-32-cartes/signification.php"}>Jeu de 32 cartes</a></li>
						</ul>
				</ul>
		</li>

		<li><span>Dossiers</span> <label for="fast-apps" class="toggle-sub" onclick="">&#9658;</label>
		<input type="checkbox" name="nav" id="fast-apps" class="sub-nav-check"/>
			<ul id="fast-apps-sub" class="sub-nav">
				<li class="sub-heading">Dossiers <label for="fast-apps" class="toggle back" onclick="" title="Retour">&#9658;</label></li>
				<ul class="dropotron">
					<li><a href={$baseUrl."/heures-miroirs/"}>Heure miroir</a></li>
					<li><a href={$baseUrl."/dossiers/pierres-cristaux.php"}>Lithothérapie</a></li>
				</ul>
			</ul>
		</li>
		
		<li><span>Contact & livre d'or</span> <label for="contact-livre" class="toggle-sub" onclick="">&#9658;</label>
		<input type="checkbox" name="nav" id="contact-livre" class="sub-nav-check"/>
			<ul id="contact-livre-sub" class="sub-nav">
				<li class="sub-heading">Contact & livre d'or <label for="contact-livre" class="toggle back" onclick="" title="Retour">&#9658;</label></li>
				<ul class="dropotron">
					<li><span class="wepmenu" data-wep="aHR0cHM6Ly93d3cua2ludGhpYS5jb20vbGl2cmUtZG9yL2d1ZXN0Ym9vay5waHA">Livre d'or</span></li>
					<li><span class="wepmenu" data-wep="aHR0cHM6Ly93d3cua2ludGhpYS5jb20vbmF2aWdhdGlvbi9jb250YWN0LnBocA">Nous contacter</span></li>
				</ul>
			</ul>
		</li>
		<li><a href="https://forum.kinthia.com/">Forum</a></li>
	</ul>
	<label class="toggle close-all close" onclick="uncheckboxes('nav')">&times;</label>

	
</div>
<!-- End Menu -->
