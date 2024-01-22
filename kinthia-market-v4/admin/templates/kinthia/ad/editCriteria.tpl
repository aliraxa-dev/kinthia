{include file='includes/header.tpl' page="ad" title="{'Adsense - Edit Criteria'|lang}"} 

<div id="left">

{include file='menu/menuleft/menuleftAdsense.tpl'} 

</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'Adsense - Edit Criteria'|lang}</h1>
</div>
<div class="column_in_table2">
<form action="{"/admin/ad/saveAdCriteriaEdit/$adCriteria.adCriterionId"|url}" method="post">
<table class="table2" cellspacing="1">
<tbody>
<tr>
	<td>{'Name of criteria'|lang}: </td>
	<td><input type="text" class="input_text_medium" name="name" value="{$adCriteria.name}" /></td>
</tr>
<tr>
	<td>{'HTML and JAVASCRIPT Code'|lang}: <br /> 
		<span class="text_explication">{'HTML code for easily integrating into the design and JAVASCRIPT for your code of adverticements adsense, oxado...'|lang}</span></td>
	<td><textarea class="textarea_large" name="htmlContent" cols="50" rows="5">{$adCriteria.htmlContent}</textarea></td>
</tr>
<tr>
	<td></td>                                                                                                                                                                                                                              
	<td><input type="submit" class="button" value="{'Save'|lang}" /> <input type="button" class="button" value="{'Delete'|lang}" id="deleteButton" onclick="javascript: if (confirm('{'Do you really want to delete it?'|lang}')) window.location.replace('{"/admin/ad/deleteCriteria/$adCriteria.adCriterionId"|url}');" /></td>
</tr>
</tbody>
</table>
</form>
</div>

{include file='includes/footer.tpl'}  