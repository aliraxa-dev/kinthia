{capture assign="headData"}
{/capture}
{capture assign="footerData"}
{/capture}
{include file='includes/header.tpl' page="index" title="Message en attente - {'Admin - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Message entre {$user.name} et {$voyant.name}</h1>
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
        <div class="card-header bg-kinthia">
          <h3 class="card-title">Communication {$user.name} et {$voyant.name}</h3>
        </div>
        <!-- /.card-header -->
        <div class="card-body p-0">
          <div class="chat-wrapper">
            <!-- empty message -->
            <!-- <div class="chat-box-wrapper">
              no message
            </div> -->

            {foreach from=$voyantmessages item=voyantmessage}
            <!-- left user -->
            {if $voyantmessage.sendby=='U'}
            <div class="chat-box-wrapper">
              <div>
                <small>
                  {$user.name}<br>
                  <span class="opacity-6"><i class="fa fa-calendar-alt mr-1"></i>
                  {$voyantmessage.date|date_format:"%I:%M %p"} | {$voyantmessage.date|date_format:"%d-%m-%Y"}</span>
                </small>
                  <div class="chat-box bg-chat-left">{$voyantmessage.text}
                  </div>
              </div>
            </div>
            {else}
            <!-- right voyant -->
                <div class="float-right chat-box-wrapper chat-box-wrapper-right">
                    <div>
                        <div class="chat-box">{$voyantmessage.text}
                        </div>
                        <small>
                          {$voyant.name}<br>
                          <span class="opacity-6"><i class="fa fa-calendar-alt mr-1"></i>
                          {$voyantmessage.date|date_format:"%I:%M %p"} | {$voyantmessage.date|date_format:"%d-%m-%Y"}</span>
                        </small>
                    </div>
                    <div>
                        <div class="avatar-icon-wrapper ml-1">
                            <div class="badge badge-bottom btn-shine badge-success badge-dot badge-dot-lg"></div>
                            <div class="avatar-icon avatar-icon-lg rounded"><img src="assets/images/avatars/2.jpg" alt=""></div>
                        </div>
                    </div>
                </div>
                {/if}
                {/foreach}
          </div>
        </div>
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