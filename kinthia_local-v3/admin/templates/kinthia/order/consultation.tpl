{capture assign="headData"}
<link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/daterangepicker/daterangepicker.css'|resurl}">
{/capture}
{capture assign="footerData"}

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
          <a class="btn btn-secondary bg-white mx-3" href="/admin/order/consultation/">Reset</a>
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
              <th>Expert</th>
              <th>Type</th>
              <th>Start</th>
              <th>End</th>
              <th>Duration</th>
              <th>Ended by</th>
              <th>Status</th>
              <th>Export Earning</th>
              <th>Reason</th>
            </tr>
          </thead>
          <tbody>
          {foreach from=$consultationArr item=consultation}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>{$consultation.userconsultationId}</td>
              <td>{$consultation.date}</td>
              <td>{$consultation.user.name}</td>
              <td>{$consultation.voyant.name}</td>
              <td>{$consultation.type}</td>
              <td>{$consultation.start_time}</td>
              <td>{$consultation.end_time}</td>
              <td>{$consultation.duration}</td>
              <td>
              {if $consultation.ended_by eq 'U'}
              User
              {elseif $consultation.ended_by eq 'E'}
              Expert
              {elseif $consultation.ended_by eq 'O'}
              Other
              {/if}
              </td>
              <td>
              {if $consultation.status eq 'E'}
              End
              {elseif $consultation.status eq 'C'}
              Cancel
              {elseif $consultation.status eq 'P'}
              Pending
              {/if}
              </td>
              <td>{$consultation.expertEarning}&nbsp;€</td>
              <td>{$consultation.reason}</td>
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

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
  <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
{include file="includes/footer.tpl"}

<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/moment/moment.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/daterangepicker/daterangepicker.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/order/consultation.js'|resurl}"></script>