{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/voyantPanel/templates/kinthia/plugins/bootstrap-switch/js/bootstrap-switch.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tinymce.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/InitTinyMCE.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/package/indexOnLoad.js'|resurl}"></script>
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

<div id="message" {if $message} style="background: green; color:#fff; text-align: center; padding: 5px 5px 5px 5px" {/if}>
  {$message}
 </div>
 
<div class="card">
    <div class="card-header">
        <h3 class="card-title">{'Create Package'|lang}</h3>
  </div>
   <form action="{"/admin/Package/save"|url}" method="post" enctype="multipart/form-data">
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
            {* <input type="checkbox" name="packagePromo" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

            <input type="checkbox" id="packagePromo" name="packagePromo" />
        </td>
    </tr>
    <tr>
        <td>Promo message :<br>
        (Display all pages) </td>
        <td><textarea class="textarea_large tinyMce" name="packagePromoMsg" cols="50" rows="5" id="packagePromoMsg"></textarea></td>
    </tr>
    <tr>
        <td>Display</td>
        <td>
            {* <input type="checkbox" name="packageDisplay" checked data-bootstrap-switch data-off-color="danger" data-on-color="success"> *}

            <input type="checkbox" id="packageDisplay" name="packageDisplay" />
        </td>
    </tr>
    <tr>
      <td>
        <input type="submit" class="button" value="Create" />
      </td>
      <td>
      </td>
    </tr>
    </tbody>
    </table>
    </div>
  </form>
</div>


<div class="card">
    <div class="card-header">
        <h3 class="card-title">{'Package management'|lang}</h3>
	</div>
<div class="card-body table-responsive p-0">
<table class="table text-nowrap">
<thead>
<tr>
	<th>{'Package Title'|lang}</th>
	<th>{'Display'|lang}</th>
  <th>{'Promo'|lang}</th>
	<th>{'Management'|lang}</th>
</tr>
</thead>
<tbody>

 {foreach from=$packages item=package}
<tr class="{cycle values='bg-grey-kin,'}">
	<td>{$package.packageName}</td>
    <td>
       {if $package.packageDisplay==1}
          <span class="color-28a745">Yes</span>
         {else}
          <span class="color-dc3545">No</span>                    
      {/if}
    </td>
  	<td>
       {if $package.packagePromo==1}
          <span class="color-28a745">Yes</span>
         {else}
          <span class="color-dc3545">No</span>                    
      {/if}
    </td>
    
  	 <td>
        <ul class="list-inline m-0">
          <li class="list-inline-item">
          <a  href="{"/admin/Package/edit/$package.packageId"|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
          </li>
          <li class="list-inline-item">
          <a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/Package/delete/$package.packageId"|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Supprimer"><i class="fa fa-trash"></i></a>
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
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->

{include file='includes/footer.tpl'} 