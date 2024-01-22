{include file='includes/header.tpl' page="user" title="{'Users'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftUsers.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{$usersCount} users</h1>
</div>

<div class="column_in">
By clicking on "Edit", you can find out the status of each user ad.<br />
You can also edit and delete ad.
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<thead>
<tr>
	<th>Name/Pseudo</th>
	<th>email</th>
	<th>Number of question buy</th>
	<th>Management</th>

</tr>
</thead>
<tbody>
{foreach from=$users item=user}
<tr class="line1">
	<td>{$user.name}</td>
	<td>{$user.email}</td>
	<td>{$user.boughtQuestionsCount}</td>
	<td><a href="{"/voyantPanel/user/show/$user.userId"|url}" title="Edit user" class="link_green">Edit</a></td>
</tr>
{/foreach}
</tbody>
</table>

</div>

{include file='includes/footer.tpl'}