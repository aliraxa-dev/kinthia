{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="{'Liste des utilisateurs - Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Liste des utilisateurs</h1>
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
    <form action="{'/voyantPanel/user'|url}" method="post">
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
        <h3 class="card-title">{$usersCount} utilisateurs vous ont consulté</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
        <thead>
        <tr>
          <th>Pseudo</th>
          <th>Question acheté</th>
          <th>consultation par téléphone</th>
          <th>consultation par webcam</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        {foreach from=$users item=user}
        <tr class="line1">
          <td>{$user.name}</td>
          <td>{$user.boughtQuestionsCount}</td>
          <td>{$user.phoneCount}</td>
          <td>{$user.webcamCount}</td>
          <td><a href="{"/voyantPanel/user/show/$user.userId"|url}" title="Edit user" class="link_green">Détails</a></td>
        </tr>
        {/foreach}
        </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->

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