{* -- START Menu user logged -- *}
{if $session.user}
<div id="nav-login" class="ui-side-nav right bg3">
	<div class="ui-nav-title-logged bg1">
		Bienvenue {$session.user.name}
		<button class="close-k"></button>
	</div>
	<div class="ui-nav-block">		
	<div class="blocks">
		<div class="label">Temps de consultation restant</div>
		<form action="{'/cart/getUserCreditTime'|url}" method="post" id="getCreditTimeForm">
			<div class="form-row">
				<input type="hidden" name="sessUserName" value="{$session.user.name}">
				<input type="hidden" name="sessUserId" value="{$session.userId}">
			</div>
		</form>
		<div id="myTime">00h 00m 00s</div>
	</div>
	</div>
	<ul class="ui-nav-menu-list style3">
			<li class="btn-buy">
				<a href="{'/cart/pack'|url}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
					  <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"></path>
					</svg>
					Acheter des minutes
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-login-icon-buy-r" viewBox="0 0 16 16">
					  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"></path>
					</svg>
				</a>
			</li>
			<li class="style2">
				<a href="{'/user/management'|url}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
						<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm9 1.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4a.5.5 0 0 0-.5.5ZM9 8a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4A.5.5 0 0 0 9 8Zm1 2.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 0-1h-3a.5.5 0 0 0-.5.5Zm-1 2C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 0 2 13h6.96c.026-.163.04-.33.04-.5ZM7 6a2 2 0 1 0-4 0 2 2 0 0 0 4 0Z"></path>
					</svg>
					Mes données personnelles
				</a>
			</li>
			<li id="nav-account-orders" class="style2 nav-main-sub">
				<a>
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
				  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v1H0V4zm0 3v5a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7H0zm3 2h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-1a1 1 0 0 1 1-1z"></path>
				</svg>
					Mes paiements
				</a>
				<ul class="style3 ui-nav-menu-list-submenu">

					<li class="style3">
						<a href="{'/user/order/orderList'|url}">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
								<path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
							</svg>
							Mes paiements
						</a>
					</li>

				</ul>
			</li>
			<li class="style2">
				<a href="{'/user/order'|url}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
					  <path d="M8 1a5 5 0 0 0-5 5v1h1a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V6a6 6 0 1 1 12 0v6a2.5 2.5 0 0 1-2.5 2.5H9.366a1 1 0 0 1-.866.5h-1a1 1 0 1 1 0-2h1a1 1 0 0 1 .866.5H11.5A1.5 1.5 0 0 0 13 12h-1a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1h1V6a5 5 0 0 0-5-5z"></path>
					</svg>
					Mes consultations
				</a>
			</li>
			<li class="style2">
				<a href="{'/user/fav'|url}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"></path>
					</svg>
					Mes favoris
				</a>
			</li>
			<li class="style2">
				<a href="{'/user/alert'|url}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
					  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"></path>
					</svg>
					Mes alertes e-mail/SMS
				</a>
			</li>
			<li class="style2">
				<a href="{'/user/privateMessage'|url}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
						<path d="M2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"></path>
					</svg>
					Mes messages privés
				</a>
			</li>
			<li id="nav-account-contact" class="style2 nav-main-sub">
				<a href="#">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
						<path d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM4.5 5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7zm0 2.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7zm0 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4z"></path>
					</svg>
					Aide &amp; support
				</a>
				<ul class="style3 ui-nav-menu-list-submenu">
					<li class="style3">
						<a href="/content.php?id=121">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
								<path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
							</svg>
							Aide au paiement
						</a>
					</li>
					<li class="style3">
						<a href="/faq.php">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
								<path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
							</svg>
							Foire aux questions (FAQ)
						</a>
					</li>
					<li class="style3">
						<a href="/contact.php">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
								<path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
							</svg>
							Demande de support
						</a>
					</li>
				</ul>
			</li>
			<li class="style2 no-arrow">
				<a href="{'/user/main/logOut'|url}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="nav-main-icon-list" viewBox="0 0 16 16">
					  <path d="M6 0a.5.5 0 0 1 .5.5V3h3V.5a.5.5 0 0 1 1 0V3h1a.5.5 0 0 1 .5.5v3A3.5 3.5 0 0 1 8.5 10c-.002.434-.01.845-.04 1.22-.041.514-.126 1.003-.317 1.424a2.083 2.083 0 0 1-.97 1.028C6.725 13.9 6.169 14 5.5 14c-.998 0-1.61.33-1.974.718A1.922 1.922 0 0 0 3 16H2c0-.616.232-1.367.797-1.968C3.374 13.42 4.261 13 5.5 13c.581 0 .962-.088 1.218-.219.241-.123.4-.3.514-.55.121-.266.193-.621.23-1.09.027-.34.035-.718.037-1.141A3.5 3.5 0 0 1 4 6.5v-3a.5.5 0 0 1 .5-.5h1V.5A.5.5 0 0 1 6 0z"></path>
					</svg>
					Déconnexion
				</a>
			</li>
		</ul>	
</div>
{* -- END Menu user logged -- *}
{/if}
{* -- START Menu login - user not logged -- *}
<div id="nav-login" class="ui-side-nav right bg1">
	<div class="ui-nav-title bg1">
		Connectez-vous
		<button class="close-k"></button>
	</div>
		{* -- START form login -- *}
		<form class="nav-login-form" id="ajaxLoginForm">
		<input type="hidden" name="urlName" value="user/management" />
		{if !empty($loginError)}
		<p class="alert alert-danger alert-dismissible">{'mainLogin_wrong'|lang}</div>
		{/if}
		  <div class="form-group">
		    <label for="email">Email</label>
		    <div class="input-group mb-3">
				<input type="email" class="form-control" placeholder="Email" name="email">
				<div class="input-group-append">
					<div class="input-group-text">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-fill" viewBox="0 0 16 16">
						  <path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555ZM0 4.697v7.104l5.803-3.558L0 4.697ZM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757Zm3.436-.586L16 11.801V4.697l-5.803 3.546Z"></path>
						</svg>
					</div>
				</div>
			</div>
		  </div>
		  <div class="form-group">
		    <label for="password">Mot de passe</label>
		    <div class="input-group">
				<input type="password" class="form-control" placeholder="Mot de passe" name="password">
				<div class="input-group-append">
					<div class="input-group-text">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
						<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"></path>
						</svg>
					</div>
				</div>
			</div>
			<small class="form-text text-muted text-right"><a href="{'/user/main/lostPassword'|url}" onclick="return false" id="lostPasswordLink">Mot de passe oublié?</a></small>
		  </div>
		  <div class="form-group form-check">
		    <input type="checkbox" name="rememberMe" value="1" class="form-check-input">
		    <label class="form-check-label" for="exampleCheck1">Se souvenir de moi</label>
		  </div>
		  <button class="btn btn-primary w-100 text-uppercase" id="ajaxSubmitButton">Se connecter</button>
		</form>
		{* -- END Form login -- *}
	<div class="ui-nav-block text-center">
		<div class="ui-nav-block-title">Vous n'êtes pas inscrit ?</div>
		<a href="{'/user/main/logIn'|url}" class="btn btn-primary w-100 text-uppercase">S'inscrire</a>
	</div>
</div>
{* -- END Menu login - user not logged -- *}


{literal}
<script type="text/javascript">
$(document).ready(function(){
$("#ajaxSubmitButton").on('click', function(event) {
        event.preventDefault();

        var formData =  $("#ajaxLoginForm").serialize();

        $.ajax({
            type: "POST",
            url: "/user/main/logIn",
            data: formData,
            success: function(response) {
                try {
                    var responseData = JSON.parse(response);

                    if (responseData === null) {
                        addAlert("Invalid credentials");
						setTimeout(function() {
                            $(".alert-danger").remove();
                        }, 2000);
                    } else if (responseData.success) {
                        window.location.href = responseData.url;
                    }
                } catch (error) {
                    console.error("Error parsing JSON: " + error);
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                console.error("Error: " + errorThrown);
            }
        });
    });

	function addAlert(message) {
        var alertElement = $("<p>").addClass("alert alert-danger alert-dismissible").text(message);
        $("#ajaxLoginForm").prepend(alertElement);
    }
	});
</script>
{/literal}