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
{include file='includes/header.tpl' page="index" title="{'Calendar - Kinthia'|lang}"}
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
              <th>ID</th>
              <th>Date</th>
              <th>User</th>
              <th>Type</th>
              <th>Start</th>
              <th>End</th>
              <th>Duration</th>
              <th>Ended by</th>
              <th>Status</th>
              <th>Reason</th>
              <th>Earnings</th>
            </tr>
          </thead>
          <tbody>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>$consultationId</td>
              <td>$date</td>
              <td>$userName</td>
              <td>$type</td>
              <td>$start</td>
              <td>$end</td>
              <td>$duration</td>
              <td>$endedBy</td>
              <td>$status</td>
              <td>$reason</td>
              <td>$earnings</td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>428</td>
              <td>18/11/2021</td>
              <td>Bibichette45</td>
              <td>phone</td>
              <td>2021-11-18 06:00:00</td>
              <td>2021-11-18 07:23:32</td>
              <td>01:23:32</td>
              <td>Expert</td>
              <td>End</td>
              <td>Consultation ended by the Rouge Pivoine</td>
              <td>22.53€</td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>428</td>
              <td>2022-02-26</td>
              <td>Arf</td>
              <td>webcam</td>
              <td>2022-02-26 03:14:17</td>
              <td>2022-02-26 03:15:41</td>
              <td>00:01:24</td>
              <td>User</td>
              <td>End</td>
              <td>Consultation ended by the Arf</td>
              <td>00.17€</td>
            </tr>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>428</td>
              <td>2022-02-26</td>
              <td>Arf</td>
              <td>phone</td>
              <td>--</td>
              <td>--</td>
              <td>--</td>
              <td>User</td>
              <td>Cancel</td>
              <td>Arf disconnected</td>
              <td>00.00€</td>
            </tr>
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