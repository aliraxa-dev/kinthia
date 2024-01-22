{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="user" title="{'Email export'|lang}"}  
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{'Number of subscribers to the newsletter'|lang}: {$newsletterEmailsCount}</h1>
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
        <h3 class="card-title">Export</h3>
    </div>
	<div class="card-body table-responsive">
	<form action="{'/admin/user/exportNewsletterEmail'|url}" method="post"> 
		<input class="button" type="submit" name="Start" value="{'Download CSV'|lang}" />
	</form>
	</div>
	</div>

	<div class="card">
        <div class="card-header">
        <h3 class="card-title">Import</h3>
    </div>
	<div class="card-body table-responsive">
		<form action="{'/admin/user/importNewsletterEmail'|url}" method="post" enctype="multipart/form-data">
		<table class="table text-nowrap">
		<tbody>
		<tr>
		    <td>{'CSV file'|lang}: </td>
		    <td><input type="file" class="input_text_medium" style="width:247px;" name="csvFile" /></td>
		</tr>
		<tr>
		    <td></td>
		    <td><input type="submit" class="button" value="{'Import file'|lang}" /></td>
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