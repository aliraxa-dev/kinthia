{include file='includes/header.tpl' page="system" title="{'Restore database'|lang}"}   

<div id="left">

{include file='menu/menuleft/menuleftSystem.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Restore database'|lang}</h1>
</div>
<div class="column_in">
{'This operation restore your tables Arfooo Annuaire in MySQL. It uses a file dump Gzipped or text produced by the backup operation'|lang}.<br />
{'Use the form below to select and download your file dump'|lang}.<br /><br />
<strong>{'Important: This may take some time. Be patient'|lang}.<br /><br />
{'Note that this operation will not fuse existing data with data from the dump, but will replace it altogether'|lang}. 
{'In addition, this process may fail because of restrictions on the execution time in your PHP configuration'|lang}. {'In such a case, it may leave your site in a damaged condition'|lang}. 
{'You are warned!'|lang}</strong>
</div>

<div class="column_in_table2">
<form action="{'/admin/system/restore'|url}" method="post" enctype="multipart/form-data">
<table class="table2" cellspacing="1">
<tbody>
<tr>
	<td>{'File Type'|lang}: </td>
	<td><input type="radio" name="fileType" value="gzip" checked="checked" /> {'Gzip'|lang} &nbsp;&nbsp;<input type="radio" name="fileType" value="text" /> {'Text'|lang}</td>
</tr>
<tr>
	<td>{'Backup file'|lang}: </td>
	<td><input type="file" class="input_text_medium" style="width:247px;" name="backupFile" /></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" class="button" value="{'Restore database'|lang}" /></td>
</tr>
</tbody>
</table>
</form>
</div>

{include file='includes/footer.tpl'}     