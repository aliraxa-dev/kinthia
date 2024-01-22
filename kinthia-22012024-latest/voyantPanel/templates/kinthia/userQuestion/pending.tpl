{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/voyantPanel/javascript/userQuestions/pendingOnLoad.js'|resurl}"></script>
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="{'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Questions en attente</h1>
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
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">{$userQuestionsCount} questions à traiter</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form action="{'/voyantPanel/userQuestion/updateUserQuestionStatus'|url}" method="post" id="pendingUserQuestionsForm">
      <div id="holderOfWaitingSites" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th><input type="checkbox" id="checkAll"/></th>
              <th>Date</th>
              <th>Intitulé de la question</th>
              <th>Consultant</th>
              <th>Paiement</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$userQuestions item=userQuestion}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td><input type="checkbox" class="checkbox" name="questionIds[]" value="{$userQuestion.questionId}" /></td>
              <td>
              {$userQuestion.creationDate|date_format:"%d"}-{$userQuestion.creationDate|date_format:"%m"}-{$userQuestion.creationDate|date_format:"%Y"} à {$userQuestion.creationDate|date_format:"%H"}h{$userQuestion.creationDate|date_format:"%M"}

              {* {$userQuestion.creationDate} *}</td>
              <td>{$userQuestion.voyantQuestion.title}</td>
              <td><a href="{"/voyantPanel/user/show/$userQuestion.user.userId"|url}" >{$userQuestion.user.name}</a></td>
              <td><span class="color-28a745">Validé</span></td>
            </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
      <div class="card-footer clearfix">
        <select name="status" class="form-control w-auto d-inline-block mr-2">
        <option value="answered" selected="selected"> {'Pending_Question_finished'|lang}</option>
        </select>
        <input type="submit" class="btn btn-primary btn-kin" value="OK" />
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

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
  <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
{include file="includes/footer.tpl"}