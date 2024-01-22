{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.tablednd.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/json.js'|resurl}"></script>

{/capture}
{include file='includes/header.tpl' page="index" title="{'Liste des questions / services - Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">List Of Skills</h1>
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
     <div id="message" {if $message} style="background: green; color:#fff; text-align: center; padding: 5px 5px 5px 5px" {/if}>
      {$message}
     </div>
    <div class="card">

      <div class="card-header">
 <a href="{"/admin/skill/create"|url}"  class="btn btn-success float-right">Create</a>
        <h3 class="card-title">Skills List</h3>

        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table text-nowrap" id="voyantQuestionsTable">
          <thead>
            <tr>
              <th>Name</th>
              <th>Page</th>
              <th>Slug</th>
              <th>title</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$skills item=skill}
            <tr class="{cycle values='bg-grey-kin, '}" id="voyantQuestionsTable-row-{$skill.skillId}">
              <td>{$skill.name}</td>
              <td>
                 {if $skill.createPage==1}
                    <span class="color-28a745">Yes</span>
                   {else}
                    <span class="color-dc3545">No</span>                    
                {/if}
              </td>
              <td>{$skill.slug}</td>
              <td>{$skill.title}</td>
              <td>
                <ul class="list-inline m-0">
                  <li class="list-inline-item">
                      <a href="{"/admin/skill/edit/$skill.skillId"|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
                  </li>
                   <li class="list-inline-item">
                      <a onclick="return confirm('Do you really want to delete it?')" href="{"/admin/skill/delete/$skill.skillId"|url}" class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-trash"></i></a>
                  </li>
              </ul>
            </td>
            </tr>
            {/foreach}
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