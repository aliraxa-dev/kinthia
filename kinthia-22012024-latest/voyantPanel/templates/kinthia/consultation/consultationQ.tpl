{capture assign="headData"}
<link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/daterangepicker/daterangepicker.css'|resurl}">
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/moment/moment.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/daterangepicker/daterangepicker.js'|resurl}"></script>
<script>
{literal}
  $(function() {
    $('#reservation').daterangepicker()
  });
{/literal}
</script>
{/capture}
{include file='includes/header.tpl' page="index" title="Liste des consultation - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Liste des consultations</h1>
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
        <div class="form-group">
        <label>Date range:</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">
                <i class="far fa-calendar-alt"></i>
              </span>
            </div>
          <input type="text" class="form-control float-right" style="flex: unset; width: 300px;" id="reservation">
          <button class="btn btn-primary update-status ml-3">
            Search
          </button>
          </div>
        </div>
      </div>
    </div>

    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Liste des consultations</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form>
      <div id="orderList" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>User</th>
              <th>Question</th>
              <th>Status</th>
              <th>Earnings</th>
            </tr>
          </thead>
          <tbody>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>$date</td>
              <td>$userName</td>
              <td>$questionTitle</td>
              <td>$status</td>
              <td>$earnings</td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>2021-11-18 13:10:53</td>
              <td>Arf</td>
              <td>Questions spirituelles</td>
              <td>Answered</td>
              <td>6.25€</td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>2021-11-18 13:10:53</td>
              <td>user Example Name</td>
              <td>Questions title example</td>
              <td>pending</td>
              <td>pending - no answer -> no money  - 0.00€</td>
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