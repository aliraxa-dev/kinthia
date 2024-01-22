{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/newsletter/indexOnLoad.js'|resurl}"></script>    
{/capture}

{include file="includes/header.tpl" title="{'newsletter_newsletter'|lang}"}  
	
<div id="show_arbo">
<a href="https://www.kinthia.com/" class="link_showarbo">{'show_arbo_voyance'|lang}</a> &gt; 
<a href="{'/'|url}" class="link_showarbo">{'show_arbo_tirage'|lang}</a> &gt; 
<a href="{'/newsletter'|url}" class="link_showarbo">{'newsletter_arbo'|lang}</a>
</div>

<form action="{'/newsletter/setEmail'|url}" method="post" id="newsletterForm">
<fieldset class="column_in">
	<legend class="title">{'newsletter_h1'|lang}</legend>
	
	<div class="form">
	</div>
	
	<div class="form">
	<label class="title">{'newsletter_your_email'|lang}</label>
	<div class="infos"><input type="text" name="email" class="input_text_large" /></div>
	</div>
	
	<div class="form">
	<label class="title">&nbsp;</label>
	<div class="infos"><input type="submit" name="addEmail" class="button" value="{'newsletter_button_subscribe'|lang}" /> <input type="submit" name="deleteEmail" class="button" value="{'newsletter_button_unsubscribe'|lang}" /></div>
	</div>
</fieldset>
</form>



{include file="includes/footer.tpl"}  