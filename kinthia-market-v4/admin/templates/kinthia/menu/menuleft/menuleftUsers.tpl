<div class="menuleft">
{include file='menu/menuleft/login.tpl'}
<ul>
<li class="text">{'MenuLeftIndex_Users'|lang}</li>
<li><a href="{'/admin/user/user'|url}">User list</a></li>
<li class="text">{'Voyants'|lang}</li>
<li><a href="{'/admin/voyant'|url}">Voyants list</a></li>
<li><a href="{'/admin/voyant/create'|url}">Create a voyant</a></li>
<li class="text">{'MenuLeftIndex_Security'|lang}</li>
<li><a href="{'/admin/user/banIp'|url}" title="{'MenuLeftUsers_Ban_IPs'|lang}">{'MenuLeftUsers_Ban_IPs'|lang}</a></li>
<li><a href="{'/admin/user/banEmail'|url}" title="{'MenuLeftUsers_Ban_Emails'|lang}">{'MenuLeftUsers_Ban_Emails'|lang}</a></li>
<li class="text">{'MenuLeftUsers_Newsletter_mass_mailer'|lang}</li>
<li><a href="{'/admin/user/newsletter'|url}" title="{'MenuLeftUsers_Send_Newsletter_mass_mailer'|lang}">{'MenuLeftUsers_Send_Newsletter_mass_mailer'|lang}</a></li>
<li><a href="{'/admin/user/newsletterEmail'|url}" title="{'MenuLeftUsers_Export_import_mails'|lang}">{'MenuLeftUsers_Export_import_mails'|lang}</a></li>
</ul>
</div>
