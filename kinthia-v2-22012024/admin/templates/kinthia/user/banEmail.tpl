{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="user" title="Ban Email - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Ban Email</h1>
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
		{'To specify multiple addresses E-mails, enter each on a new line'|lang}.<br />
		{'To specify a level of E-mails addresses, use * as a wildcard'|lang}.
		</div>
	</div>


<div class="card">
		<div class="card-header">
		<h3 class="card-title">Ban Email</h3>
		</div>
		<div class="card-body table-responsive">
		<form action="{'/admin/user/saveNewEmailBan'|url}" method="post">
		<table class="table text-nowrap">
		<tbody>
		<tr>
			<td>{'E-mails Addresses'|lang}: </td>
			<td><textarea class="textarea_large" name="bannedEmails" cols="50" rows="5"></textarea></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" class="button" value="{'Ban'|lang}"  /></td>
		</tr>
		</tbody>
		</table>
		</form>
		</div>
	</div>

<div class="card">
		<div class="card-header">
		<h3 class="card-title">{'Remove addresses E-mails banned'|lang}</h3>
		</div>
<div class="card-body table-responsive">
<form action="{'/admin/user/deleteEmailBan'|url}" method="post">  
<table class="table text-nowrap">
<tbody>
<tr>
	<td>{'E-mails Addresses'|lang}: </td>
	<td><select id="unban" name="unbanEmails[]" multiple="multiple" size="5" style="width: 250px" >
    {html_options options=$bannedEmails} 
    </select></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" class="button" value="{'Remove'|lang}" /></td>
</tr>
</tbody>
</table>
</form>
</div>
	</div>

	</div>
</div>

  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->

{include file='includes/footer.tpl'}    