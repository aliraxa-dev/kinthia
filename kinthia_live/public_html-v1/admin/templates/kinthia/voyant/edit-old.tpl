{capture assign="headData"}
<link href="{'/templates/kinthia/css/upload.css'|resurl}" rel="stylesheet" type="text/css" />
<link href="{'/javascript/jquery/theme/ui.all.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tiny_mce.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/basic_config.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.fileUploader.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.photoEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.tablednd.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/json.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/comment/CommentEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/voyant/editOnLoad.js'|resurl}"></script>
<script>
setting.voyant = {$voyantJson|htmlspecialchars_decode};
</script>
{/capture}

{include file='includes/header.tpl' page="user" title="{'Edit voyant'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftUsers.tpl'}
</div>

<div id="right">
</div>

<div id="middle">
<div class="column">

{include file='voyant/crudForm.tpl'}

<div class="title_h_2">
<h2>Questions list</h2>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1" id="voyantQuestionsTable">
<thead>
<tr>
    <th>Question title</th>
    <th>Management</th>
</tr>
</thead>
<tbody>
{foreach from=$voyant.voyantQuestions item=voyantQuestion}
<tr class="line{cycle values='1,2'}" id="voyantQuestionsTable-row-{$voyantQuestion.questionId}">
    <td><a href="{"/admin/voyantQuestion/edit/$voyantQuestion.questionId"|url}">{$voyantQuestion.title}</a></td>
    <td><a href="{"/admin/voyantQuestion/edit/$voyantQuestion.questionId"|url}" class="link_green">Edit</a> |
        <a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/voyantQuestion/delete/$voyantQuestion.questionId"|url}" class="link_red">Delete</a></td>
</tr>
{/foreach}
</tbody>
</table>
</div>

<div class="column_in_table2" style="text-align:center">
<a href="{"/admin/voyantQuestion/create/$voyant.voyantId"|url}">Add new question</a>
</div>

<div class="title_h_1">
<h1>Question buy by user</h1>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<thead>
<tr>
    <th>Question title</th>
    <th>Status</th>
    <th>Summary</th>
    <th>Invoice</th>
    <th>User name</th>

</tr>
</thead>
<tbody>

{foreach from=$voyant.userQuestions item=userQuestion}
<tr class="line{cycle values='1,2'}">
    <td>{$userQuestion.voyantQuestion.title}</td>
    <td>
    {switch from=$userQuestion.status}
    {case value="pending"}
    <span class="text_red">pending</span>
    {case value="answered"}
    <span class="text_green">OK</span>
    {/switch}
    </td>
    <td><a href="{"/admin/userQuestion/summary/$userQuestion.questionId"|url}" title="Edit summary" class="">See / Post</a></td>
    <td><a href="{"/invoice/orderInvoice/$userQuestion.orderId"|url}" title="Show invoice" class="">See nr {$userQuestion.orderId}</a></td>
    <td>{$userQuestion.user.name}</td>
</tr>
{/foreach}

</tbody>
</table>
</div>

<div class="title_h_2">
<h2>Comments add by users</h2>
</div>

<div class="column_in_table2">
<table class="table1" cellspacing="1">
<thead>
<tr>
<th>Comments</th>
<th>Rating</th>
<th>Users</th>
<th>Date</th>
<th>IP</th>
<th>Validated</th>
<th>Management</th>
</tr>

</thead>
<tbody>
{foreach from=$voyant.voyantComments item=voyantComment}
<tr class="line{cycle values='1,2'}" id="commentForm{$voyantComment.commentId}">                                              
    <td><textarea class="textarea_large" name="text" cols="50" rows="5">{$voyantComment.text}</textarea></td>
    <td><input class="input_text_small" name="rating" value="{$voyantComment.rating}" type="text">/5</td>
    <td>{$voyantComment.user.name}</td>
    <td><input type="text" class="input_text_small" name="date" value="{$voyantComment.date}" /></td>
    <td>{$voyantComment.remoteIp}</td>
    <td>{if $voyantComment.validated}<span class="text_green">{'Edit_Yes'|lang}</span>{else}<span class="text_red">{'Edit_No'|lang}</span>{/if}</td>
    <td>
    <input type="hidden" name="commentId" value="{$voyantComment.commentId}"/> 
    <input type="hidden" name="remoteIp" value="{$voyantComment.remoteIp}"/>
    <a href="" title="Save comment" class="link_green" rel="save">{'Edit_Save'|lang}</a> | 
        <a href="" title="Delete comment" class="link_red" rel="delete">{'Edit_Delete'|lang}</a> | 
        <a href="" title="Ban IP" class="link_red" rel="banIp" >{'Edit_Ban_IP'|lang}</a></td> 
</tr>
{/foreach}
</tbody>
</table>
</div>

{include file='includes/footer.tpl'}