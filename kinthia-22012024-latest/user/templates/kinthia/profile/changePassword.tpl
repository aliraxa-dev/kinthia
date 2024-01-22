<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script> 
<script type="text/javascript" src="{'/user/javascript/profile/changePasswordPopup.js'|resurl}"></script>


<h2 class="voyanth2">Changer votre mot de passe</h2>


<form action="{'/user/profile/changePassword'|url}" method="post" id="changePasswordPopupForm">


<div class="w100 man pan">
Ici, vous pouvez changer votre mot de passe.
</div>

<fieldset class="fieldsetpopin">
    <div class="grid-2-small-1 man mbs pan">

    <div class="titleform">&nbsp;</div>
    <div class="infos"><span class="textmandatory">*</span> {'lostPassword_this_fields_mandatory'|lang}</div>
    </div>
    
    <div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Mot de passe actuel <span class="textmandatory">*</span></div>
    <div class="infos"><input type="password" class="input_text_large" name="currentPassword" value="" /></div>
    <div class="text_error"></div>
    </div>
	
	<div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Nouveau mot de passe <span class="textmandatory">*</span></div>
    <div class="infos"><input type="password" class="input_text_large" id="password" name="password" value="" /></div>
    <div class="text_error"></div>
    </div>
	
	<div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Répéter votre mot de passe <span class="textmandatory">*</span></div>
    <div class="infos"><input type="password" class="input_text_large" id="passwordRepeat" name="passwordRepeat" value="" /></div>
    <div class="text_error"></div>
    </div>
    
    <div class="grid-2-small-1 man mbs pan">
    <div class="titleform">&nbsp;</div>
    <div class="infos">
        <input type="submit" class="btn purple profileChangePassword" value="Sauvegarder" />
    </div>
    <div class="text_error"></div>
    </div>
</fieldset>

</form>



    