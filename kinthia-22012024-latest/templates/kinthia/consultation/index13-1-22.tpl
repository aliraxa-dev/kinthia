{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/bootstrap/bootstrap.bundle.min.js'|resurl}"></script>
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
<script src='https://meet.jit.si/external_api.js'></script>
<script type="text/javascript" src="{'/javascript/chat/chat.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/chat/chat_user_jitsi.js'|resurl}"></script>
{/capture}
{include file="includes/header.tpl" title="{'voyantComment_html_title'|lang}" metaDescription="{'voyantComment_meta_description'|lang}  {'voyantComment_meta_description1'|lang}"}

<div class="padding-wrapper aftermenutop">
	<div id="breadcrumb">
	<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
	<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
	</div>
<!--
	{include file="includes/profileBox.tpl"}
-->
	<div class="voyantcommentcontainer pas">
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>

		<div class="grid-3-small-2 man pan">
			<div class="voyantimagedetails">
			<img src="" alt="" class="imagevoyant" />
			<i class="fas fa-heart infav" data-toggle="tooltip" data-html="true" title="Expert dans mes favoris"></i>

		<div class="experts-tools">
			<a id="alert" href="{'/popup/alert'|url}">
				<i class="fas fa-bell" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'> </span> is available."></i>
			</a>
			<i class="fas fa-play-circle" data-toggle="tooltip" data-html="true" title="Lessen <span class='kin-color-1'> </span> presentation"></i>
			<i class="fas fa-heart" data-toggle="tooltip" data-html="true" title="Add <span class='kin-color-1'></span> to your fav list"></i>
		</div>
		<div class="experts-tools">
			<i class="fas fa-bell" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'> </span> is available."></i>
			<i class="fas fa-pause-circle" data-toggle="tooltip" data-html="true" title="Stop <span class='kin-color-1'> </span> presentation"></i>
			<i class="fas fa-heart infav-remove" data-toggle="tooltip" data-html="true" title="Remove <span class='kin-color-1'> </span> to your fav list"></i>
		</div>
		<div class="experts-flags">
			<img src="{'/uploads/images-flags/fr.png'|resurl}" data-toggle="tooltip" data-html="true" title="<span class='kin-color-1'>$voyant.name</span> talk french" />
			<img src="{'/uploads/images-flags/us.png'|resurl}" data-toggle="tooltip" data-html="true" title="<span class='kin-color-1'>$voyant.name</span> talk english" />
		</div>
		</div>

	<div class="voyantcontainermiddledetails">
	<div class="grid-3-small-1 man pan">
	<div class="man pbs txtratinglineheight">
	<span class="txtrating">Nombre de consultations</span><br />
	<span class="txtrating2">0</span>
	</div>
	<div class="man pbs txtratinglineheight">
	<span class="txtrating">Note des consultants</span><br />
	<span class="txtrating2"> 0 / 5 sur 0 avis</span>
	</div>
	<div class="man pbs txtratinglineheight">
	<span class="txtrating">Avis & commentaires</span><br />
	<span class="txtrating2"><a href="" class="linkcheckavis">Consulter les avis</a></span>
	</div>
	</div>
	<div class="details-skills-list">
		Skill list : médium, voyant, cartomancien
	</div>
	<div class="details-expert-status">
		<input type="hidden" id="userdata" value='{$userdata}'>
        <input type="hidden" id="userimage" value="">
        <input type="hidden" name="endedCall" value="{'/consultation/ended'|url}">
		<div class="card-body">
		<p class="mb-4" id="request_accept"></p>
		<h5> <p>In consultation since </p></h5>
		<input type="hidden" id="talkTime" value="00:00">
		<div class="row">
			<div class="col-md-4">
				 <div class="webcam-container" id="webcam-container">
            	 </div>
				{* <div class="text-center mt-4">
					<a id="ended" href="{'/consultation/ended'|url}" class="stop-consultation">Stop consultation</a>
				</div> *}
				<div class="text-center mt-4" id="stopConsult" style="display:none;">
				 	<a id="dispose" class="stop-consultation" href="javascript:void(0);">
				 	Stop consultation</a>
				</div>
				<h3><strong id="online-status" class="online"></strong></h3>
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
	<div id="overlay">
          <div class="cv-spinner">
            <span class="spinner"></span>
          </div>
        </div>

	<div class="details-tab-menu">
		<ul class="nav details">
		  <li class="nav-item">
		    <a class="nav-link" href="$voyant|objurl:'voyantDetails'">Profil</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="$voyant|objurl:'voyantComments'">Avis clients</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="{'/voyantPrivateMessage/contact'|url}">Envoyer un message prive</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="{'/voyantReport/report'|url}">Dénoncer un abus</a>
		  </li>
		</ul>
	</div>

</div>
	<div class="voyantdetailsdetails">
		{* START EXPERT LIST *}
		<div id="sidebox-experts">
			<div class="sb-experts-online">
				<div class="text">Recherche d'experts</div>
				<div class="line"></div>
			</div>
			<div class="input-group">
				<input type="search" placeholder="Search an Expert" aria-describedby="button-addon5" class="form-control">
				<div class="input-group-append">
					<button id="button-addon5" type="submit" class="btn btn-primary mb-0"><i class="fa fa-search"></i></button>
				</div>
			</div>
			<div>
				active filter
			</div>
			<div>
				<div class="filter-item">
					search : "a name" <i class="fas fa-times font-size-close"></i>
				</div>
			</div>
			<div class="side-r-experts" data-href="/expert-url/">
				<img src="" alt="" class="img-expert-small" />
				<div class="">
					$voyant.name 4.9/5<br>
					<span class="text-green">Disponible</span>
				</div>
				<div class="status-wrapper webcam present">
				</div>
			</div>
			<div class="side-r-experts" data-href="/expert-url/">
				<img src="" alt="" class="img-expert-small" />
				<div class="">
					$voyant.name 4.9/5<br>
					<span class="text-orange">Occupé - 00:23:59</span>
				</div>
				<div class="status-wrapper webcam busy-small">
				</div>
			</div>
			<div class="side-r-experts" data-href="/expert-url/">
				<img src="" alt="" class="img-expert-small" />
				<div class="">
					$voyant.name 4.9/5<br>
					<span class="text-red">Indisponible</span>
				</div>
				<div class="status-wrapper webcam offline-small">
				</div>
			</div>
		</div>
		{* END EXPERT LIST *}
	<h3 class="voyanth3">{'voyantDetails_hourly'|lang}</h3>
	<div>
	
	</div>

	<h3 class="voyanth3">{'voyantDetails_contact_possibilites'|lang}</h3>
	<div>
	
	</div>

	<h3 class="voyanth3">{'voyantDetails_support_divinatory'|lang}</h3>
	<div>
	
	</div>

	</div>
	
	</div>
</div>	





	{include file="includes/pageNavigation.tpl"}

	</div>
	</div>

</div>
{include file="includes/footer.tpl"}
