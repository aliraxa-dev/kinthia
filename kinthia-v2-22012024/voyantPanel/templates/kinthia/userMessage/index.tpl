{capture assign="headData"}
{/capture}
{capture assign="footerData"}

<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/userQuestions/pendingOnLoad.js'|resurl}"></script>

<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>

<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>

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
            <h1 class="m-0">Messages en attente</h1>
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
  <div class="card-body">
  <form action="{'/voyantPanel/userMessage/'|url}" method="post">
  You can search users. just write their email or a part of their email<br /><br />
  <input type="text" class="input_text_medium" name="email" value="" /> <input type="submit" class="button" value="Search" />
  </form>

  </div>
  </div>
  </div>
</div>
<div class="row">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">{$statistic.voyantPendingMessageCount} messages en attente</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div id="holderOfWaitingSites" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Nouveau Message</th>
              <th>Consultant</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$voyantmessages item=voyantmessage}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>{$voyantmessage.date|date_format:"%d-%m-%Y at %I:%M %p"}</td>
              <td>{if $voyantmessage.view==1}Non{else}Oui{/if}</td>
              <td>{$voyantmessage.user.name}</td>
              <td><a href="{"/voyantPanel/userMessage/details/$voyantmessage.userId"|url}">Répondre / Envoyer</a></td>
            </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
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
