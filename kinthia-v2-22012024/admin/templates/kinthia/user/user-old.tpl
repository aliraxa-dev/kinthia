{include file='includes/header.tpl' page="user" title="{'Users'|lang}"}

<div id="left">
{include file='menu/menuleft/menuleftUsers.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{$usersCount} {'users'|lang}</h1>
</div>
<div class="column_in">
<form action="{'/admin/user/user'|url}" method="post">
You can search users. just write their email or a part of their email<br /><br />
<input type="text" class="input_text_medium" name="email" value="" /> <input type="submit" class="button" value="Search" />
</form>
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
<tr class="line{cycle values='1,2'}">
	<td>{$user.name}</td>
	<td>{$user.email}</td>
	<td>{if !empty($user.userQuestions)}{$user.userQuestions[0].boughtCount}{else}0{/if}</td>
	<td><a href="{"/admin/user/editUser/$user.userId"|url}" title="Edit user" class="link_green">Edit</a> | 
		<a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/user/deleteUser/$user.userId"|url}" title="Delete webmaster" class="link_red">Delete</a></td>
</tr>
{/foreach}
</tbody>
</table>

{include file="includes/pageNavigation.tpl"} 

</div>

{include file='includes/footer.tpl'}