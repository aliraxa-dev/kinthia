{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/voyantPanel/javascript/userQuestions/pendingOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="Language list - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Language list</h1>
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

        <h3 class="card-title">Create Language</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form action="{"/admin/Language/save"|url}" method="post" enctype="multipart/form-data">
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <tbody>
            <tr>
              <td>Name</td><td><input type="text" class="" name="language" required=""></td>
            </tr>
            <tr>
              <td>Code</td><td><input type="text" class="" name="languageCode" required=""></td>
            </tr>
            <tr>
              <td>Flag</td><td><input type="file" class="" name="languageFlag"></td>
            </tr>
            <tr>
              <td></td><td><input type="submit" class="btn btn-primary" value="Create language"></td>
            </tr>
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
<div class="row">
  <div class="col-md-12">
     <div id="message" {if $message} style="background: green; color:#fff; text-align: center; padding: 5px 5px 5px 5px" {/if}>
      {$message}
     </div>
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Language list</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Name</th>
              <th>Code</th>              
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$languages item=langauge}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>{$langauge.language}</td>
              <td>{$langauge.languageCode}</td>
              <td>
                <ul class="list-inline m-0">
                  <li class="list-inline-item">
                  <a  href="{"/admin/Language/edit/$langauge.languageId"|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
                  </li>
                  <li class="list-inline-item">
                  <a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/Language/delete/$langauge.languageId"|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Supprimer"><i class="fa fa-trash"></i></a>
                  </li>
                </ul>
              </td>
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