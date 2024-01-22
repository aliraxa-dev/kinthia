{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="user" title="{'Report Expert'|lang}"}  
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Report Expert</h1>
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
	<h3 class="card-title">Report Expert</h3>
	</div>
	<div class="card-body table-responsive p-0">
	<table class="table text-nowrap">
	<thead>
	<tr>
	<th>User</th>
	<th>Voyant</th>
	<th>Consultation</th>
	<th>Message</th>
	<th>Management</th>
	</tr>
	</thead>
	<tbody>
 
			{foreach from=$allVoyantReports  item=voyantReport}
	
	<tr class="bg-grey-kin">
	<td><a href="">{$voyantReport.user.name}</a></td>
	<td><a href="">{$voyantReport.voyant.name}</a></td>
	<td><a href="">{$voyantReport.consultantName}</a></td>
	<td><textarea readonly class="form-control" name="text" cols="50" rows="5" >{$voyantReport.explainProblem}</textarea></td>

	<td>
	<ul class="list-inline m-0">
	<li class="list-inline-item">
	<a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/user/deleteReport/$voyantReport.id"|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Supprimer"><i class="fa fa-trash"></i></a>
	</li>
	</ul>
	</td> 

	</tr>

	{/foreach}

	

	</tbody>
	</table>
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