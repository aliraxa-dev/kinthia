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
        <p><strong>Cart ID</strong>: {$cartDetails[0].cartId}</p>
        <p><strong>Cart total</strong>: {$cartToalEarning}&nbsp;€</p>
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
              <h4 class="bg-grey-kin py-2 px-2 mb-0">{$cartDetails[0].user.name}</h4>
            </div>
        </div>
        <div class="row mt-3">
        <div id="customerEmail" class="col-lg-6">
          <p class="mb-1">
            <strong>E-mail :</strong>
          </p>
          <p>
            {$cartDetails[0].user.email}
          </p>
          <p class="mb-1">
            <strong>Account created :</strong>
          </p>
          {if $cartDetails[0].user.createdAt eq ''}
            <p>00/00/0000</p>
          {else}
            <p>{$cartDetails[0].user.createdAt|date_format:"%d/%m/%Y %H:%M:%S"}</p>
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
  </div>
<div class="col-md-8">
<!-- /.card -->
  <div class="card">
  <div class="card-header">
    <h3 class="card-title">Cart Contents - Items ({$cartItemsCount})</h3>
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
    {foreach from=$itemsList item=cartItems}
    {if $cartItems }
    <tr class=" ">
      <td>
        {$cartItems.name}
      </td>
      <td>
        {$cartItems.totalPrice}€
      </td>
      <td>
        {$cartItems.quantity}
      </td>
      <td>
        {$cartItems.totalPrice * $cartItems.quantity} €
      </td>
    </tr>
    {else}
    <p>No Items in this cart</p>
    {/if}
    {/foreach}
    </tbody>
    </table>
  </div>
  <!-- /.card-body -->
  <div class="card-footer text-right clearfix">
    <strong>Total : {$cartToalEarning}&nbsp;€</strong>
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