{include file='includes/header.tpl' page="system" title="{'Save database'|lang}"}  

<div id="left">

{include file='menu/menuleft/menuleftSystem.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Save database'|lang}</h1>
</div>
<div class="column_in">
{'This will safeguard MySQL related Arfooo directory'|lang}.<br />
{'It will generate a file or SQL gzipped or text stored in the directory save/, which can be used to restore your tables and their contents'|lang}.<br /><br />
<strong>{'This may take some time'|lang}.</strong>
</div>

<div class="column_in_table2">
<form action="{'/admin/system/save'|url}" method="post">
<table class="table2" cellspacing="1">
<tbody>
<tr>
	<td>{'File Type'|lang}: </td>
	<td><input type="radio" name="fileType" value="gz" checked="checked" /> {'Gzip'|lang} &nbsp;&nbsp;<input type="radio" name="fileType" value="sql" /> {'Text'|lang}</td>
</tr>
<tr>
	<td>{'Action'|lang}: </td>
	<td><input type="radio" name="saveMethod" value="store|download" checked="checked" /> {'Store and download'|lang} &nbsp;&nbsp;<input type="radio" name="saveMethod" value="download" /> {'Download'|lang} &nbsp;&nbsp;<input type="radio" name="saveMethod" value="store" /> {'Store'|lang}</td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" class="button" value="{'Save database'|lang}" /></td>
</tr>
</tbody>
</table>
</div>

{include file='includes/footer.tpl'}     