{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup1.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/consultation/incomingCallOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/consultation/endedOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io-stream/socket.io-stream.js'|resurl}"></script>
<script src='https://meet.jit.si/external_api.js'></script>
<script type="text/javascript" src="{'/javascript/chat/chat.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/chat/chat_jitsi.js'|resurl}"></script>  
{/capture}
{include file='includes/header.tpl' page="index" title="{'Consultation - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Consultation</h1>
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
        <h3 class="card-title">{$userRequests.type} {* (<a id="incomingCall" href="{'/voyantPanel/consultation/incomingCall'|url}">incoming call popup)</a> *}</h3>
        <input type="hidden" id="userdata" value='{$userdata}'>
        <input type="hidden" id="userimage" value="{$voyant.imageSrc|realImgSrc:'voyant':'small'}">
        <input type="hidden" name="endedCall" value="{'/voyantPanel/consultation/ended'|url}">

        <input type="hidden" id="ajxUrl" value="{'/voyantPanel/consultation/userConsultationRequest'|url}" />
        <input type="hidden" id="incomCall" value="{'/voyantPanel/consultation/incomingCall'|url}" />
        {* <input type="hidden" name="requestUrl" value="{'/voyantPanel/consultation/getrequestData'|url}" /> *}
      </div>
      <!-- /.card-header -->
      <div class="card-body">
        <p class="mb-4" id="request_accept"></p>
        <h5><p> In consultation since </p></h5>
        <input type="hidden" id="talkTime" value="00:00"> 
        <div class="row">
          <div class="col-md-4" style="width:30%!important;flex:0 0 29.56%;">
            <div class="webcam-container" id="webcam-container" style="display:none">
            </div>
           {*  <div class="text-center mt-4">
              <a id="ended" href="{'/voyantPanel/consultation/ended'|url}" class="stop-consultation">Stop consultation</a>
            </div> *}
              <div class="text-center mt-4" id="startConsult"><a id="start_consult" onclick="startconsult();" class="start-consultation" href="javascript:void(0);">Start consultation</a> </div>

            <div class="text-center mt-4" id="stopConsult" style="display:none;"><a id="dispose" class="stop-consultation" href="{'/voyantPanel/main'|url}">Stop consultation</a> </div>
          <div class="text-center mt-2 btn btn-dark mx-auto w-50" id="refreshConsult" style="display:none;">
          <a class="refresh-consultation" onclick="refreshConsult();" href="javascript:void(0);">
          refresh</a>
        </div>
          </div>
          <div class="col-md-8">
            <div class="card-body p-0">
              <div class="chat-wrapper">

              </div>
            </div>
           <form id="chat-form" enctype="multiple" style="display:none;" enctype="multipart/form-data"> 
            <div class="card-footer clearfix">
                <div class="input-group mb-3">
                  <div class="upload-btn-wrapper">
                  <button class="btn btn-upload"><i class="fas fa-file-upload text-white"></i></button>
                  <input type="file" id="file" name="file" accept="image/*">
                </div>
                  <!-- /btn-group -->
                  {* <input type="text" id="msg" class="form-control" placeholder="Taper un message" autocomplete="off"> *}
                  <textarea  id="msg" class="form-control" placeholder="Taper un message" autocomplete="off"></textarea>
                  <div id="show_preview" class="show_preview"></div>
              </div>
            <button type="submit" class="btn btn-primary btn-kin">Envoyer</button>
            </div>
          </form>
          </div>
          </div>

        <div id="overlay">
          <div class="cv-spinner">
            <span class="spinner"></span>
          </div>
        </div>  
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
