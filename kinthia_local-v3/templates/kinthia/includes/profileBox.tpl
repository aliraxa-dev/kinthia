<div class="connexion">
{if $session.user}
<nav class="navbar">
	<ul class="navbar-nav">
		<li class="nav-item dropdown">
		        <a class="nav-link dropdown-toggle" href="{'/user/management'|url}" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          <i class="fas fa-user"></i> Mon compte
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          <a class="dropdown-item" href="{'/user/management'|url}"><i class="fas fa-user"></i> Mon compte</a>
		          <a class="dropdown-item" href="#">Another action</a>
		          <a class="dropdown-item" href="{'/user/main/logOut'|url}">Déconnexion</a>
		        </div>
		</li>
	</ul>
</nav>
	<div>
		Temps restant<br>
			<form action="{'/cart/getUserCreditTime'|url}" method="post" id="getCreditTimeForm">
				<div class="form-row">
					<input type="hidden" name="sessUserName" value="{$session.user.name}">
					<input type="hidden" name="sessUserId" value="{$session.userId}">
				</div>
			</form>
		<div id="myTime">00h 00m 00s</div>
	</div>
{else}
<a href="{'/user/main/logIn'|url}" class="linkaccount1">{'profileBox_login_registration'|lang}</a>
{/if}
{* Old connexion / registration
<!--
{if $session.user}
<a href="{'/user/management'|url}" class="linkaccount1">
{if empty($session.user.firstName) || empty($session.user.lastName)}
Mon compte
{else}
{$session.user.name}
{/if}
</a> - <a href="{'/user/main/logOut'|url}" class="linkaccount1">Déconnexion</a>
{else}
<a href="{'/user/main/logIn'|url}" class="linkaccount1">{'profileBox_login_registration'|lang}</a>
{/if}
-->
*}
	
	<div>
		<a href="{'/cart/pack'|url}" class="btn btn-warning">
			Acheter<br>
			un pack minutes
		</a>
	</div>
</div>

<div class="basket">
<img src="{'/templates/kinthia/images/basket.png'|resurl}" alt="">

<span id="cartItemsNotEmpty" {if !$session.cart.itemsCount}style="display:none;"{/if}>

<a href="{'/cart/checkout'|resurl}" class="linkaccountnormal"><span id="cartItemsCount">{$session.cart.itemsCount}</span> <span id="cartItemsGreaterThanOne">{if $session.cart.itemsCount < 2}{'profileBox_item'|lang}{else}{'profileBox_items'|lang}{/if}</span></a>
</span>

{if !$session.cart.itemsCount}
<span id="cartItemsDescriptionEmpty">
0 article
</span>
{/if}

</div>
