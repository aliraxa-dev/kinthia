{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="{'/admin/javascript/voyant/voyantPendingInvoice.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="Pending voyant invoices - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Pending voyant invoices</h1>
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
        <h3 class="card-title">Pending Invoices</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form action="{"/admin/voyantInvoice/updateOrderInvoiceStatus"|url}" method="post" id="orderInvoiceFrm">
        <input type="hidden" name="orderIds" id="orderIds">
        <input type="hidden" name="type" id="orderIds">
      <div id="holderOfWaitingSites" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th><input type="checkbox" id="checkAll"/></th>
              <th>Date</th>
              <th>Invoice number</th>
              <th>Voyant</th>
              <th>Gain total</th>
              <th>See</th>
              <th>Type of payment</th>
            </tr>
          </thead>
          <tbody>
          {* {if $pendingOrders}
            {foreach from=$pendingOrders item=myorders key=rkey}  
              {foreach from=$myorders item=order key=voyntkey}
                {foreach from=$platformInvoices item=Invoices key=voyId} 
                  {if $voyntkey === $voyId}             
                    {foreach from=$Invoices item=invoice key=rkey}
                      {if $order.yearMonth[0]===$invoice.invoice_date}
                        {if $order.tvaCalculatedAmt[0]}
                          <tr class="{cycle values='bg-grey-kin, '}">                    
                          <td><input type="checkbox" class="checkbox" name="checkValues[]" value="{$order.voyantId},{$order.date[0]},{$order.shortName}-{$invoice.invoicePlatformNumber}" /></td>
                          <td>{$order.date[0]|date_format:"%B, %Y"}</td>
                          <td>{$order.shortName}-{$invoice.invoicePlatformNumber}</td>
                          <td>{$order.name} - {$order.email}</td>
                          <td>                     
                              {math equation=($order.tvaCalculatedAmt[0]) format="%.2f"}€                         
                          </td>
                          <td>
                              {assign var=orderDte value=$order.date[0]|date_format:"%Y-%m"}
                            <a target="_blank" href="{"/admin/voyantInvoice/details/$order.voyantId/$order.paymentExpertPlatform/$orderDte/$order.shortName-$invoice.invoicePlatformNumber"|url}">voir les détails</a>
                          </td>
                          <td>
                            <select name="status" class="form-control w-auto d-inline-block mr-2">
                              <option value=""> Virement </option>
                              <option value="paypal"> Paypal </option>
                              <option value="stripe"> Stripe </option>
                            </select>
                          </td>
                          </tr>
                        {/if}
                      {/if} 
                    {/foreach}                   
                   {/if} 
                  {/foreach}                   
                {/foreach}
              {/foreach}       
            {/if} *}

            {if $pendingInvoiceArr}
              {foreach from=$pendingInvoiceArr item=myorders key=fkey} 
                {foreach from=$myorders item=order key=voyntkey}
                      <tr class="{cycle values='bg-grey-kin, '}">                      
                        <td><input type="checkbox" class="checkbox" name="checkValues[]" value="{$order.voyantId},{$order.Date},{$order.shortName}-{$order.invoicePlatformNumber}" /></td>
                        <td>{$order.Date|date_format:"%B, %Y"}</td>
                        <td>{$order.shortName}-{$order.invoicePlatformNumber}</td>
                        <td>{$order.name} - {$order.email}</td>
                        <td>                     
                            {math equation=($order.tvaCalculatedAmt) format="%.2f"}€                         
                        </td>
                        <td>
                            {assign var=orderDte value=$order.Date|date_format:"%Y-%m"}
                          <a target="_blank" href="{"/admin/voyantInvoice/details/$order.voyantId/$order.paymentExpertPlatform/$orderDte/$order.shortName-$order.invoicePlatformNumber"|url}">voir les détails</a>
                        </td>
                        <td>
                          <select name="status" class="form-control w-auto d-inline-block mr-2">
                            <option value=""> Virement </option>
                            <option value="paypal"> Paypal </option>
                            <option value="stripe"> Stripe </option>
                          </select>
                        </td>
                      </tr>
                {/foreach}
              {/foreach} 
            {/if}
          </tbody>
        </table>
      </div>
      <div class="card-footer clearfix">
        <select name="status" class="form-control w-auto d-inline-block mr-2">
        <option value="answered" selected="selected"> Validate payment </option>
        </select>
        <input type="button" id="ok" class="btn btn-primary btn-kin" value="OK" />
      </div>    
      <!-- /.card-body -->
    </div>
  </form>
    <!-- /.card -->
  </div>
</div>
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file="includes/footer.tpl"}
