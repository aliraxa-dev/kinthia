{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script> 
<script type="text/javascript" src="{'/admin/javascript/setting/emailOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="setting" title="Edit email"} 
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
        <div class="card-body">
        {'You can customize the various e-mails sent to the webmaster and administrator on this page'|lang}.<br />
        {'You can send a personalized e-mail not specified for each site in the sites on waiting'|lang}.
        </div>
    </div>

<div class="card">
    <div class="card-header">
        <h3 class="card-title">{$message.userText}</h3>
    </div>
<div class="card-body table-responsive p-0">
<form action="{'/admin/setting/saveEditMessage'|url}" method="post">
<input type="hidden" name="messageId" value="{$message.messageId}" > 
<table class="table text-nowrap">
<tbody>
{if $message.messageId != "newsletterFooter"}
<tr>
	<td>{'Subject'|lang}: </td>
	<td><input type="text" class="input_text_large" name="title" value="{$message.title}" /></td>
</tr>
{/if}
<tr>
    <td>{'Text'|lang}: </td>
    <td>
    <input type="button" class="button autocode" value="[voyant pseudo]" />
    <input type="button" class="button autocode" value="[voyant firstName]" />
    <input type="button" class="button autocode" value="[voyant lastName]" /> 
    <input type="button" class="button autocode" value="[user pseudo]" /><br/>  
    <input type="button" class="button autocode" value="[order orderId]" />
    <input type="button" class="button autocode" value="[order invoiceId]" />
    <input type="button" class="button autocode" value="[user email]" />
    <input type="button" class="button autocode" value="[user message]" />
    <br/>
    <textarea class="textarea_extra_large" name="description" cols="50" rows="5">{$message.description}</textarea></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" class="button" value="{'Save'|lang}"  /></td>
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