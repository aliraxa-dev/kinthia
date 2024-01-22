<head>
<meta name="robots" content="noindex, nofollow" />
</head>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script> 
<script type="text/javascript" src="{'/javascript/contact/contactPopup.js'|resurl}"></script> 

<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>

<h2 class="voyanth2">{'contactPopup_send_message'|lang}</h2>

<form action="{'/contact/sendMessageToUser'|url}" method="post" id="contactPopupForm">
<input type="hidden" name="userId" value="{$user.userId}">  

<fieldset class="fieldsetpopin pas">
	
	<div class="grid-2-small-1 man mbs pan">
	<div class="titleform">&nbsp;</div>
    <div class="infos"><span class="textmandatory">*</span> {'contactPopup_mandatory_fields'|lang}</div>
    </div>
    
    <div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">{'contactPopup_object'|lang} <span class="textmandatory">*</span></div>
    <div class="infos"><input type="text" class="input_text_large" name="title" value="" /></div>
    </div>
    
    <div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">{'contactPopup_message'|lang} <span class="textmandatory">*</span></div>
    <div class="infos"><textarea class="textarea_large" name="description" cols="50" rows="5"></textarea></div>
    </div>
    
    <div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">&nbsp;</div>
    <div class="infos"><input type="submit" class="btn purple" value="{'contactPopup_button_send'|lang}" /> <!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button close" value="{'contactPopup_button_cancel'|lang}" /> --> </div>
    </div>
</fieldset>
</form>


