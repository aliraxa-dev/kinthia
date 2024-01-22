{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/voyantPanel/javascript/userQuestions/pendingOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="Language - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Create Language</h1>
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

      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <tbody>
            <tr>
              <td>Name</td><td><input type="text" class="" name="name" ></td>
            </tr>
            <tr>
              <td>Small name</td><td><input type="text" class="" name="" ></td>
            </tr>
            <tr>
              <td>Flag</td><td><input type="file" class="" name="" ></td>
            </tr>
            <tr>
              <td></td><td><input type="submit" class="btn btn-primary" value="Create language"></td>
            </tr>
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