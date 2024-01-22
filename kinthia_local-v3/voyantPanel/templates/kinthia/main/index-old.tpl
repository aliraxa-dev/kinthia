{include file='includes/header.tpl' page="index" title="{'Panel expert - Kinthia'|lang}"}

<div id="left">
{include file='menu/menuleft/menuleftIndex.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>Welcome to Kinthia Script</h1>

</div>
<div class="column_in">

</div>

<div class="column_in_table">
<table class="table1" cellspacing="1">

<col class="col1" /><col class="col2" /><col class="col1" /><col class="col2" />
<thead>
<tr>
    <th>{'Index_Statistic'|lang}</th>
    <th>{'Index_Value'|lang}</th>
    <th>{'Index_Statistic'|lang}</th>
    <th>{'Index_Value'|lang}</th>
</tr>
</thead>

<tbody>
<tr>
    <td>{'Index_Questions_ok'|lang}: </td>
    <td><strong>{$statistic.answeredQuestionsCount}</strong></td>
	
    <td>{'Index_Pending_Questions'|lang}: </td>
    <td><strong>{$statistic.pendingQuestionsCount}</strong></td>
</tr>
<tr>
    <td>{'Index_Users'|lang}: </td>
    <td><strong>{$statistic.voyantUsersCount}</strong></td>
    <td>{'Index_Pending_check'|lang}:</td>
    <td><strong>{$statistic.pendingCheckOrdersCount}</strong></td>
</tr>
<tr>
    <td>{'Index_Availabilitys'|lang}:</td>
    <td><form action="{'/voyantPanel/main/saveAvailable'|url}" method="post">
    <input type="radio" name="available" value="1" {if $voyant.available}checked="checked"{/if}> Oui  
    <input type="radio" name="available" value="0" {if !$voyant.available}checked="checked"{/if}> Non
    <input type="submit" value="Save">
    </form></td>
</tr>
</tbody>
</table>
</div>

{include file='includes/footer.tpl'} 