{include file='includes/header.tpl' page="index" title="{'Administration index'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftIndex.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>{'mainIndex_welcome_kinthia'|lang}</h1>

</div>
<div class="column_in">

</div>

<div class="column_in_table">
<table class="table1" cellspacing="1">

<col class="col1" /><col class="col2" /><col class="col1" /><col class="col2" />
<thead>
<tr>
    <th>{'mainIndex_stats'|lang}</th>
    <th>{'mainIndex_value'|lang}</th>
    <th>{'mainIndex_stats'|lang}</th>
    <th>{'mainIndex_value'|lang}</th>
</tr>
</thead>

<tbody>
<tr>
    <td>{'mainIndex_question_ok'|lang}: </td>
    <td><strong>{$statistic.answeredQuestionsCount}</strong></td>
	
    <td>{'mainIndex_pending_questions'|lang}: </td>
    <td><strong>{$statistic.pendingQuestionsCount}</strong></td>
</tr>
<tr>
    <td>{'mainIndex_users'|lang}: </td>
    <td><strong>{$statistic.usersCount}</strong></td>
	
	    <td>{'mainIndex_database_size'|lang}: </td>
    <td><strong>{$statistic.databaseSize}</strong></td>
</tr>
</tbody>
</table>
</div>

<div class="column_in_table">
<form action="{'/admin/main/clear'|url}" method="post">
<table class="table1" cellspacing="1">
<thead>
<tr>
    <th>{'mainIndex_reset'|lang}</th>
    <th>{'mainIndex_run'|lang}</th>
</tr>

</thead>
<tbody>
<tr class="line1">
    <td><strong>{'mainIndex_clear_cache'|lang}</strong><br />
                {'mainIndex_clear_cache_desk'|lang}.</td>
    <td><input class="button" type="submit" name="fileCache" value="Run" /></td>
</tr>
</tbody>
</table>
</form>
</div>

{include file='includes/footer.tpl'}