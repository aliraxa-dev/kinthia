{include file='includes/header.tpl' page="template" title="{'Templates'|lang}"}   

<div id="left">

{include file='menu/menuleft/menuleftTemplates.tpl'}  

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Templates'|lang}</h1>
</div>
<div class="column_in">
{'You can choose the template of your choice'|lang}. <br />
{'To add a template, you simply add a folder containing the different files in the folder "templates"'|lang}.
</div>
<div class="column_in_table2">
<form action="{'/admin/template/update'|url}" method="post" id="templateForm">
<table class="table1" cellspacing="1">
<thead>
<tr>
	<th>{'Name of template'|lang}</th>
	<th>{'Management'|lang}</th>
</tr>
</thead>
<tbody>
{foreach from=$alltemplates value=templateName}
<tr class="line{cycle values='1,2'}">
	<td>{$templateName}</td>
	<td><a href="{"/admin/template/preview/$templateName"|url}" title="Overview template" >{'Preview'|lang}</a> | 
		<input type="radio" class="checkbox" name="templateName" value="{$templateName}" style="border:0px;" {if $templateName == $setting.templateName}checked="checked"{/if}  /> 
        {if $templateName == $setting.templateName}
            <span class="text_green">{'Enabled'|lang}</span>
        {else}
            <span class="text_red">{'Disabled'|lang}</span>
        {/if}
          </td>
</tr>
{/foreach}
</tbody>
</table>

<div class="column_in_center">
<input type="submit" class="button" value="{'Save'|lang}" />
</div>

</form>
</div>

{include file='includes/footer.tpl'}   