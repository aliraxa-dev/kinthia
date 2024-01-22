{include file='includes/header.tpl' page="user" title="{'Voyant list'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftUsers.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{$voyantsCount} voyants</h1>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<thead>
<tr>
	<th>{'Index_Voyant_Name'|lang}</th>
	<th>email</th>
	<th>{'Index_Number'|lang}</th>
	<th>Management</th>

</tr>
</thead>
<tbody>
{foreach from=$voyants item=voyant}
<tr class="line{cycle values='1,2'}">
	<td>{$voyant.name} - {$voyant.firstName} {$voyant.lastName}</td>
	<td>{$voyant.email}</td>
	<td>{if !empty($voyant.userQuestions)}{$voyant.userQuestions[0].answeredCount}{else}0{/if}</td>
	<td><a href="{"/admin/voyant/edit/$voyant.voyantId"|url}" title="Edit voyant" class="link_green">Edit</a> | 
		<a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/voyant/delete/$voyant.voyantId"|url}" title="Delete webmaster" class="link_red">Delete</a></td>
</tr>
{/foreach}
</tbody>
</table>

</div>

{include file='includes/footer.tpl'}