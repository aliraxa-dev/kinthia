{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/voyantPanel/javascript/userQuestions/pendingOnLoad.js'|resurl}"></script>
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="{'Panel expert - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Messages avec {$userdata.name}</h1>
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
          <h3 class="card-title">Communication avec {$userdata.name}</h3>
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
                  {$userdata.name}<br>
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
                        <div class="chat-box mt-3 w-auto d-flex flex-column">
                          {$voyantmessage.text}
                          <hr class="my-1">
                          <small> {$voyant.name} | <span class="opacity-6"><i class="fa fa-calendar-alt mr-1"></i> {$voyantmessage.date|date_format:"%I:%M %p"} | {$voyantmessage.date|date_format:"%d-%m-%Y"}</span> </small>
                        </div>
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

        <form action="{"/voyantPanel/userMessage/sendmessage/$userdata.userId"|url}" method="post" id="sendMessageToUser">
        <div class="card-footer clearfix">
          <div class="form-group">
            {* <input type="text" name="send_message" id="send_message" class="form-control" placeholder="Taper un message" required="required"> *}

            <textarea name="send_message" id="send_message" class="form-control" placeholder="Taper un message" required="required"></textarea>
          </div>
          <button type="submit" class="btn btn-primary btn-kin">Envoyer</button>
        </div>
      </form>

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
