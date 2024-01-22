{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="index" title="Message en attente - {'Admin - Kinthia'|lang}"}
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
      <div class="card-header">
        <h3 class="card-title">{$statistic.pendingMessagesCount} messages en attente</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div id="holderOfWaitingSites" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Voyant</th>
              <th>Consultant</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
             {foreach from=$voyantmessages item=voyantmessage}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>{$voyantmessage.date|date_format:"%d-%m-%Y %I:%M %p"}
              <!-- 28-09-2020 à 17h25 --></td>
              <td>{$voyantmessage.voyant.name}</td>
              <td>{$voyantmessage.user.name}</td>
              <td><a href="{"/admin/userMessage/details/$voyantmessage.userId/$voyantmessage.voyantId"|url}" >Voir</a></td>
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