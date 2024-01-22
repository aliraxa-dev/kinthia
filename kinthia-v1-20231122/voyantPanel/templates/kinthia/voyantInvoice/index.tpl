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
        <h3 class="card-title">Liste des commandes {$voyant.name}</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form>
      <div id="orderList" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Order ID</th>
              <th>Order Item Title</th>
              <th>Total</th>
              <th>Who was paid</th>
              <th>Paiement</th>
              <th>Invoice</th>
            </tr>
          </thead>
          <tbody>
            {if $orders}
            {foreach from=$orders item=order key=mkey}
              <tr class="{cycle values='bg-grey-kin, '}">
                <td>{$order.purchaseDate|date_format:"%d/%m/%Y"}</td>
                <td>{$order.orderId}</td>
                <td>{$order.title}</td>
                <td>{if !empty($order.totalQuestPrice)}
                       {math equation=($order.totalQuestPrice) format="%.2f"}€ 
                   {/if}
                </td>
                <td>{$voyant.name}</td>
                {* <td>{$order.paymentMethod}</td> *}
                <td><span class="color-28a745">Validé</span> - {$order.paymentMethod} </td>
                <td><a href="{"/voyantPanel/voyantInvoice/details/$order.orderId"|url}">voir facture</a></td></td>
              </tr>
            {/foreach}
          {/if}

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
