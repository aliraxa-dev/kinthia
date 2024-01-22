{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/tiny_mce/tinymce.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/InitTinyMCE.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/bootstrap-switch/js/bootstrap-switch.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/setting/skillOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="Skill list - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Skill list</h1>
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
        <h3 class="card-title">Create Skill</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->

      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <tbody>
            <tr>
              <td>Name</td>
              <td><input type="text" class="" name="name"></td>
            </tr>
            <tr>
              <td>Create page</td>
              <td><input type="checkbox" name="my-checkbox" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"></td>
            </tr>
            <tr>
              <td>Slug</td>
              <td><input type="text" class="" name="slug"></td>
            </tr>
            <tr>
              <td>Title</td>
              <td><input type="text" class="" name="title"></td>
            </tr>
            <tr>
              <td>Meta description</td>
              <td><input type="text" class="" name="metaDescription"></td>
            </tr>
           {*  <tr>
              <td>Meta robots</td>
              <td><input type="text" class="" name=""></td>
            </tr>
            <tr>
              <td>H1</td>
              <td><input type="text" class="" name=""></td>
            </tr>
            <tr>
              <td>Breadcrumb</td>
              <td><input type="text" class="" name=""></td>
            </tr>
            <tr> *}
              <td>Long description: </td>
              <td><textarea class="textarea_large tinyMce" name="longDescription" cols="50" rows="5" id="longDescription"></textarea></td>
            </tr>
         {*    <tr>
              <td>Long description 2: </td>
              <td><textarea class="textarea_large tinyMce" name="longDescription2" cols="50" rows="5" id="longDescription2"></textarea></td>
            </tr> *}
            <tr>
              <td></td><td><input type="submit" class="btn btn-primary" value="Create language"></td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
</div>
    <!-- /.row -->

<div class="row">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Skill list</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->

      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th>Name</th>
              <th>Page</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            
            <tr class="{cycle values='bg-grey-kin, '}">
              <td>$name</td>
              <td>yes/no</td>
              <td>
                <ul class="list-inline m-0">
                  <li class="list-inline-item">
                  <a href="{'/admin/setting/editSkill'|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
                  </li>
                  <li class="list-inline-item">
                  <a onclick="return confirm('Do you really want to delete it?')" href="" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Supprimer"><i class="fa fa-trash"></i></a>
                  </li>
                </ul>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

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