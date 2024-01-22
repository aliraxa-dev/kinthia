{capture assign="headData"} 
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.captchaCode.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script> 
<script type="text/javascript" src="{'/javascript/contact/indexOnLoad.js'|resurl}"></script>    
{/capture}

{include file="includes/header.tpl" title="{'contactIndex_html_title'|lang}" metaDescription="{'contactIndex_meta_description'|lang}"}    
	
<div id="show_arbo_users">
<a href="https://www.kinthia.com/" class="link_showarbo">{'show_arbo_voyance'|lang}</a> &gt; 
<a href="{$setting.siteRootUrl}" class="link_showarbo">{'show_arbo_tirage'|lang}</a> &gt; 
<a href="{'/contact'|url}" class="link_showarbo">{'contactIndex_arbo'|lang}</a>
</div>

<form action="{'/contact/sendMessageToAdmin'|url}" method="post" id="contactForm"> 
<fieldset class="column_in">
	<legend class="title">{'contactIndex_form'|lang}</legend>
	
	<div class="form">
	</div>
	
	<div class="form">
	<label class="title">{'contactIndex_email'|lang} <span class="text_color_mandatory">*</span></label>
	<div class="infos"><input type="text" name="yourEmail" class="input_text_large" /></div>
	</div>
	
	<div class="form">
	<label class="title">{'contactIndex_subject'|lang} <span class="text_color_mandatory">*</span></label>
	<div class="infos"><input type="text" name="title" class="input_text_large" /></div>
	</div>
	
	<div class="form">
	<label class="title">{'contactIndex_message'|lang} <span class="text_color_mandatory">*</span></label>
	<div class="infos"><textarea class="textarea_large" name="description" cols="50" rows="5" id="categoryDescription"></textarea></div>
	</div>
	
    {if $setting.captchaEnabledOnContactForm}
	<div class="form">
    <label class="title">{'contactIndex_security_code'|lang} <span class="text_color_mandatory">*</span></label>
    <div class="infos captchaCode"></div>
    </div>
    {/if}
	
	<div class="form">
	<label class="title">&nbsp;</label>
	<div class="infos"><input type="submit" class="button" value="{'contactIndex_button_send'|lang}" /></div>
	</div>
</fieldset>
</form>

</div>

{include file="includes/footer.tpl"}