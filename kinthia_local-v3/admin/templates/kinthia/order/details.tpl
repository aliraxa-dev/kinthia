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
            <h1 class="m-0">Details commandes #{$orderDetails.orderId} - {$orderDetails.type}</h1>
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
              <h4 class="bg-grey-kin py-2 px-2 mb-0">{$orderDetails.user.name}<strong class="text-muted ml-2">#{$orderDetails.orderId}</strong></h4>
            </div>
        </div>
        <div class="row mt-3">
        <div id="customerEmail" class="col-lg-6">
          <p class="mb-1">
            <strong>E-mail :</strong>
          </p>
          <p>
            {$orderDetails.user.email}
          </p>
          <p class="mb-1">
            <strong>Account created :</strong>
          </p>
          {if $orderDetails.user.createdAt eq ''}
            <p>00/00/0000</p>
          {else}
            <p>{$orderDetails.user.createdAt|date_format:"%d/%m/%Y %H:%M:%S"}</p>
          {/if}
        </div>

        <div id="validatedOrders" class="col-lg-6">
          <p class="mb-1">
            <strong>Validated orders :</strong>
          </p>
          <p>
            <span class="badge rounded badge-dark">{$totalOrdersCount}</span>
          </p>
          <p class="mb-1">
            <strong>Total spent since registration :</strong>
          </p>
          <p>
            <span class="badge rounded badge-dark">{$totalOrdersEarning}&nbsp;€</span>
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
          <p>{$orderDetails.type}</p>
          <p>{$orderDetails.paymentMethod}</p>
          {if $orderDetails.stripeData}
          <p>Stripe Data: {$orderDetails.stripeData}</p>
          {/if}
          {if $orderDetails.payPalId != ''}
          <p>PayPal Id: {$orderDetails.payPalId}</p>
          {/if}
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
          <a href="/user/order/details/{$orderDetails.orderId}">See invoice</a>
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
    <h3 class="card-title">Items ({$orderItemsCount})</h3>
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
      {foreach from=$orderDetails.orderItems item=orderItem}
        <tr class=" ">
          <td>
            {$orderItem.voyantQuestion.title}
          </td>
          <td>
            {$orderItem.totalPrice / $orderItem.quantity} €
          </td>
          <td>
            {$orderItem.quantity}
          </td>
          <td>
           {$orderItem.totalPrice}€
          </td>
        </tr>
      {/foreach}
       {foreach from=$orderPackages.orderItems item=orderItem}
        <tr class=" ">
          <td>
            {$orderItem.packageName}
          </td>
          <td>
            {$orderItem.packagePrice} €
          </td>
          <td>
            1
          </td>
          <td>
           {$orderItem.packagePrice}€
          </td>
        </tr>
      {/foreach}
    </tbody>
    </table>
  </div>
  <!-- /.card-body -->
  <div class="card-footer text-right clearfix">
    <strong>Total : {$orderDetails.amount}€</strong>
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
      Status
    </td>
    <td>
      Email
    </td>
    <td>
      Date
    </td>
  </tr>
  <tr class="" id="commentForm2">
    <td>
      {if $orderDetails.status eq 'paid'}
        <span class="badge rounded badge-print-light" style="background-color: #01b887; color: white;">Payment accepted</span>
      {elseif $orderDetails.status eq 'unpaid'}
        <span class="badge rounded badge-print-light" style="background-color: #FF8C00; color: black;">Un Paid</span>
      {elseif $orderDetails.status eq 'denied'}
        <span class="badge rounded badge-print-light" style="background-color: #E74C3C; color: white;">Cancelled</span>
      {elseif $orderDetails.status eq 'refund'}
        <span class="badge rounded badge-print-light" style="background-color: #E74C3C; color: white;">Refund</span>
      {else}
        <span class="badge rounded badge-print-light" style="background-color: #E74C3B; color: white;">Pending</span>
      {/if}
    </td>
    <td>
      {$orderDetails.user.email}
    </td>
    <td>
      {$orderDetails.purchaseDate|date_format:"%d/%m/%Y"}
    </td>
  </tr>
  </tbody>
  </table>
</div>
<!-- /.card-body -->
<div class="card-footer clearfix">
  <div class="row">
  <div class="col-sm-6 offset-sm-6">
    <form name="update_order_status" method="post" action="/admin/order/updateOrderStatus" class="card-details-form form-horizontal">
      <input type="hidden" value="{$orderDetails.orderId}" name="orderIdVal">
      <div class="form-group card-details-actions">
        <select id="updateOrderStatusVal" name="updateOrderStatusVal" class="custom-select" aria-label="update-order-status">
          {if $orderDetails.status eq 'paid'}
            <option value="paid" selected="selected" data-background-color="#01b887" style="background-color: #01b887; color: white;">Paid</option>
          {else}
            <option value="paid" data-background-color="#01b887" style="background-color: #01b887; color: white;">Paid</option>
          {/if}
          {if $orderDetails.status eq 'unpaid'}
            <option value="unpaid" selected="selected" data-background-color="#FF8C00" data-is-bright="data-is-bright" style="background-color: #FF8C00; color: black;">Un-Paid</option>
          {else}
            <option value="unpaid" data-background-color="#FF8C00" data-is-bright="data-is-bright"  style="background-color: #FF8C00; color: black;">Un-Paid</option>
          {/if}
          {if $orderDetails.status eq 'refund'}
            <option value="refund" selected="selected" data-background-color="#ff0000" data-is-bright="data-is-bright" style="background-color:#ff0000; color: black;">Refund</option>
          {else}
            <option value="refund" data-background-color="#ff0000" data-is-bright="data-is-bright"  style="background-color:#ff0000; color: black;">Refund</option>
          {/if}
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
