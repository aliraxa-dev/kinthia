{include file='includes/header.tpl' page="system" title="{'Informations'|lang}"} 

<div id="left">

{include file='menu/menuleft/menuleftSystem.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Informations Files &amp; folder'|lang}</h1>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<col class="col1-1" /><col class="col2-2" />
<thead>
<tr>
	<th>{'Explain'|lang}</th>
	<th>{'Status'|lang}</th>
</tr>
</thead>
<tbody>
<tr class="line1">
	<td>{'The install/ directory is still present on the server'|lang}: </td>
	<td>{if $installDirExists}<span class="text_red">{'Yes'|lang}</span>{else}<span class="text_green">{'No'|lang}</span>{/if}</td>
</tr>
<tr class="line2">
	<td>{'The cache/ directory is writable'|lang}: </td>
	<td>{if $cacheDirWritable}<span class="text_green">{'Yes'|lang}</span>{else}<span class="text_red">{'No'|lang}</span>{/if}</td>
</tr>
<tr class="line1">
	<td>{'The save/ directory is writable'|lang}: </td>
	<td>{if $saveDirWritable}<span class="text_green">{'Yes'|lang}</span>{else}<span class="text_red">{'No'|lang}</span>{/if}</td>
</tr>
<tr class="line2">
	<td>{'The uploads/categoryImages/ directory is writable'|lang}: </td>
	<td>{if $imagesCategoriesDirWritable}<span class="text_green">{'Yes'|lang}</span>{else}<span class="text_red">{'No'|lang}</span>{/if}</td>
</tr>
<tr class="line1">
	<td>{'The uploads/photos/ directory is writable'|lang}: </td>
	<td>{if $imagesThumbsDirWritable}<span class="text_green">{'Yes'|lang}</span>{else}<span class="text_red">{'No'|lang}</span>{/if}</td>
</tr>
</tbody>
</table>
</div>

<div class="title_h_2">
<h2>{'Informations server'|lang}</h2>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<col class="col1-1" /><col class="col2-2" />
<thead>
<tr>
	<th>{'Explain'|lang}</th>
	<th>{'Status'|lang}</th>
</tr>
</thead>
<tbody>
<tr class="line1">
	<td>{'Your version of PHP is'|lang}: </td>
	<td><span class="text_green">{$phpVersion}</span></td>
</tr>
<tr class="line2">
	<td>{'Your version of MySQL is'|lang}: </td>
	<td><span class="text_green">5.0.44</span></td>
</tr>
<tr class="line1">
	<td>{'You use the Template Lite template engine version'|lang}: </td>
	<td><span class="text_green">2.10</span></td>
</tr>
</tbody>
</table>
</div>

{include file='includes/footer.tpl'}     