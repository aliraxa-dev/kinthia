<div class="login-container" id="registerLayer">
<h2>{'registerRegisterForm_new_create_account'|lang}</h2>
<form action="{'/user/register/register'|url}" method="post" id="registerForm">
	<div class="form-group">
		<label for="name">{'registerRegisterForm_pseudo'|lang}</label>
		<div class="input-group mb-3">
			<input type="text" class="form-control" placeholder="{'registerRegisterForm_pseudo'|lang}" name="name">
			<div class="input-group-append">
				<div class="input-group-text">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
						<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
					</svg>
				</div>
			</div>
		</div>
	</div>

	<div class="form-group">
		<label for="email">{'registerRegisterForm_email'|lang}</label>
		<div class="input-group mb-3">
			<input type="email" class="form-control" placeholder="{'registerRegisterForm_email'|lang}" name="email">
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
		<label for="emailConfirmation">{'registerRegisterForm_repeat_email'|lang}</label>
		<div class="input-group mb-3">
			<input type="email" class="form-control" placeholder="{'registerRegisterForm_repeat_email'|lang}" name="emailConfirmation">
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
		<label for="password">{'registerRegisterForm_password'|lang}</label>
		<div class="input-group mb-3">
			<input type="password" class="form-control" placeholder="{'registerRegisterForm_password'|lang}" name="password">
			<div class="input-group-append">
				<div class="input-group-text">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
						<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"></path>
					</svg>
				</div>
			</div>
		</div>
	</div>

	<div class="form-group">
		<label for="passwordConfirmation">{'registerRegisterForm_repeat_password'|lang}</label>
		<div class="input-group mb-3">
			<input type="password" class="form-control" placeholder="{'registerRegisterForm_repeat_password'|lang}" name="passwordConfirmation">
			<div class="input-group-append">
				<div class="input-group-text">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
						<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"></path>
					</svg>
				</div>
			</div>
		</div>
	</div>

	{if $setting.newsletterEnabled}
	<div class="form-group form-check">
		<input type="checkbox" name="newsletterEnabled" value="1" class="form-check-input">
		<label class="form-check-label" for="newsletterEnabled">{'registerRegisterForm_subscribe_newsletter'|lang}</label>
	</div>
	{/if}
	{if $setting.captchaInRegistrationEnabled}
	<div class="grid-2-small-1 man mbs pan">
		<div class="titleform">{'registerRegisterForm_security_code'|lang} <span class="textmandatory">*</span></div>
		<div class="infos captchaCode"></div>
	</div>
	{/if}

	<div class="form-group form-check">
		<label class="form-check-label" for="newsletterEnabled">
			En cliquant sur le bouton "m'inscrire", j'accepte les <a href="https://www.kinthia.com/copyright/termes.php" class="linklostpassword" target="_blank">conditions générales</a> ainsi que la politique de confidentialité de Kinthia.com
		</label>
	</div>

	<button type="submit" class="btn btn-primary w-100 text-uppercase">{'registerRegisterForm_button_registration'|lang}</button>


</form>
</div>