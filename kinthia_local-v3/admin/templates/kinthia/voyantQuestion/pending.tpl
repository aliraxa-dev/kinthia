{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/voyantPanel/javascript/userQuestions/pendingOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="Questions en attente de validation - {'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Questions en attente de validation</h1>
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
        <h3 class="card-title">{$countQuestionPending} Questions en attente de validation</h3>
        {include file="includes/tableNavigation.tpl"}
      </div>
      <!-- /.card-header -->
      <form action="{'/admin/voyantQuestion/'|url}" method="post" id="">
      <div id="holderOfWaitingSites" class="card-body table-responsive p-0">
        <table class="table text-nowrap">
          <thead>
            <tr>
              <th><input type="checkbox" id="checkAll"/></th>
              <th>Date</th>
              <th>Intitulé de la question</th>
              <th>Voyant</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$voyantquestions item=voyantquestion}
            <tr class="{cycle values='bg-grey-kin, '}">
              <td><input type="checkbox" class="checkbox" name="" value="" /></td>
              <td>{$voyantquestion.updated_at|date_format:"%Y-%m-%d"}</td>
              <td>{$voyantquestion.title}</td>
              <td>{$voyantquestion[voyant].name}</td>
              <td>
                <ul class="list-inline m-0">
                  <li class="list-inline-item">
                  <a href="{"/admin/voyantQuestion/edit/$voyantquestion.questionId"|url}" class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top" title="Modifier"><i class="fa fa-edit"></i></a>
                  </li>
                </ul>
              </td>
            </tr>
            {/foreach}
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