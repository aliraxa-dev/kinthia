{capture assign="headData"}
<meta http-equiv="refresh" content="3; url={$setting.siteRootUrl}"/>
{/capture}

{include file="includes/header.tpl" title="{'newsletter_email_verification'|lang}"}

<div class="title_h_1">
<h1>{'newsletter_email_verification'|lang}</h1>
</div>

<div class="column_in">
{'newsletter_thank_you_confirmation_newsletter'|lang}<br />
</div>

{include file="includes/footer.tpl"} 