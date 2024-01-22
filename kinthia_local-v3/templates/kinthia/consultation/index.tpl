{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/voyant/detailsOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/alert/alertOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.fileUploader.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.photoEditor.js'|resurl}"></script>
<script type="text/javascript" src="{'/voyantPanel/javascript/consultation/endedOnLoad.js'|resurl}"></script>
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
<script type="text/javascript" src="{'/node_modules/socket.io-stream/socket.io-stream.js'|resurl}"></script>
{*<script src='https://meet.jit.si/external_api.js'></script>*}
<script src='https://alpha.jitsi.net/external_api.js'></script>
<script type="text/javascript" src="{'/javascript/chat/chat.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/chat/chat_user_jitsi.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/main/indexOnLoad.js'|resurl}"></script>
{/capture}
{include file="includes/header.tpl" title="{'Vous consultez un expert'|lang}" metaDescription="{'Vous consultez un expert'|lang}"}

<section id="index-consultation" class="mb-3">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="expert-details-container">
					<div class="expert-details-header">
						<h1 class="experth1">{$voyant.headerDescription}</h1>
						<div class="voyantimagedetails">
							{if isset($voyant.imageSrc)}
							    <img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.title}" class="expert-details-img" />
							{else}
							    <img src="{$firstGalleryImageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.title}" class="expert-details-img" />
							{/if}
						</div>
					</div>
					<div class="expert-details-languages">
						{if $voyantlanguages && $languageIds}
							{foreach from=$voyantlanguages item=lang key=mkey}
								{if in_array($lang.languageId, $languageIds)}
			                  		<img src="{$lang.languageFlag|realImgSrc:'language'}" data-toggle="tooltip"
				                  		data-html="true" title="<span class='kin-color-1'>{$voyant.name}</span> talk {$lang.language}" style="width: 28px" />
								{/if}
							{/foreach}
						{/if}
					</div>
					<div class="expert-details-skills">
						<h2 class="experth1">Vous consultez l'expert «{$voyant.headerDescription}»</h2>

						{* -- START - CONSULTATION PROCESS -- *}
						<div class="details-expert-status">
							<input type="hidden" id="userdata" value='{$userdata}'>
					        <input type="hidden" id="userimage" value="">
					        <input type="hidden" name="endedCall" value="{'/consultation/ended'|url}">
					        <input type="hidden" name="requestUrl" value="{'/consultation/incomingCall'|url}" />
					        <audio id="myAudio">
							 	<source src="{'/'|url}/uploads/audio/The-Inspiration-mp3.mp3" type="audio/mpeg">
							</audio>
							<div class="card-body">
								<p class="mb-4" id="request_accept"></p>
								<h5> <p>In consultation since - TO Display only when consultation is already started</p></h5>
								<input type="hidden" id="talkTime">
								<div class="row">
									<div class="col-md-5">
										 <div class="webcam-container" id="webcam-container">
						            	 </div>
										{* <div class="text-center mt-4">
											<a id="ended" href="{'/consultation/ended'|url}" class="stop-consultation">Stop consultation</a>
										</div> *}
										<div class="text-center mt-4" id="startConsult" style="display:none;">
										</div>
										<div class="text-center mt-4" id="stopConsult" style="display:none;">
										 	<a id="dispose" class="stop-consultation btn btn-danger" href="javascript:void(0);">Stop consultation</a>
										</div>
										<div class="text-center mt-2" id="refreshConsult" style="display:none;">
										 	<a class="refresh-consultation btn btn-kin1 text-white" onclick="refreshConsult();" href="javascript:void(0);">refresh</a>
										</div>
										<h3><strong id="online-status" class="online"></strong></h3>
									</div>
									<div class="col-md-7">
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
												<textarea  id="msg" class="form-control form-control mt-0" placeholder="Taper un message" autocomplete="off"></textarea>
												<div id="show_preview" class="show_preview"></div>
											</div>
											<button type="submit" id="send_button" class="btn btn-primary btn-kin">Envoyer</button>
										</div>
										</form>
										{* <button id="sendrequestid" style="display:none;" type="button" onclick="sendRequest('{$voyantId}','{$session.userId}','{$type}');">Send Expert Request</button> *}
									</div>
								</div>
							</div>
						</div>
						{* -- END - CONSULTATION PROCESS -- *}


					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="overlay">
		<div class="cv-spinner">
			<span class="spinner"></span>
		</div>
    </div>
</section>


<input type="hidden" id="userNm" value="{$session.user.name}">
<input type="hidden" id="cartUrl" value="{'/cart/pack/'|url}">
<input type="hidden" id="consultationUrl" value="{"/consultation/index/"|url}">
<input type="hidden" id="consultationStatus" value="{$voyant.consultationStatus}">

<form action="{'/consultation/saveUserConsultaionRequest'|url}" method="post" id="saveUserConsultaionRequest">
    <input type="hidden" id="username" name="username" value="{$session.user.name}">
    <input type="hidden" id="userId" name="userId" value="{$session.userId}">
    <input type="hidden" id="voyantId" name="voyantId" value="{$voyant.voyantId}">
    <input type="hidden" id="usertype" name="usertype" value="U">
    <input type="hidden" id="room" name="room" value="chat-{$voyant.voyantId}-{$session.userId}">
    <input type="hidden" id="consultationType" name="consultationType" value="webcam">
</form>

{* -- START - DO NOT DISPLAY --
<div id="breadcrumb">
	<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
	<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
</div>
-- START - DO NOT DISPLAY -- *}

{include file="includes/footer.tpl"}

{literal}
<script type="text/javascript">
	function consultationReq(){
		var form2 = document.getElementById('saveUserConsultaionRequest');
       	$.ajax({
            url: form2.action,
            type: form2.method,
            data: $(form2).serialize(),
            dataType: 'json',
            success: function(response) {
            	if(response.status=='success') {
            	    var consultationUrl = $("#consultationUrl").val();
            	    window.location.href = consultationUrl+response.id;
            	} else {
            	    alert(response.message);
            	}
            }
        });
	}
</script>
{/literal}
