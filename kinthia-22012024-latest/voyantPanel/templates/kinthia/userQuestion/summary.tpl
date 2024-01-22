{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/tinymce.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/tiny_mce/InitTinyMCE.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/magnific-popup/jquery.magnific-popup.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.adminFormTool.js'|resurl}"></script>

<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>

{/capture}
{include file='includes/header.tpl' page="nomDeLaPage" title="{'Questions & messages - Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Service demandé : {$userQuestion.voyantQuestion.title} - 
              {switch from=$userQuestion.status}
              {case value="pending"}
              <span class="color-dc3545">En attente</span>
              {case value="answered"}
              <span class="color-28a745">Traitée</span>
              {/switch}
            </h1>
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
  <div class="col-md-3">

            <!-- Profile Image -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Informations sur le consultant</h3>
              </div>
              <div class="card-body box-profile">
                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                    <b>Pseudo</b> <a class="float-right">{$userQuestion.user.name}</a>
                  </li>
                  <li class="list-group-item">
                    <b>Prénom</b> <a class="float-right">{$userQuestion.user.firstName}</a>
                  </li>
                  {* comment
                  <li class="list-group-item">
                    <b>Nom</b> <a class="float-right">{$userQuestion.user.lastName}</a>
                  </li>
                  *}
                  <li class="list-group-item">
                    <b>Date de naissance</b> <a class="float-right">{$userQuestion.user.birthdayDate|date_format:"%d"}-{$userQuestion.user.birthdayDate|date_format:"%m"}-{$userQuestion.user.birthdayDate|date_format:"%Y"}{* {$userQuestion.user.birthdayDate} *}</a>
                  </li>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- About Me Box -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Photos</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body popup-gallery">
                <div class="row">
                {foreach from=$userQuestion.photos item=photo}
                  <div class="col-md-6 mb-1">
              <a href="{$photo.src}" title="$photo.title"><img src="{$photo.thumbSrc}" class="w-100" /></a>
              </div>
            {/foreach}
            </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
  <div class="col-md-9">
      <form action="{'/voyantPanel/userQuestion/saveSummary'|url}" method="post">
        <input type="hidden" name="questionId" value="{$questionId}">
        <div class="card card-primary">
        <div class="card-header">
          <h3 class="card-title">Réponse au service</h3>
        </div>
        <!-- /.card-header -->
        <div class="card-body p-0">
          <textarea name="summary" class="tinyMce">{$userQuestion.summary}</textarea>
        </div>
        <div class="card-footer clearfix">
          <button type="submit" class="btn btn-primary btn-kin">Réponse au service</button>
      </form>
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

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
  <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
{include file="includes/footer.tpl"}
