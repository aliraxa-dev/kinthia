{include file='includes/header.tpl' page="system" title="{'Check for updates'|lang}"} 

<div id="left">

{include file='menu/menuleft/menuleftSystem.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Checking the version'|lang}</h1>
</div>
<div class="column_in">
{'Verify that the version of Arfooo is currently in operation to date'|lang}.
</div>

{if $newVersionAvailable}
<div class="column_in_bad_version">
{'Your installation is not up to date, an update is available at this address: http://www.arfooo.com.'|lang}
{'You need to update your installation for security reasons.'|lang}
</div>
{else}
<div class="column_in_good_version">
{'Your installation is up to date, no update is available for your version of Arfooo directory.'|lang}
{'You do not need to upgrade your installation.'|lang}
</div>
{/if}

<div class="column_in_table2">
<table class="table2" cellspacing="1">
<tbody>
<tr>
	<td>{'Current Version'|lang}: </td>
	<td><strong>{$currentVersion}</strong></td>
</tr>
<tr>
	<td>{'Last version'|lang}: </td>
	<td><strong>{$lastVersion}</strong></td>
</tr>
</tbody>
</table>
</div>

{include file='includes/footer.tpl'}   