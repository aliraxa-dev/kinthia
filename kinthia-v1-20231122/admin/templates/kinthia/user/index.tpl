{include file='includes/header.tpl' page="user" title="{'Administrator'|lang}"} 

<div id="left">

{include file='menu/menuleft/menuleftUsers.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Administrator - Change password'|lang}</h1>
</div>
<div class="column_in_table2">
<form action="{'/admin/user/saveNewAdminPassword'|url}" method="post">
<table class="table2" cellspacing="1">
<tbody>
<tr>
	<td>{'New password'|lang}: </td>
	<td><input type="password" class="input_text_medium" name="newPassword" value="" /></td>
</tr>
<tr>
	<td>{'Repeat new password'|lang}: </td>
	<td><input type="password" class="input_text_medium" name="repeatedNewPassword" value="" /></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" class="button" value="{'Save'|lang}"  /></td>
</tr>
</tbody>
</table>  
</form>
</div>

{include file='includes/footer.tpl'}   