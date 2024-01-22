{capture assign="headData"}
<link href="{'/javascript/jquery/theme/ui.all.css'|resurl}" rel="stylesheet" type="text/css" />
<link href="{'/templates/kinthia/css/upload.css'|resurl}" rel="stylesheet" type="text/css" />
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.photoEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.fileUploader.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/comment/CommentEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/user/editUserOnLoad.js'|resurl}"></script>
<script>
setting.user = {$userJson|htmlspecialchars_decode};
</script>
{/capture}
{include file='includes/header.tpl' page="user" title="{'Edit user'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Edit {$user.name} - {$user.firstName} {$user.lastName}</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard v3</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

<!-- Main content -->
<div class="content">
<div class="container-fluid">
<div class="row">
  <div class="col-md-12">
    <!-- Widget: user widget style 1 -->
    <div class="card card-widget widget-user">
      <!-- Add the bg color to the header using any of the bg-* classes -->
      <div class="widget-user-header bg-kinthia">
        <h3 class="widget-user-username"><b></b></h3>
        <p class="widget-user-desc">{$user.name} - {$user.firstName} {$user.lastName}</p>
      </div>
      <div class="widget-user-image">
        
      </div>
      <div class="card-footer">
        <div class="row">
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$user.questionCount}</h5>
              <span class="description-text">Questions buy</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$user.packageBuyCount}/ {$user.tot_time}</h5>
              <span class="description-text">Package buy / Time buy</span>
            </div>
            <!-- /.description-block -->
          </div>
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$user.phone_usedtime} / {$user.vdo_usedtime}</h5>
              <span class="description-text">Temps passés au téléphone / webcam</span>
            </div>
            <!-- /.description-block -->
            </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$user.rem_time}</h5>
              <span class="description-text">Temps remaining</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">{$user.voyantcount}</h5>
              <span class="description-text">Voyants différents</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
    </div>
    <!-- /.widget-user -->
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Edit user {$user.name}</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form action="{'/admin/user/saveUser'|url}" method="post" id="userEditForm">
        <input type="hidden" name="userId" value="" />
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
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
      </div>
    </form>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->

<div class="card">
  <div class="card-header">
    <h3 class="card-title">Question buy</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>
<tr>
    <th>Question title</th>
    <th>Status</th>
    <th>Date</th>
    <th>Summary</th>
    <th>Invoice</th>
    <th>Voyant name</th>
    <th>PayPal id</th>
    <th>Stripe id</th>
</tr>
</thead>
<tbody>
{foreach from=$user.userQuestions item=userQuestion}
<tr class="{cycle values='bg-grey-kin, '}">
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
    
     <td>{if $userQuestion.order.payPalId}{$userQuestion.order.payPalId} {else}n/a{/if}</td>
       <td>{if $userQuestion.order.stripeData}{$userQuestion.order.stripeData} {else}n/a{/if}</td>
  
</tr>
{/foreach}
</tbody>
</table>
  </div>
</form>
  <!-- /.card-body -->
</div>
<!-- /.card -->

<div class="card">
  <div class="card-header">
    <h3 class="card-title">Package buy</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>
<tr>
    <th>Package title</th>
    <th>Package time</th>
    <th>Date</th>
    <th>Invoice</th>
    <th>PayPal id</th>
    <th>Stripe id</th>
</tr>
</thead>
<tbody>


{foreach from=$user.userPackages item=userPackage}
<tr class="{cycle values='bg-grey-kin, '}">
    <td>{$userPackage.package.packageName}</td>
     <td>{$userPackage.package.packageTime}</td>
    <td>{$userPackage.creationDate}</td>
   <td><a href="{"/invoice/orderInvoice/$userPackage.order.orderId"|url}" title="Show invoice" class="">See</a></td>
    <td>{if $userPackage.order.payPalId}{$userPackage.order.payPalId} {else}n/a{/if}</td>
       <td>{if $userPackage.order.stripeData}{$userPackage.order.stripeData} {else}n/a{/if}</td>
 
</tr>
{/foreach}
</tbody>
</table>
  </div>
</form>
  <!-- /.card-body -->
</div>
<!-- /.card -->

<div class="card">
  <div class="card-header">
    <h3 class="card-title">Consultation by phone</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>
<tr>
    <th>Date</th>
    <th>Time</th>
    <th>Voyant</th>
    <th>Summary</th>
</tr>
</thead>
<tbody>

{foreach from=$user.userConsultations item=userConsultation}
{if $userConsultation.type =='phone'}
<tr class="{cycle values='bg-grey-kin, '}">
    <td>{$userConsultation.date}</td>
     <td>{$userConsultation.duration}</td>
    <td>{$userConsultation.voyant.name}</td>
    <td><a href="#" title="Show summery" class="">See</a></td>
</tr>
{/if}
{/foreach}

</tbody>
</table>
  </div>
</form>
  <!-- /.card-body -->
</div>
<!-- /.card -->

<div class="card">
  <div class="card-header">
    <h3 class="card-title">Consultation by webcam</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>
<tr>
    <th>Date</th>
    <th>Time</th>
    <th>Voyant</th>
    <th>Summary</th>
</tr>
</thead>
<tbody>

<tr class="{cycle values='bg-grey-kin, '}">
    {foreach from=$user.userConsultations item=userConsultation}
{if $userConsultation.type =='webcam'}
<tr class="{cycle values='bg-grey-kin, '}">
    <td>{$userConsultation.date}</td>
     <td>{$userConsultation.duration}</td>
    <td>{$userConsultation.voyant.name}</td>
    <td><a href="#" title="Show summery" class="">See</a></td>
</tr>
{/if}
{/foreach}
</tr>

</tbody>
</table>
  </div>
</form>
  <!-- /.card-body -->
</div>
<!-- /.card -->

<div class="card">
  <div class="card-header">
    <h3 class="card-title">Private Message</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>
<tr>
    <th>Date</th>
    <th>Voyant</th>
    <th>Action</th>
</tr>
</thead>
<tbody>
 {foreach from=$voyantmessages item=voyantmessage key="mkey"}
 {if $userId==$voyantmessage.userId}
  <tr class="{cycle values='bg-grey-kin, '}">
    <td>{$voyantmessage.date|date_format:"%d-%m-%Y %I:%M %p"}</td>
    <td>{$voyantmessage.voyant.name}</td>
 {*    <td>{$voyantmessage.user.name}</td> *}
    <td><a href="{"/admin/userMessage/details/$voyantmessage.userId/$voyantmessage.voyantId"|url}" >Voir</a></td>
  </tr>
  {/if}
  {/foreach}
</tbody>
</table>
  </div>
  <!-- /.card-body -->
</div>
<!-- /.card -->

<div class="card">
  <div class="card-header">
    <h3 class="card-title">Reviews</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
<table class="table text-nowrap">
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
    <a href="" title="Publish comment" class="link_green" rel="save">{'Publish'|lang}</a><br>
    <a href="" title="Unpublish comment" class="link_green" rel="save">{'Unpublish'|lang}</a><br>
        <a href="" title="Delete comment" class="link_red" rel="delete">{'Delete'|lang}</a><br>
        <a href="" title="Ban IP" class="link_red" rel="banIp" >{'Ban IP'|lang}</a></td> 
</tr>
{/foreach}
</tbody>
</table>
  </div>
</form>
  <!-- /.card-body -->
</div>
<!-- /.card -->


  </div>
</div>
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file="includes/footer.tpl"}