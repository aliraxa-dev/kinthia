{capture assign="headData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.tablednd.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/json.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/voyantQuestion/indexOnLoad.js'|resurl}"></script>
{/capture}

{include file='includes/header.tpl' page="index" title="{'Index_Voyant_questions'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftIndex.tpl'}
</div>

<div id="right">
</div>

<div id="middle">
<div class="column">

<div class="title_h_2">
<h2>Questions list</h2>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1" id="voyantQuestionsTable">
<thead>
<tr>
    <th>{'Index_Question_title'|lang}</th>
    <th>{'Index_Management'|lang}</th>
</tr>
</thead>
<tbody>
{foreach from=$voyantQuestions item=voyantQuestion}
<tr class="line{cycle values='1,2'}" id="voyantQuestionsTable-row-{$voyantQuestion.questionId}">
    <td><a href="{"/voyantPanel/voyantQuestion/edit/$voyantQuestion.questionId"|url}">{$voyantQuestion.title}</a></td>
    <td><a href="{"/voyantPanel/voyantQuestion/edit/$voyantQuestion.questionId"|url}" class="link_green">Edit</a> |
        <a onclick="return confirm('Do you really want to delete it?')" href="{"/voyantPanel/voyantQuestion/delete/$voyantQuestion.questionId"|url}" class="link_red">Delete</a></td>
</tr>
{/foreach}
</tbody>
</table>
</div>

{include file='includes/footer.tpl'}