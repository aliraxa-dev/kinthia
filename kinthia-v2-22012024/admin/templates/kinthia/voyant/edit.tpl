{capture assign="headData"}
<link href="{'/templates/kinthia/css/upload.css'|resurl}" rel="stylesheet" type="text/css" />
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tinymce.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/InitTinyMCE.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.tablednd.js'|resurl}"></script>

<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.fileUploader.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.photoEditor.js'|resurl}"></script>

<script type="text/javascript" src="{'/javascript/jquery/json.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/comment/CommentEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/voyant/editOnLoad.js'|resurl}"></script>
<script>
setting.voyant = {$voyantJson|htmlspecialchars_decode};
console.warn(setting.voyant);
</script>
{/capture}
{include file='includes/header.tpl' page="user" title="{'Edit voyant'|lang} - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Edit voyant</h1>
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
        <div class="widget-user-image">
          <img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" class="elevation-2" alt="User Image">
        </div>
        <h3 class="widget-user-username"><b>{$voyant.name}</b></h3>
        <p class="widget-user-desc">{$voyant.firstName} {$voyant.lastName}</p>
      </div>
      <div class="widget-user-image">
        
      </div>
      <div class="card-footer">
        <div class="row">
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">Count : phone / webcam / question </h5>
              <span class="description-text">{$voyant.phone_usedcount} | {$voyant.vdo_usedcount} | {$voyant.userQuestionscount}</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">Time : phoneCount / webcamCount</h5>
              <span class="description-text">{$voyant.phone_usedtime} | {$voyant.vdo_usedtime}</span>
            </div>
            <!-- /.description-block -->
            </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">Gain : phone / webcam / question</h5>
              <span class="description-text"> {math equation="($statistic.totalEarningPhone/60)*1" format="%.2f"}€ | {math equation="($statistic.totalEarningWebcam/60)*1" format="%.2f"}€ | {$statistic.answeredQuestionsEarning}€</span>
            </div>
            <!-- /.description-block -->
          </div>
          <!-- /.col -->
          <div class="col border-right">
            <div class="description-block">
              <h5 class="description-header">userCount</h5>
              <span class="description-text">{$voyant.getVoyantUsersCount}</span>
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
      {include file='voyant/crudForm.tpl'}

<div class="card">
  <div class="card-header">
  <h3 class="card-title">Questions list</h3>
  </div>
  <!-- /.card-header -->
<div class="card-body table-responsive p-0">
<table class="table text-nowrap" id="voyantQuestionsTable">
<thead>
<tr>
    <th>Question title</th>
    <th>Action</th>
</tr>
</thead>
<tbody>
{foreach from=$voyant.voyantQuestions item=voyantQuestion}
<tr class="{cycle values='bg-grey-kin, '}" id="voyantQuestionsTable-row-{$voyantQuestion.questionId}">
    <td>{$voyantQuestion.title}</td>
    <td>
      <ul class="list-inline m-0">
        <li class="list-inline-item">
        <a href="{"/admin/voyantQuestion/edit/$voyantQuestion.questionId"|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
        </li>
        <li class="list-inline-item">
        <a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/voyantQuestion/delete/$voyantQuestion.questionId"|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Supprimer"><i class="fa fa-trash"></i></a>
        </li>
      </ul>
      </td>
</tr>
{/foreach}
</tbody>
</table>
<!-- /.card-body -->
</div>
<div class="card-footer clearfix">
  <a href="{"/admin/voyantQuestion/create/$voyant.voyantId"|url}">Add new question</a>
</div>
<!-- /.card -->
</div>

<div class="card">
  <div class="card-header">
  <h3 class="card-title">Question buy by user</h3>
  </div>
 <!-- /.card-header -->
<div class="card-body table-responsive p-0 custom-card-body">
<table class="table text-nowrap">
<thead>
<tr>
  <th>Question title</th>
  <th>Status</th>
  <th>Summary</th>
  <th>Invoice</th>
  <th>User name</th>
  <th>Gain</th>
</tr>
</thead>
<tbody>
{foreach from=$voyant.userQuestions item=userQuestion}
<tr class="{cycle values='bg-grey-kin,'}">
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
    <td>{$statistic.answeredQuestionsEarning}€</td>
</tr>
{/foreach}
</tbody>
</table>
<!-- /.card-body -->
</div>
<!-- /.card -->
</div>

<div class="card">
  <div class="card-header">
    <h3 class="card-title">Consultation by phone</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0 custom-card-body">
<table class="table text-nowrap">
<thead>
<tr>
    <th>Date</th>
    <th>Time</th>
    <th>User</th>
    <th>Summary</th>
    <th>Gain</th>
</tr>
</thead>
<tbody>

 {foreach from=$userconsultations item=userConsultation}
<tr class="{cycle values='bg-grey-kin, '}">
    <td> {$userConsultation.created_at|date_format:"%D"}</td>
    <td>{$userConsultation.duration}</td>
    <td>{$userConsultation.user.name}</td>
    <td><a href="#" title="Show invoice" class="">See</a></td>
    <td>{math equation="($statistic.totalEarningPhone/60)*1" format="%.2f"}€ </td>
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
    <h3 class="card-title">Consultation by webcam</h3>
    {include file="includes/tableNavigation.tpl"}
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0 custom-card-body">
<table class="table text-nowrap">
<thead>
<tr>
    <th>Date</th>
    <th>Time</th>
    <th>User</th>
    <th>Summary</th>
    <th>Gain</th>
</tr>
</thead>
<tbody>


 {foreach from=$userconsultationsbywebcam item=userConsultationWeb}
<tr class="{cycle values='bg-grey-kin, '}">
  <td> {$userConsultationWeb.created_at|date_format:"%D"}</td>
    <td>{$userConsultationWeb.duration}</td>
    <td>{$userConsultationWeb.user.name}</td>
    <td><a href="#" title="Show invoice" class="">See</a></td>
    <td>{math equation="($statistic.totalEarningWebcam/60)*1" format="%.2f"}€</td>
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
  <h3 class="card-title">Invoice list</h3>
  </div>
 <!-- /.card-header -->
<div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>

<tr>
  <th>Date of creation</th>
  <th>Date of payment</th>
  <th>Invoice number</th>
  <th>Gain total</th>
  <th>See</th>
</tr>

</thead>
<tbody>
{foreach from=$voyant.userQuestions item=userQuestion}
<tr class="{cycle values='bg-grey-kin,'}">
    
    <td> {$userQuestion.creationDate|date_format:"%D"}</td>
    <td>   {$userQuestion.order.purchaseDate|date_format:"%D"} | {$userQuestion.order.paymentMethod} </td>
    <td>Kin-E-{$userQuestion.order.invoiceId}</td>
    <td>{$userQuestion.order.amount}</td>
    <td><a href="{"/invoice/orderInvoice/$userQuestion.orderId"|url}" title="Show invoice" class="">See nr</a></td>
</tr>
 {/foreach}
</tbody>
</table>
<!-- /.card-body -->
</div>
<!-- /.card -->
</div>

<div class="card">
  <div class="card-header">
  <h3 class="card-title">Comments add by users</h3>
</div>
 <!-- /.card-header -->
<div class="card-body table-responsive p-0">
<table class="table text-nowrap">
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
    <td>{if $voyantComment.validated}<span class="color-28a745">{'Edit_Yes'|lang}</span>{else}<span class="color-dc3545">{'Edit_No'|lang}</span>{/if}</td>
    <td>
    <input type="hidden" name="commentId" value="{$voyantComment.commentId}"/> 
    <input type="hidden" name="remoteIp" value="{$voyantComment.remoteIp}"/>
      {if $voyantComment.validated}
      <a href="#" title="Unpublish" class="color-dc3545" rel="unpublish">{'Unpublish'|lang}</a>
      <br>
      {else}
      <a href="#" title="Publish" class="color-28a745" rel="edit-publish">
      {'Publish'|lang}</a>
      <br>
      {/if}
      <a href="" title="Update comment" class="link_red" rel="save">{'Update'|lang}</a><br>
      <a href="" title="Delete comment" class="link_red" rel="delete">{'Edit_Delete'|lang}</a><br>
      <a href="" title="Ban IP" class="link_red" rel="banIp" >{'Edit_Ban_IP'|lang}</a></td> 
</tr>
{/foreach}
</tbody>
</table>
<!-- /.card-body -->
</div>
<!-- /.card -->
</div>





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