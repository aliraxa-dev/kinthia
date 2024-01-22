{capture assign="headData"}
<link href="{'/javascript/jquery/theme/ui.all.css'|resurl}" rel="stylesheet" type="text/css" />
<link href="{'/templates/kinthia/css/upload.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.photoEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.fileUploader.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/comment/CommentEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/user/editUserOnLoad.js'|resurl}"></script>
<script>
setting.user = {$userJson|htmlspecialchars_decode};
</script>
{/capture}

{include file='includes/header.tpl' page="user" title="{'Edit user'|lang}"}  

<div id="left">
{include file='menu/menuleft/menuleftUsers.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>Edit {$user.firstName} {$user.lastName}</h1>
</div>

<div class="column_in_table2">
<form action="{'/admin/user/saveUser'|url}" method="post" id="userEditForm">
<input type="hidden" name="userId" value="" />
<input type="hidden" name="userId" value="" />
<table class="table2" cellspacing="1">
<tbody>
<tr>
    <td>Pseudo: </td>
    <td><input type="text" class="input_text_medium" name="name" value="" /></td>
</tr>
<tr>
    <td>First name: </td>
    <td><input type="text" class="input_text_medium" name="firstName" value="" /></td>
</tr>
<tr>
    <td>Last name: </td>
    <td><input type="text" class="input_text_medium" name="lastName" value="" /></td>
</tr>
<tr>
    <td>Birthdate: </td>
    <td><input type="text" class="input_text_medium" name="birthdayDate" value="" /></td>
</tr>
<tr>
    <td>Newsletter : </td>
    <td><input type="radio" name="newsletterEnabled" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="newsletterEnabled" value="0" /> OFF</td>
</tr>
<tr>
    <td>Email: </td>
    <td><input type="text" class="input_text_large" name="email" value="" /></td>
</tr>
<tr>
    <td>Photos: </td>
    <td><div id="fileUploadPanel" class="fileUploader"></div></td>
</tr>
<tr>
    <td></td>
    <td><input type="submit" class="button" value="Edit User" /> <input type="button" class="button" value="Delete User" onclick="if (confirm('Do you really want to delete it?')) window.location.href = AppRouter.getRewrittedUrl('/admin/user/deleteUser/{$user.userId}');"  /></td>
</tr>
</tbody> 
</table>
</form>
</div>

<div class="title_h_1">
<h1>Question buy</h1>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<thead>
<tr>
	<th>Question title</th>
	<th>Status</th>
	<th>Date</th>
	<th>Summary</th>
	<th>Invoice</th>
    <th>Voyant name</th>
	<th>PayPal id</th>
</tr>
</thead>
<tbody>
{foreach from=$user.userQuestions item=userQuestion}
<tr class="line1">
	<td>{$userQuestion.voyantQuestion.title}</td>
	<td>
    {switch from=$userQuestion.status}
    {case value="pending"}
    <span class="text_red">pending</span>
    {case value="answered"}
    <span class="text_green">OK</span>
    {/switch}
    </td>
	<td>{$userQuestion.creationDate}</td>
	<td><a href="{"/admin/userQuestion/summary/$userQuestion.questionId"|url}" title="Edit summary" class="">See / Post</a></td>
	<td><a href="{"/invoice/orderInvoice/$userQuestion.orderId"|url}" title="Show invoice" class="">See</a></td>
    <td>{$userQuestion.voyant.name}</td>
	<td>{$userQuestion.order.payPalId}</td>
</tr>
{/foreach}
</tbody>
</table>
</div>

<div class="title_h_2">
<h2>Comments add by user</h2>
</div>

<div class="column_in_table2">
<table class="table1" cellspacing="1">
<thead>
<tr>
<th>Comments</th>
<th>Rating</th>
<th>Date</th>
<th>IP</th>
<th>Validated</th>
<th>Management</th>
</tr>

</thead>
<tbody>

{foreach from=$user.voyantComments value=voyantComment}
<tr class="line{cycle values='1,2'}" id="commentForm{$voyantComment.commentId}">                                              
    <td><textarea class="textarea_large" name="text" cols="50" rows="5">{$voyantComment.text}</textarea></td>
    <td><input class="input_text_small" name="rating" value="{$voyantComment.rating}" type="text">/5</td>
    <td><input type="text" class="input_text_small" name="date" value="{$voyantComment.date}" /></td>
    <td>{$voyantComment.remoteIp}</td>
    <td>{if $voyantComment.validated}<span class="text_green">{'Yes'|lang}</span>{else}<span class="text_red">{'No'|lang}</span>{/if}</td>
    <td>
    <input type="hidden" name="commentId" value="{$voyantComment.commentId}"/> 
    <input type="hidden" name="remoteIp" value="{$voyantComment.remoteIp}"/>
    <a href="" title="Save comment" class="link_green" rel="save">{'Save'|lang}</a> | 
        <a href="" title="Delete comment" class="link_red" rel="delete">{'Delete'|lang}</a> | 
        <a href="" title="Ban IP" class="link_red" rel="banIp" >{'Ban IP'|lang}</a></td> 
</tr>
{/foreach}

</tbody>
</table>
</div>

{include file='includes/footer.tpl'}