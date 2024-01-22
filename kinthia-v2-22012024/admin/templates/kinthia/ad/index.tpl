{include file='includes/header.tpl' page="ad" title="{'Adsense'|lang}"} 

<div id="left">

{include file='menu/menuleft/menuleftAdsense.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Adsense'|lang}</h1>
</div>
<div class="column_in">
{'You can manage adsenses pages'|lang}: 
{'Index, news, keywords page1, top (hits, notes, rank, referrers), search'|lang}.<br /><br />
{'To manage adsenses categories, sites and keywords, you have to go inside of categories, sites and keywords'|lang}.
</div>

<div class="title_h_2">
<h2>{'List criteria'|lang}</h2>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<thead>
<tr>
	<th>{'Name of criteria'|lang}</th>
	<th>{'Management'|lang}</th>
</tr>
</thead>
<tbody>
{foreach from=$adCriterias value=criteria}
<tr class="line{cycle values='1,2'}">
	<td><a href="" title="{$criteria.name}">{$criteria.name}</a></td>
	<td><a href="{"/admin/ad/editCriteria/$criteria.adCriterionId"|url}" title="{'Edit criteria'|lang}" class="link_green">{'Edit'|lang}</a> | 
		<a onclick="return confirm('{'Do you really want to delete it?'|lang}')" href="{"/admin/ad/deleteCriteria/$criteria.adCriterionId"|url}" title="{'Delete criteria'|lang}" class="link_red">{'Delete'|lang}</a></td>
</tr>
{/foreach}
</tbody>
</table>
</div>

<div class="title_h_2">
<h2>{'To create a criteria'|lang}</h2>
</div>
<div class="column_in_table2">
<form action="{'/admin/ad/saveNewCriteria'|url}" method="post">
<table class="table2" cellspacing="1">
<tbody>
<tr>
	<td>{'Name of criteria'|lang}: </td>
	<td><input type="text" class="input_text_medium" name="name" value="" /></td>
</tr>
<tr>
	<td>{'HTML and JAVASCRIPT Code'|lang}: <br /> 
		<span class="text_explication">{'HTML code for easily integrating into the design and JAVASCRIPT for your code of adverticements adsense, oxado...'|lang}</span></td>
	<td><textarea class="textarea_large" name="htmlContent" cols="50" rows="5"></textarea></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" class="button" value="{'Create the criteria'|lang}" /></td>
</tr>
</tbody>
</table>
</form>
</div>

{include file='includes/footer.tpl'}  