{include file='includes/header.tpl' page="system" title="{'Optimize tables'|lang}"}  

<div id="left">

{include file='menu/menuleft/menuleftSystem.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Optimize tables'|lang}</h1>
</div>
<div class="column_in">
{'This will optimize MySQL related Arfooo directory and maintain data integrity'|lang}.<br />
{'No data can be lost during this process'|lang}.<br /><br />
<strong>{'This may take some time'|lang}.</strong><br /><br />
<form action="{'/admin/system/optimize'|url}" method="post"> 
<input class="button" type="submit" name="start" value="{'Start optimization'|lang}" />
</form>
</div>

{include file='includes/footer.tpl'}     