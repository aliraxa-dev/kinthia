<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="{'/user/javascript/main/lostPasswordPopup.js'|resurl}"></script>


<h2 class="voyanth2">{'lostPassword_lost_password'|lang}</h2>


<form action="{'/user/main/lostPassword'|url}" method="post" id="lostPasswordPopupForm">


<div class="w100 man pan">
{'lostPassword_description_1'|lang}
{'lostPassword_description_2'|lang}
</div>

<fieldset class="fieldsetpopin">
    <div class="grid-2-small-1 man mbs pan">
    
    <div class="titleform">&nbsp;</div>
    <div class="infos"><span class="textmandatory">*</span> {'lostPassword_this_fields_mandatory'|lang}</div>
    </div>
    
    <div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">{'lostPassword_your_email'|lang} <span class="textmandatory">*</span></div>
    <div class="infos"><input type="text" class="input_text_large" name="email" value="" /></div>
    </div>
    
    {if $setting.captchaInContactFormEnabled}
    <div class="grid-2-small-1 man mbs pan form">
    <div class="titleform">'lostPassword_security_code'|lang} <span class="textmandatory">*</span></div>
    <div class="infos captchaCode"></div>
    </div>
    {/if}
    
    <div class="grid-2-small-1 man mbs pan">
    <div class="titleform">&nbsp;</div>
    <div class="infos"><input type="submit" class="btn purple" value="{'lostPassword_button_send_new_password'|lang}" /></div>
    </div>
</fieldset>

</form>



    