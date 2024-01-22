{capture assign="headData"}
<link href="{'/javascript/jquery/theme/ui.all.css'|resurl}" rel="stylesheet" type="text/css" />
<link href="{'/templates/kinthia/jquery/colorbox/colorbox.css'|resurl}" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/colorbox/jquery.colorbox.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/comment/CommentEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/showOnLoad.js'|resurl}"></script>  
{/capture}

{include file='includes/header.tpl' page="index" title="{'Show_user_details'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftIndex.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">
<h1>User details</h1>
</div>

<div class="column_in_table2">
<input type="hidden" name="parentCategoryId" value="0" />
<table class="table2" cellspacing="1">
<tbody>
<tr>
    <td>Pseudo: </td>
    <td>{$user.name}</td>
</tr>
<tr>
    <td>{'Show_First_name'|lang}: </td>
    <td>{$user.firstName}</td>
</tr>
<tr>
    <td>{'Show_Last_name'|lang}: </td>
    <td>{$user.lastName}</td>
</tr>
<tr>
    <td>{'Show_Birthday'|lang}: </td>
    <td>{$user.birthdayDate}</td>
</tr>
<tr>
    <td>Email: </td>
    <td>{$user.email} ( <a href="{"/contact/contactPopup/$user.userId"|url}" class="link_green dialog">Send Email</a> )</td>
</tr>
<tr>
    <td>Photos: </td>
    <td>{foreach from=$user.photos item=photo}
        <a href="{$photo.src}" rel="galleryPhotos"><img src="{$photo.thumbSrc}"/></a>
        {/foreach}
    </td>
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
	<th>{'Show_Question_title'|lang}</th>
	<th>{'Show_Status'|lang}</th>
	<th>Date</th>
	<th>Résumé</th>
    <th>{'Show_In_voice'|lang}</th>
	<th>{'Show_Paypal_id'|lang}</th>
</tr>
</thead>
<tbody>
{foreach from=$user.userQuestions item=userQuestion}
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
    <td>{$userQuestion.creationDate}</td>
    <td><a href="{"/voyantPanel/userQuestion/summary/$userQuestion.questionId"|url}" title="Edit summary" class="">Voir / Ecrire</a></td>
    <td><a href="{"/invoice/orderInvoice/$userQuestion.orderId"|url}" title="Show invoice" class="">voir n° {$userQuestion.orderId}</a></td>
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
<th>{'Show_Comments'|lang}</th>
<th>{'Show_Rating'|lang}</th>
<th>Date</th>
<th>IP</th>
<th>{'Show_Valitated'|lang}</th>
<th>{'Show_Management'|lang}</th>
</tr>

</thead>
<tbody>
{foreach from=$user.voyantComments value=voyantComment}
<tr class="line{cycle values='1,2'}" id="commentForm{$voyantComment.commentId}">                                              
    <td><textarea class="textarea_large" name="text" cols="50" rows="5">{$voyantComment.text}</textarea> <a href="" rel="reply">{'Show_Reply'|lang}</span><br/>
        <textarea class="textarea_large" name="replyText" cols="50" rows="5" style="margin-top:5px;display:none;">{$voyantComment.replyText}</textarea>
    </td>
    <td>{$voyantComment.rating}/5</td>
    <td>{$voyantComment.date}</td>
    <td>{$voyantComment.remoteIp}</td>
    <td>{if $voyantComment.validated}<span class="text_green">{'Show_Yes'|lang}</span>{else}<span class="text_red">{'Show_No'|lang}</span>{/if}</td>
    <td>
    <input type="hidden" name="commentId" value="{$voyantComment.commentId}"/>
    <a href="" title="Save comment" class="link_green" rel="save">{'Show_Save'|lang}</a> | 
        <a href="" title="Delete comment" class="link_red" rel="delete">{'Show_Delete'|lang}</a> | 
    </td> 
</tr>
{/foreach}
</tbody>
</table>
</div>

{include file='includes/footer.tpl'}