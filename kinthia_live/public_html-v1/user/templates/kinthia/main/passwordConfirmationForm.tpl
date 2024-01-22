{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/main/loginOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/main/passwordConfirmationSaveForm.js'|resurl}"></script>
{/capture}

{include file="includes/header.tpl" title="{'mainLogin_title_html'|lang}" metaDescription="Changement de mot de passe"}

<div class="padding-wrapper aftermenutop">

<div id="breadcrumb">
<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt; 
Changement de mot de  passe
</div>
</div>

<!--
{include file="includes/profileBox.tpl"}
-->
<div class="w100 man pae">
<form action="{'/user/main/passwordConfirmationSave'|url}" method="post" id="passwordConfirmationSaveForm">

<fieldset class="fieldset pas">
<h2 class="voyanth2">Nouveau mot de passe</h2>

	<div class="w100 man pan">
	Vous allez procéder au changement de votre mot de passe.
	Si vous ne parvenez pas à changer votre mot de passe, vous pouvez nous contacter par <a href="https://www.kinthia.com/navigation/contact.php">email</a>. 
	</div>

    <div class="grid-2-small-1 man mbs pan">
    <div class="titleform">&nbsp;</div>
    <div class="infos"><span class="textmandatory">*</span> {'lostPassword_this_fields_mandatory'|lang}</div>
    </div>
	
	<div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Nouveau mot de passe <span class="textmandatory">*</span></div>
    <div class="infos"><input type="text" class="input_text_large" name="password" value="" id="password" /></div>
    </div>
	
	<div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">Répéter votre nouveau mot de passe <span class="textmandatory">*</span></div>
    <div class="infos"><input type="text" class="input_text_large" name="passwordRepeat" id="passwordRepeat" value="" /></div>
    </div>

    
    <div class="grid-2-small-1 man mbs pan">
    <div class="titleform">&nbsp;</div>
    <div class="infos">
        <input type="hidden" name="hash" value="{$hash}">
        <input type="submit" class="btn purple" value="Changer le mot de passe" />
    </div>
    </div>
</fieldset>

</form>
</div>


{include file="includes/footer.tpl"}
    