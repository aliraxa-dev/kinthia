{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="index" title="Invoices list - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Invoices list</h1>
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
        <h3 class="card-title">Invoices list {$voyant.name}</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form>
      <div id="orderList" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Date</th>
              <th>Details</th>
              <th>Upload</th>
              <th>Uploaded Invoice</th>
            </tr>
          </thead>
          <tbody>
              <tr class="{cycle values='bg-grey-kin, '}">
                <td>$date</td>
                <td><a href="{'/voyantPanel/voyantInvoice/list'|url}">See</a></td>
                <td>
                  <div class="input-group mr-3" style="width: 300px; display: inline-flex;">
                    <div class="input-group-prepend">
                      <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
                    </div>
                    <div class="custom-file">
                      <input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                      <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                    </div>
                  </div>
                </td>
                <td>
                  <ul class="list-inline m-0">
                    <li class="list-inline-item">
                      <a href="{'/voyantPanel/voyantInvoice/list'|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="See"><i class="fa fa-search"></i></a>
                    </li>
                    <li class="list-inline-item">
                      <a onclick="return confirm('Do you really want to delete it?')" href="{'/voyantPanel/voyantInvoice/list'|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></a>
                    </li>
                  </ul>
                </td>
              </tr>
              <tr class="{cycle values='bg-grey-kin, '}">
                <td>January 2023</td>
                <td><a href="{'/voyantPanel/voyantInvoice/list'|url}">See</a></td>
                <td>
                  <div class="input-group mr-3" style="width: 300px; display: inline-flex;">
                    <div class="input-group-prepend">
                      <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
                    </div>
                    <div class="custom-file">
                      <input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                      <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                    </div>
                  </div>
                </td>
                <td>
                  <ul class="list-inline m-0">
                    <li class="list-inline-item">
                      <a href="{'/voyantPanel/voyantInvoice/list'|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="See"><i class="fa fa-search"></i></a>
                    </li>
                    <li class="list-inline-item">
                      <a onclick="return confirm('Do you really want to delete it?')" href="{'/voyantPanel/voyantInvoice/list'|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></a>
                    </li>
                  </ul>
                </td>
              </tr>
              <tr class="{cycle values='bg-grey-kin, '}">
                <td>December 2022</td>
                <td><a href="{'/voyantPanel/voyantInvoice/list'|url}">See</a></td>
                <td>
                  <div class="input-group mr-3" style="width: 300px; display: inline-flex;">
                    <div class="input-group-prepend">
                      <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
                    </div>
                    <div class="custom-file">
                      <input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                      <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                    </div>
                  </div>
                </td>
                <td>
                --
                </td>
              </tr>
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
