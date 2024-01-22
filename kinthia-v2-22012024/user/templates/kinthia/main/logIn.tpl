{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.captchaCode.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/main/loginOnLoad.js'|resurl}"></script>
<script type="text/javascript">
setting.isEmailAcceptable = "/user/register/isEmailAcceptable";
setting.registerUrl = "/user/register";
</script>
{/capture}

{include file="includes/header.tpl" title="{'mainLogin_title_html'|lang}" metaDescription="{'mainLogin_meta_description'|lang}"}

<section id="register-login">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">

				<div class="login-container">
				<h2>{'mainLogin_h1'|lang}</h2>
			
				<form class="nav-login-form" action="{'/user/main/logIn'|url}" method="post" id="loginForm">
				<input type="hidden" name="urlName" value="{$urlName}" />

				{if !empty($loginError)}
					<p class="alert alert-danger alert-dismissible"> email / mot de passe invalide</p>
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
					<label class="form-check-label" for="exampleCheck1">{'mainLogin_remember'|lang}</label>
				</div>
					<button type="submit" class="btn btn-primary w-100 text-uppercase">Se connecter</button>
				</form>
				</div>

			</div>

			<div class="col-lg-6">
				{include file="register/registerForm.tpl"}
			</div>
		</div>
	</div>
</section>


{*
<div id="breadcrumb">
<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
<a href="{'/user/main/logIn'|url}">{'mainLogin_title_arbo'|lang}</a>
</div>
*}

{include file="includes/footer.tpl"}