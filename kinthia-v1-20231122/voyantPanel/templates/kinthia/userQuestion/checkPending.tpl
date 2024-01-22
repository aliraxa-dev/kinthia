{capture assign="headData"}                
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/userQuestions/pendingOnLoad.js'|resurl}"></script>

<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}

{include file='includes/header.tpl' page="index" title="{'Pending user questions'|lang}"} 

<div id="left">
{include file='menu/menuleft/menuleftIndex.tpl'}
</div>

<div id="right">
</div>

<div id="middle"> 
<div class="column">

<div class="title_h_1">             
<h1><span>{$userQuestionsCount}</span> Pending questions</h1>
</div>

<form action="{'/voyantPanel/userQuestion/updateUserQuestionStatus'|url}" method="post" id="pendingUserQuestionsForm">
<div id="holderOfWaitingSites">

{foreach from=$userQuestions item=userQuestion}
<div class="column_in_waiting_site_{cycle values='grey, blue'}">
<div class="column_in_waiting_site_checkbox">
<input type="checkbox" class="checkbox" name="questionIds[]" value="{$userQuestion.questionId}" />
</div>
<div class="column_in_waiting_site_text">
{$userQuestion.creationDate} | <strong>Question for</strong> : {$userQuestion.voyant.name}
<br /> 
<strong>User</strong>: <a href="{"/voyantPanel/user/show/$userQuestion.user.userId"|url}" >{$userQuestion.user.name}</a> &nbsp;&nbsp;&nbsp;<strong>Email</strong>: {$userQuestion.user.email}
<br />
<strong>Question select by user</strong>: {$userQuestion.voyantQuestion.title}
<br /> 
<strong>Payment pending</strong> : <span class="text_green">Yes</span></span>
<br /> 
<strong>Order Number</strong> : $orderNumber</span>
</div>
</div>
{/foreach}

{include file="includes/pageNavigation.tpl"}

</div>

<div class="column_in_waiting_site_button">
<select name="status" >
<option value="answered" selected="selected"> Check OK </option>
</select>
<input type="button" class="button" value="Check all" id="selectAllButton"/>
<input type="submit" class="button" value="OK" />
</div> 

</form>

{include file='includes/footer.tpl'}
