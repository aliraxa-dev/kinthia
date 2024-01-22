{capture assign="headData"}
{/capture}
{capture assign="footerData"}

{/capture}
{include file='includes/header.tpl' page="index" title="Liste des commandes - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Liste des commandes</h1>
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
        <h3 class="card-title">Liste des commandes</h3>
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
              <th>Order ID</th>
              <th>Total</th>
              <th>Who was paid</th>
              <th>Status</th>
              <th>Details</th>
            </tr>
          </thead>
          <tbody>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>$28/09/2021</td>
              <td>$userName</td>
              <td>$41781458</td>
              <td>$TotalPrice</td>
              <td>Plateform or $expertName</td>
              <td>$status</td>
              <td><a href="{'/admin/order/details'|url}">See</a></td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>30/01/2023</td>
              <td>Germain77</td>
              <td>787</td>
              <td>280.00€</td>
              <td>Rouge Pivoine</td>
              <td><span class="badge rounded badge-print-light" style="background-color: #01b887; color: white;">Payment accepted</span></td>
              <td><a href="{'/admin/order/details'|url}">See</a></td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>23/12/2022</td>
              <td>Eglantine</td>
              <td>1788</td>
              <td>75.00€</td>
              <td>Plateform</td>
              <td><span class="badge rounded badge-print-light" style="background-color: #E74C3C; color: white;">Cancelled</span></td>
              <td><a href="{'/admin/order/details'|url}">See</a></td>
            </tr>
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>28/09/2021</td>
              <td>UserNameExample</td>
              <td>2977</td>
              <td>259.00€</td>
              <td>ExpertNameExample</td>
              <td><span class="badge rounded badge-print-light" style="background-color: #FF8C00; color: black;">Refunded</span></td>
              <td><a href="{'/admin/order/details'|url}">See</a></td>
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