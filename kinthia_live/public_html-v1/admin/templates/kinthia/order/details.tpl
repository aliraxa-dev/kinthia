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
            <h1 class="m-0">Details commandes #$orderId - $whoIsPaid (plateform or $expertName)</h1>
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
  <div class="col-md-4">
    <!-- Profile Image -->
    <div class="card card-primary">
      <div class="card-header">
        <h3 class="card-title">Client</h3>
      </div>
      <div class="card-body box-profile">
        <div class="row">
            <div class="col-lg-12">
              <h4 class="bg-grey-kin py-2 px-2 mb-0">$userName<strong class="text-muted ml-2">#$orderId</strong></h4>
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
    <!-- About Me Box -->
    <div class="card card-primary">
      <div class="card-header">
        <h3 class="card-title">Payment message</h3>
      </div>
    <!-- /.card-header -->
    <div class="card-body popup-gallery">
      <div class="row">
        <div class="col-md-12 mb-1">
          <p>$whoIsPaid (plateform or $expertName)</p>
          <p>$StripeMessage or $PaypalMessage</p>
        </div>
      </div>
    </div>
    <!-- /.card-body -->
    </div>
    <!-- /.card -->
    <div class="card card-primary">
      <div class="card-header">
        <h3 class="card-title">Invoice</h3>
      </div>
    <!-- /.card-header -->
    <div class="card-body popup-gallery">
      <div class="row">
        <div class="col-md-12 mb-1">
          <a href="/kinthia15/admin/order/invoiceDetails">See invoice</a>
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
    <h3 class="card-title">Items ($itemCount)</h3>
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


<!-- /.card -->
<div class="card">
  <div class="card-header">
    <h3 class="card-title">Status</h3>
  </div>
<!-- /.card-header -->
<div class="card-body table-responsive p-0">
  <table class="table text-nowrap">
  <tbody>
  <tr class="" id="commentForm2">  
    <td>
      $status (payment validated/cancelled)
    </td>
    <td>
      $user.email
    </td>
    <td>
      $date format(dd/mm/YYYY)
    </td>
  </tr>
  <tr class="" id="commentForm2">  
    <td>
      <span class="badge rounded badge-print-light" style="background-color: #FF8C00; color: black;">Refunded</span>
    </td>
    <td>
      admin@kinthia.com
    </td>
    <td>
      31/01/2023
    </td>
  </tr>
  <tr class="" id="commentForm2">  
    <td>
      <span class="badge rounded badge-print-light" style="background-color: #E74C3C; color: white;">Cancelled</span>
    </td>
    <td>
      admin@kinthia.com
    </td>
    <td>
      22/01/2023
    </td>
  </tr>
  <tr class="" id="commentForm2">  
    <td>
      <span class="badge rounded badge-print-light" style="background-color: #01b887; color: white;">Payment accepted</span>
    </td>
    <td>
      admin@kinthia.com
    </td>
    <td>
      20/01/2023
    </td>
  </tr>
  </tbody>
  </table>
</div>
<!-- /.card-body -->
<div class="card-footer clearfix">
  <div class="row">
  <div class="col-sm-6 offset-sm-6">
    <form name="update_order_status" method="post" action="/ecrire/index.php/sell/orders/3674/status?_token=-bIksNXo1kMNz2_aIdA9Wv6eL5CpJZo0pu8J4fBl7Ag" class="card-details-form form-horizontal">
      <div class="form-group card-details-actions">
        <select id="update-order-status" name="update_order-status" class="custom-select" aria-label="update-order-status">
          <option value="3" data-background-color="#E74C3C" style="background-color: #E74C3C; color: white;">Cancelled</option>
          <option value="2" data-background-color="#FF8C00" data-is-bright="data-is-bright" selected="selected" style="background-color: #FF8C00; color: black;">Refunded</option>
          <option value="1" data-background-color="#01b887" style="background-color: #01b887; color: white;">Payment accepted</option>
        </select>

        <button class="btn btn-primary update-status w-100 ml-3">
          Update status
        </button>
      </div>
  </form>
  </div>
</div>
    
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