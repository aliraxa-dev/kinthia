{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/language/editOnLoad.js'|resurl}"></script>
<script type="text/javascript">
  var setting = new Array();
  setting.language = {$languageJson|htmlspecialchars_decode};
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="Language - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Edit Language</h1>
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
        <h3 class="card-title">Edit Language</h3>
        {* <a href="{"/admin/language"|url}" class="btn btn-primary" style="float: right;" >Back</a> *}
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form action="{"/admin/language/save"|url}" method="post" enctype="multipart/form-data" id="editLanguageForm">
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <tbody>
            <tr>
              <input type="hidden" name="languageId" value="" />               
              <td>Name</td><td><input type="text" class="" name="language" value=""></td>
            </tr>
            <tr>
              <td>Code</td><td><input type="text" class="" name="languageCode" value=""></td>
            </tr>

            <tr>            
              
              <td>Flag</td>
              <td>
                {if $edit && $language.languageFlag}          
                  <img src="{$language.languageFlag|realImgSrc:'language'}" style="width: 70px" />   
                  <br/>
                  <input type="hidden" name="old_languageFlag" value="{$language.languageFlag}">
                {/if}
                <br/><input type="file" class="" name="languageFlag">
              </td>
            </tr>
           
            <tr>
              <td></td><td><input type="submit" class="btn btn-primary" value="Edit"></td>
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