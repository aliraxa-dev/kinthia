<!doctype html>
<html class="no-js" lang="fr">
	<head>
		<title>{$title}</title>

		<meta charset="UTF-8">
		<meta name="description" content="{if !empty($metaDescription)}{$metaDescription}{else}{$title}{/if}" />

		{if !empty($metaKeywords)}
			<meta name="keywords" content="{$metaKeywords}" />
		{else} 
		{/if} 
		
		<meta name="robots" content="{if !empty($metaRobots)}{$metaRobots}{else}{"index, follow"}{/if}" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="msapplication-TileImage" content="favicon-144.png">
		<meta name="msapplication-TileColor" content="#FFFFFF">

		<link href="{'/templates/kinthia/assets/css/font-awesome.min.css'|resurl}" rel="stylesheet" type="text/css" />
		<link href="{'/templates/kinthia/assets/css/style.css'|resurl}" rel="stylesheet" type="text/css" />
		<link href="{'/templates/kinthia/assets/css/custom.css'|resurl}" rel="stylesheet" type="text/css" />

		<link rel="shortcut icon" href="{'/templates/kinthia/images/favicon/favicon.ico'|resurl}" type="image/x-icon">
		<link rel="icon" href="{'/templates/kinthia/images/favicon/favicon.png'|resurl}" type="image/png">
		<link rel="icon" sizes="32x32" href="{'/templates/kinthia/images/favicon/favicon-32.png'|resurl}" type="image/png">
		<link rel="icon" sizes="64x64" href="{'/templates/kinthia/images/favicon/favicon-64.png'|resurl}" type="image/png">
		<link rel="icon" sizes="96x96" href="{'/templates/kinthia/images/favicon/favicon-96.png'|resurl}" type="image/png">
		<link rel="icon" sizes="196x196" href="{'/templates/kinthia/images/favicon/favicon-196.png'|resurl}" type="image/png">
		<link rel="apple-touch-icon" sizes="152x152" href="{'/templates/kinthia/images/favicon/apple-touch-icon.png'|resurl}">
		<link rel="apple-touch-icon" sizes="60x60" href="{'/templates/kinthia/images/favicon/apple-touch-icon-60x60.png'|resurl}">
		<link rel="apple-touch-icon" sizes="76x76" href="{'/templates/kinthia/images/favicon/apple-touch-icon-76x76.png'|resurl}">
		<link rel="apple-touch-icon" sizes="114x114" href="{'/templates/kinthia/images/favicon/apple-touch-icon-114x114.png'|resurl}">
		<link rel="apple-touch-icon" sizes="120x120" href="{'/templates/kinthia/images/favicon/apple-touch-icon-120x120.png'|resurl}">
		<link rel="apple-touch-icon" sizes="144x144" href="{'/templates/kinthia/images/favicon/apple-touch-icon-144x144.png'|resurl}">

		<script type="text/javascript" src="{'/javascript/jquery/jquery.min.js'|resurl}"></script>
		<script type="text/javascript" src="{'/user/javascript/profile/photoOnLoad.js'|resurl}"></script>
		<script type="text/javascript" src="{'/javascript/main.js'|resurl}"></script>
			
		{if isset($headData)}
			{$headData}
		{/if}
	</head>

	<body>
		<header id="header" class="flex-shrink-0">
			<div class="header-nav">
				<div class="container-fluid d-flex align-items-center h-100 np-padding-mobile">
					<div id="menu-mobile">
						<span class="mobile-button-menu"></span>
					</div>
					<div class="mobile-nothing-info ">
						<span class="mobile-button-nothing"></span>
					</div>
					<div class="container d-flex justify-content-center align-items-center">
						<a class="mr-0" id="header-logo" href="/">
						<img src="{'/templates/kinthia/images/kinthia-logo-small3.png'|resurl}" class="logo-header" alt="Kinthia" width="170" height="69">
						</a>
					</div>
					<div class="mobile-user-info">
						<span class="mobile-button-user"></span>
					</div>
					<div class="mobile-shopping-cart">
						<a href="{'/cart/checkout'|resurl}">
							<span class="mobile-button-cart">
								<span id="cartItemsNotEmpty" {if !$session.cart.itemsCount}style="display:none;"{/if}>
									<span id="cartItemsCount" class="shopping-cart-products-count badge-count cartItemsGreaterThanOne">
										{$session.cart.itemsCount}{if !$session.cart.itemsCount}<span id="cartItemsDescriptionEmpty">0</span>{/if}
									</span>
								</span>
							</span>
						</a>
					</div>
				</div>
			</div>
			{include file="templates/kinthia/includes/menu/main.tpl"}
			{include file="templates/kinthia/includes/menu/login.tpl"}
		</header>
	{include file="templates/kinthia/includes/topBar.tpl"}
	{displayAd place="header"}