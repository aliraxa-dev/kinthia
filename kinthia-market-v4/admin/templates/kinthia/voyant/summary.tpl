{include file='includes/header.tpl' page="user" title="{'Edit voyant'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftUsers.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>Post / Edit summary</h1>
</div>

<div class="column_in_table2">
<form action="/demo/admin/category/saveNew" method="post" enctype="multipart/form-data">
<input type="hidden" name="parentCategoryId" value="0" />
<table class="table2" cellspacing="1">
<tbody>
<tr>
    <td>{'Summary_Pseudo_name'|lang}: </td>
    <td>$pseudo - $lastName, $firstName</td>
</tr>
<tr>
    <td>{'Summary_Question_title'|lang}: </td>
    <td>$Question title</td>
</tr>
<tr>
    <td>{'Summary_Title'|lang}: </td>
    <td><input type="text" class="input_text_large" name="name" value="" /></td>
</tr>
<tr>
    <td>Description : </td>
    <td><textarea name="text" cols="75" rows="30">sqdqdqs</textarea></td>
</tr>
<tr>
    <td></td>
    <td><input type="submit" class="button" value="Post" /></td>
</tr>
</tbody> 
</table>
</form>
</div>

{include file='includes/footer.tpl'}