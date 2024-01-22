{capture assign="headData"}
{/capture}
{capture assign="footerData"}

{/capture}
{include file='includes/header.tpl' page="index" title="Invoices list - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Invoices list</h1>
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
        <button class="btn btn-primary update-status">
          Generate invoices
        </button>
      </div>
    </div>

    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Invoices list $date (January 2023)</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div id="orderList" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Expert</th>
              <th>Invoice number</th>
              <th>Start Date</th>
              <th>End date</th>
              <th>See</th>
            </tr>
          </thead>
          <tbody>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>$userName</td>
              <td>$invoiceNumber</td>
              <td>$startDate</td>
              <td>$EndDate</td>
              <td><a href="{'/admin/order/cartDetails'|url}">See</a></td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>Bibhicette25</td>
              <td>K-Bibhicette25-21</td>
              <td>01/01/2023</td>
              <td>31/01/2023</td>
              <td><a href="{'/admin/order/cartDetails'|url}">See</a></td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>Rouge Pivoine</td>
              <td>K-RougePivoine-1</td>
              <td>01/01/2023</td>
              <td>31/01/2023</td>
              <td><a href="{'/admin/order/cartDetails'|url}">See</a></td>
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