{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/bootstrap-switch/js/bootstrap-switch.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tinymce.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/InitTinyMCE.js'|resurl}"></script>

<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/package/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/package/editOnLoad.js'|resurl}"></script>
<script type="text/javascript">
  var setting = new Array();
setting.package = {$packageJson|htmlspecialchars_decode};
</script>
{/capture}
{include file='includes/header.tpl' page="setting" title="{'Package management'|lang}"} 
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{'Package management'|lang}</h1>
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
        <h3 class="card-title">{'Edit Package'|lang}</h3>
  </div>
<form action="{"/admin/package/save"|url}" method="post" enctype="multipart/form-data" id="editPackageForm">
<input type="hidden" name="packageId" value="" />   
<div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<tbody>
<tr>
    <td>Title: </td>
    <td><input type="text" class="input_text_large" name="packageName" value="" /></td>
</tr>
<tr>
    <td>Description: </td>
    <td><textarea class="textarea_large tinyMce" name="packageDescription" cols="50" rows="5" id="description"></textarea></td>
</tr>
<tr>
    <td>Time (min): </td>
    <td><input type="text" class="input_text_large" name="packageTime" value="" /></td>
</tr>
<tr>
    <td>Price: </td>
    <td><input type="text" class="input_text_large" name="packagePrice" value="" /></td>
</tr>
 <tr>
    <td>Barred price: </td>
    <td><input type="text" class="input_text_large" name="packageBarredPrice" value="" /></td>
</tr>
<tr>
    <td>Promo</td>
    <td>
       {*  <input type="checkbox" name="packagePromo" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

       <input type="checkbox" id="packagePromo" name="packagePromo" {if $package.packagePromo==1} checked="" value="{$package.packagePromo}" {/if} />
    </td>
</tr>
<tr>
    <td>Promo message: </td>
    <td><textarea class="textarea_large tinyMce" name="packagePromoMsg" cols="50" rows="5" id="packagePromoMsg"></textarea></td>
</tr>
<tr>
    <td>Display</td> 
    <td>
       {*  <input type="checkbox" name="packageDisplay" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

        <input type="checkbox" id="packageDisplay" name="packageDisplay" {if $package.packageDisplay==1} checked="" value="{$package.packageDisplay}" {/if} />
    </td>
</tr>
<tr>
  <td>
    <input type="submit" class="button" value="Edit" />
   {*  <input type="submit" class="button" value="Delete" onclick="return confirm('Do you really want to delete it?')" />
 *}  </td>
  <td>
  </td>
</tr>
</tbody>
</table>
</div>
</form>
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