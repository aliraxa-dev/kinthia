{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script> 
<script type="text/javascript" src="{'/admin/javascript/setting/emailOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="setting" title="{'E-mails'|lang}"} 
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{'Emails list'|lang}</h1>
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
        <div class="card-body">
        {'You can customize the various e-mails sent to the webmaster and administrator on this page'|lang}.<br />
        {'You can send a personalized e-mail not specified for each site in the sites on waiting'|lang}.
        </div>
    </div>

    <div class="card">
    <div class="card-header">
        <h3 class="card-title">Emails list</h3>
    </div>
    <div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<col class="col1-1" /><col class="col2-2" />
<thead>
<tr>
    <th>{'Email'|lang}</th>
    <th>Action</th>
</tr>
</thead>
<tbody>
{foreach from=$emails value=email}
<tr class="{cycle values='bg-grey-kin,'}">
    <td>{$email.userText}</td>
    <td><a href="{"/admin/setting/editEmail/$email.messageId"|url}" title="Edit email" class="link_green">{'Edit'|lang}</a> 
        | <a onclick="return confirm('{'Do you really want send test email?'|lang}')" href="{"/admin/setting/sendTestEmail/$email.messageId"|url}" class="link_green">Test</a>     
    {if $email.userDefined} | 
        <a onclick="return confirm('{'Do you really want to delete it?'|lang}')" href="{"/admin/setting/deleteEmail/$email.messageId"|url}" title="{'Delete email'|lang}" class="link_red">{'Delete'|lang}</a>
    {/if}

    </td>
</tr>
{/foreach}
</tbody>
</table>
</div>
</div>

<div class="card">
    <div class="card-header">
        <h3 class="card-title">Add email</h3>
    </div>
    <div class="card-body table-responsive p-0">
<form action="{'/admin/setting/saveNewEmail'|url}" method="post" id="newEmailForm">
<table class="table text-nowrap">
<tbody>
<tr>
    <td>{'Description'|lang}: </td>
    <td><input type="text" class="input_text_medium" name="userText" value="" /></td>
</tr>
<tr>
    <td>{'Subject'|lang}: </td>
    <td><input type="text" class="input_text_medium" name="title" value="" /></td>
</tr>
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
    <textarea class="textarea_extra_large" name="description" cols="50" rows="5"></textarea></td>
</tr>
<tr>
    <td></td>
    <td><input type="submit" class="button" value="{'Add email'|lang}" /></td>
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