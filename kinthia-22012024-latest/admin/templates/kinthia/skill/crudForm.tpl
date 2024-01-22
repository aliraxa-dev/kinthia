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
<form action="{"/admin/Skill/save"|url}" method="post" enctype="multipart/form-data" id="editSkillForm">
  <input type="hidden" class="" name="skillId" value="">
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <tbody>
            <tr>
              <td>Name</td>
              <td><input type="text" class="" name="name" required=""></td>
            </tr>
            <tr>
              <td>Create page</td>
              <td>
              {*   <input type="checkbox" value="1" name="createPage" checked data-bootstrap-switch data-off-color="danger" data-on-color="success" > *}

               <input type="checkbox" id="createPage" name="createPage" {if $edit && $skill.createPage==1} checked value="{$skill.createPage}" {/if}/>
              </td>
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
            <tr>
              <td>Meta robots</td>
              <td><input type="text" class="" name="metaRobots"></td>
            </tr>
            <tr>
              <td>H1</td>
              <td><input type="text" class="" name="h1_tag"></td>
            </tr>
            <tr>
              <td>Breadcrumb</td>
              <td><input type="text" class="" name="breadcrumb"></td>
            </tr>
            <tr>
              <td>Long description: </td>
              <td><textarea class="textarea_large tinyMce" name="longDescription" cols="50" rows="5" id="longDescription"></textarea></td>
            </tr>
            <tr>
              <td>Long description 2: </td>
              <td><textarea class="textarea_large tinyMce" name="longDescription2" cols="50" rows="5" id="longDescription2"></textarea></td>
            </tr>
            <tr>
              {if $edit}
              <td></td><td><input type="submit" class="btn btn-primary" value="Update Skill" ></td>
              {else}
              <td></td><td><input type="submit" class="btn btn-primary" value="Create Skill" ></td>
              {/if}
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
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>