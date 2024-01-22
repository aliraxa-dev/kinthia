{capture assign="headData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tiny_mce.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/basic_config.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/userQuestion/summaryOnLoad.js'|resurl}"></script>
{/capture}

{include file='includes/header.tpl' page="index" title="{'Summary_Question_summary'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftIndex.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>Post / Edit summary</h1>
</div>

<div class="column_in_table2">
<form action="{'/admin/userQuestion/saveSummary'|url}" method="post">
<input type="hidden" name="questionId" value="{$userQuestion.questionId}">
<table class="table2" cellspacing="1">
<tbody>
<tr>
    <td>{'Summary_Pseudo_name'|lang}: </td>
    <td>{$userQuestion.user.name} - {$userQuestion.user.lastName}, {$userQuestion.user.firstName}</td>
</tr>
<tr>
    <td>{'Summary_Question_title'|lang}: </td>
    <td>{$userQuestion.voyantQuestion.title}</td>
</tr>
<tr>
    <td>Description : </td>
    <td><textarea name="summary" cols="75" rows="30" class="tinyMce">{$userQuestion.summary}</textarea></td>
</tr>
<tr>
    <td></td>
    <td><input type="submit" class="button" value="Post" /></td>
</tr>
</tbody> 
</table>
</form>
</div>


</div>
</div>

<div class="fixe">
&nbsp;
</div>

</div>
</div>

<div id="bottom">
<div class="column_bottom">
Powered by <a href="http://www.arfooo.net/" title="Directory for seo" target="_blank" class="link_black_grey">Arfooo Directory</a> &copy; 2007 - 2008&nbsp; &nbsp; Generated in 0.267 Queries: 3</div>

</div>

</div>
</body>
</html>