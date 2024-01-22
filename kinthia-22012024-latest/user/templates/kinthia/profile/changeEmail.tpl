<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script> 
<script type="text/javascript" src="{'/user/javascript/profile/changeEmailPopup.js'|resurl}"></script>

<h2 class="voyanth2">Changer votre Email</h2>


<form action="{'/user/profile/changeEmail'|url}" method="post" id="changeEmailPopupForm">


<div class="w100 man pan">
Ici, vous pouvez changer votre Email.
</div>

<fieldset class="fieldsetpopin">
    <div class="grid-2-small-1 man mbs pan">
    
    <div class="titleform">&nbsp;</div>
    <div class="infos"><span class="textmandatory">*</span> {'lostPassword_this_fields_mandatory'|lang}</div>
    </div>
	
	<div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Nouvel Email <span class="textmandatory">*</span></div>
    <div class="infos"><input type="text" class="input_text_large" name="email" id="email" value="" /></div>
    </div>
	
	<div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Répéter votre nouvel Email <span class="textmandatory">*</span></div>
    <div class="infos"><input type="text" class="input_text_large" name="emailRepeat" id="emailRepeat" value="" /></div>
    </div>
	
	<div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Mot de passe <span class="textmandatory">*</span></div>
    <div class="infos"><input type="password" class="input_text_large" name="currentPassword" value="" /></div>
    </div>

    
    <div class="grid-2-small-1 man mbs pan">
    <div class="titleform">&nbsp;</div>
    <div class="infos">
        <input type="submit" class="btn purple" value="Sauvegarder" />
    </div>
    </div>
</fieldset>

</form>



    