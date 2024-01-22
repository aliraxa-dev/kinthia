{capture assign="headData"}
{/capture}
{capture assign="footerData"}

{/capture}
{include file='includes/header.tpl' page="index" title="Cart details - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Cart details</h1>
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
  <div class="col-lg-12">
    <div class="card card-primary">
      <div class="card-body box-profile">
        <p><strong>Cart ID</strong>: $cartId</p>
        <p><strong>Cart total</strong>: $cartTotalPrice</p>
      </div>
    </div>
  </div>




  <div class="col-md-4">
    <!-- Profile Image -->
    <div class="card card-primary">
      <div class="card-header">
        <h3 class="card-title">Client</h3>
      </div>
      <div class="card-body box-profile">
        <div class="row">
            <div class="col-lg-12">
              <h4 class="bg-grey-kin py-2 px-2 mb-0">$userName</h4>
            </div>
        </div>
        <div class="row mt-3">
        <div id="customerEmail" class="col-lg-6">
          <p class="mb-1">
            <strong>E-mail :</strong>
          </p>
          <p>
            torres_bernard@yahoo.fr
          </p>
          <p class="mb-1">
            <strong>Account created :</strong>
          </p>
          <p>29/01/2023 23:04:10</p>
        </div>

        <div id="validatedOrders" class="col-lg-6">
          <p class="mb-1">
            <strong>Validated orders :</strong>
          </p>
          <p>
            <span class="badge rounded badge-dark">1</span>
          </p>
          <p class="mb-1">
            <strong>Total spent since registration :</strong>
          </p>
          <p>
            <span class="badge rounded badge-dark">340,87&nbsp;€</span>
          </p>
        </div>
        </div>
      </div>
    <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
<div class="col-md-8">
<!-- /.card -->
  <div class="card">
  <div class="card-header">
    <h3 class="card-title">Cart Contents - Items ($itemCount)</h3>
  </div>
  <!-- /.card-header -->
  <div class="card-body table-responsive p-0">
    <table class="table text-nowrap">
    <thead>
      <tr>
        <th>Item</th>
        <th>Price per unit<br><small>VAT INCLUDED</small></th>
        <th>Quantity</th>
        <th>Total<br><small>VAT INCLUDED</small></th>
      </tr>
    </thead>
    <tbody>
    <tr class=" ">
      <td>
        Question add for expert in Admin panel
      </td>
      <td>
        15.00€
      </td>
      <td>
        2
      </td>
      <td>
        30.00€
      </td>
    </tr>
    <tr class="bg-grey-kin">
      <td>
        Pack time 2 - (15min)
      </td>
      <td>
        15.00€
      </td>
      <td>
        1
      </td>
      <td>
        15.00€
      </td>
    </tr>
    <tr class=" ">
    <td>
        Pack time 3 - (30min)
      </td>
      <td>
        40.00€
      </td>
      <td>
        4
      </td>
      <td>
        160.00€
      </td>
    </tr>
    </tbody>
    </table>
  </div>
  <!-- /.card-body -->
  <div class="card-footer text-right clearfix">
    <strong>Total : 205.00€</strong>
  </div>
  </div>
  <!-- /.card -->

</div>
</div>
<!-- /.row -->

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