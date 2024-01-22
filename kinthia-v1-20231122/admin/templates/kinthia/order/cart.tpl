{capture assign="headData"}
{/capture}
{capture assign="footerData"}

{/capture}
{include file='includes/header.tpl' page="index" title="Cart - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Cart</h1>
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
        <h3 class="card-title">Cart</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form>
      <div id="orderList" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Cart Id</th>
              <th>Order ID</th>
              <th>Client</th>
              <th>Total</th>
              <th>Details</th>
            </tr>
          </thead>
          <tbody>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>$28/09/2021</td>
              <td>$414154545454</td>
              <td>$41781458</td>
              <td>$userName</td>
              <td>$TotalPrice</td>
              <td><a href="{'/admin/order/cartDetails'|url}">See</a></td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>28/09/2021</td>
              <td>7878fg8787fg7gjjcsv1</td>
              <td>750</td>
              <td>Bichette</td>
              <td>250.00€</td>
              <td><a href="{'/admin/order/cartDetails'|url}">See</a></td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>28/09/2021</td>
              <td>4dgfh47h545454</td>
              <td>--</td>
              <td>--</td>
              <td>0.00€</td>
              <td><a href="{'/admin/order/cartDetails'|url}">See</a></td>
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