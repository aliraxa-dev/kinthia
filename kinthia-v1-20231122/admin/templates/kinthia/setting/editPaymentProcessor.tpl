{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/setting/editPaymentProcessorOnLoad.js'|resurl}"></script>  
<script type="text/javascript">
setting.paymentProcessor = {$paymentProcessorJson|htmlspecialchars_decode};
</script>
{/capture}
{include file='includes/header.tpl' page="setting" title="{'Payment System - Manage Processors'|lang}"} 
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Edit email</h1>
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
        <h3 class="card-title">{'Payment System - Manage Processors'|lang}</h1>
	</div>
<div class="card-body table-responsive p-0">
<form action="{'/admin/setting/savePaymentProcessor/'|url}" method="post" id="paymentProcessorEditForm">
<input type="hidden" name="processorId" value="">
<table class="table text-nowrap">
<tbody>
<tr>
	<td>{'Processor name'|lang}: </td>
	<td>{$paymentProcessor.processorId}</td>
</tr>
<tr>
	<td>{'Enable'|lang}: </td>
	<td><input type="radio" name="enabled" value="1" /> {'ON'|lang} &nbsp;&nbsp;
    <input type="radio" name="enabled" value="0" /> {'OFF'|lang}</td>
</tr>
<tr>
	<td>{'Display name'|lang}:</td>
	<td><input type="text" class="input_text_medium" name="displayName" value="" /></td>
</tr>
<tr>
	<td>{'Currency name'|lang}:</td>
	<td><input type="text" class="input_text_medium" name="currency" value="" /></td>
</tr>
{if $paymentProcessor.processorId == "PayPal"}
<tr>
	<td>Email:</td>
	<td><input type="text" class="input_text_medium" name="email" value="" /></td>
</tr>
{/if}
{if $paymentProcessor.processorId == "PayPal"}
<tr>
    <td>{'Test mode'|lang}:</td>
    <td><input type="radio" name="testMode" value="1" /> {'ON'|lang} &nbsp;&nbsp;
    <input type="radio" name="testMode" value="0" /> {'OFF'|lang}</td>
</tr>
{/if}
{if $paymentProcessor.processorId == "Stripe"}
<tr>
	<td>Test mode: </td>
	<td><input type="checkbox" class="checkbox" name="stripeTestMode" value=""> Enable Test Mode</td>
</tr>
<tr>
	<td>Stripe public Key: </td>
	<td><input type="text" class="input_text_medium" name="stripePublicKey" value="" /></td>
</tr>
<tr>
	<td>Stripe private Key: </td>
	<td><input type="text" class="input_text_medium" name="stripePrivateKey" value="" /></td>
</tr>
{/if}
<tr>
    <td>Logging: </td>
    <td><input type="checkbox" class="checkbox" name="logging" value=""> Log debug messages</td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" class="button" value="{'Save'|lang}" /></td>
</tr>
</tbody>
</table>
</form>
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