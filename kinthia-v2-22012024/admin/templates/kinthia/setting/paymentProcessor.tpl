{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="setting" title="{'Payment System - Payment Processor'|lang}"} 
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{'Payment System - Payment Processor'|lang}</h1>
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
<div class="content">
<div class="container-fluid">
<div class="row">
<div class="col-md-12">

<div class="card">
    <div class="card-header">
        <h3 class="card-title">{'Payment System - Payment Processor'|lang}</h3>
	</div>
<div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>
<tr>
	<th>{'Proccessor Name'|lang}</th>
	<th>{'Enabled'|lang}</th>
	<th>{'Management'|lang}</th>
</tr>
</thead>
<tbody>
{foreach from=$paymentProcessors value=paymentProcessor} 
<tr class="{cycle values='bg-grey-kin,'}">
	<td>{$paymentProcessor.processorId}</td>
	<td>{if $paymentProcessor.enabled}<span class="text_green">{'Yes'|lang}</span>{else}<span class="text_red">{'No'|lang}</span>{/if}</td>
	<td><a href="{"/admin/setting/editPaymentProcessor/$paymentProcessor.processorId"|url}" title="Edit payment processor" class="link_green">{'Edit'|lang}</a></td>
</tr>
{/foreach}
</tbody>
</table>
</div>
</div>
</div>
</div>
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->

{include file='includes/footer.tpl'} 