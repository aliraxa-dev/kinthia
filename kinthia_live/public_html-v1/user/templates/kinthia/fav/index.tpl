{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/alert/alertOnLoad.js'|resurl}"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
    var pendingMsg = new Array();
    pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};
</script>
{/capture}

{include file="includes/header.tpl" title="{'orderIndex_title_html'|lang}" metaDescription="{'orderIndex_meta_description'|lang}"}

<section id="user-fav1" class="mb-3">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div id="breadcrumb">
                    <a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
                    <a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
                    <a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                {include file="includes/profileMenu.tpl"}
            </div>
        </div>

		<div class="row"> 
		{foreach from=$userFavs value=voyant}
		<div class="col-lg-12">

			<div class="expert-container {cycle values='bg-grey-expert,'}" id="infav1_{$voyant.voyantId}">

				<div class="expert-description">
					<div>
						<h2 class="expert-h2">{$voyant.headerDescription}</h2>
						{if $voyant.ratingAverage > 0}
						<div class="average-rating">
							<span class="average-rating-star"></span>
							{$voyant.ratingAverage}
						</div>
						{/if}
					</div>
						<div class="text-description">
							{if !empty($voyant.shortDescription)}
							«{$voyant.shortDescription|htmlspecialchars_decode}»
							{/if}
						</div>
						<div class="expert-stats">
							<div class="expert-stats-cons"><b>{$voyant.countAnswer}</b> consultations</div>
							<div class="expert-stats-avis"><b>{$statistic.voyantCommentValidatedCount}</b> avis</div>
						</div>
				</div>


				<div class="expert-image">
					{if isset($voyant.imageSrc)}
						<a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="expert-img" width="77px" height="99px" /></a>
					{else}
						<a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.firstGalleryImageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="expert-img" width="77px" height="99px" /></a>
					{/if}

					{if $session.user}
						 
						{if in_array($voyant.voyantId, $userFav)}	
							<a href="#infav1_{$voyant.voyantId}" onclick="userFav({$voyant.voyantId},{$curentUserid})" >
			            	<span class="infav" id="infav_{$voyant.voyantId}"  data-toggle="tooltip" data-html="true" title="Expert dans mes favoris">
			            		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#ad3b3b" viewBox="0 0 16 16">
									<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"></path>
								</svg>
			            	</span>
			            	</a>					   
							{else}	
								<a  href="#infav1_{$voyant.voyantId}" id="infav_{$voyant.voyantId}"  onclick="userFav({$voyant.voyantId},{$curentUserid})" >
								<span class="userfav" data-toggle="tooltip" data-html="true" title="Make favoris ">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#ad3b3b" viewBox="0 0 16 16">
										<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"></path>
									</svg>
								</span>
								</a>
							{/if}
					 
					{else}
							<a href="{'user/main/logIn'}">
							<span class="fas fa-heart withoutfav" data-toggle="tooltip" data-html="true" title="Please Login">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#ad3b3b" viewBox="0 0 16 16">
									<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"></path>
								</svg>
							</span>
							</a>
					{/if}
					
					<form action="{'/user/Fav/save'|url}" method="post" id="voyantFrm">  
	    		 		<input type="hidden" name="voyantId" id="voyantId" value="">
						<input type="hidden" name="userId" id="userId" value="">
	    		 	</form>
				      
				</div>

{* -- START - Expert Action -- *}
<div class="expert-action">
	<div class="expert-action-line">
		<div class="expert-action-icon">
			<!-- logged / webcam ON / expert is not in consultation -->
			{if $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
			{assign var="mUrl" value="/consultation/start/".$voyant.voyantId."/webcam"}
				<a id="startConsultation-webcam" href="{$mUrl|url}" class="status-wrapper webcam present typ" title="Webcam"></a>

			<!-- logged / webcam ON / audio Off / waiting for consultation response -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
				
				<div class="status-wrapper webcam busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					{* depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span> *}
					</div>
				</div>

			<!-- logged / webcam ON / In consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
				
				<div class="status-wrapper webcam busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					depuis <span class="status-display-time clock_{$voyant.voyantId}">
					{* {$voyant.consultationTime|date_format:'%H:%M:%S'} *} 
					<input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
					<input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
					<input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
					
					</span>
					</div>
				</div>

			<!-- logged / webcam OFF / expert is offline -->	
			{elseif (($voyant.displayWebcam==0) || empty($voyant.displayWebcam)) && $voyant.consultationStatus=="OF"}
					<div class="status-wrapper webcam offline">
						{* -- do not display - to change --
						<div class="status-display">
							<span class="status-display-text">indisponible</span><br>
						  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
							<span class="status-display-alert">M'alerter par email de son retour</span>
							</div>
						-- do not display -- to change -- *}
						</div>

				<!-- unlogged / webcam ON / expert is offline -->	
				{elseif $voyant.displayWebcam}
						<div class="status-wrapper webcam offline">
							{* -- do not display - to change --
							<div class="status-display">
								<span class="status-display-text">indisponible</span><br>
							  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
								<span class="status-display-alert">M'alerter par email de son retour</span>
								</div>
							-- do not display -- to change -- *}
							</div>
			{else}
				<div class="status-wrapper webcam disable"></div>
			{/if}
		</div>


	
		<div class="expert-action-icon">
			<!-- logged / audio ON / expert is not in consultation -->
			{if $voyant.displayPhone && $voyant.consultationStatus=="ON"}
				{assign var="pUrl" value="/consultation/start/".$voyant.voyantId."/phone"}
				<a id="startConsultation-phone" href="{$pUrl|url}" class="status-wrapper phone present typ" title="Tél"></a>

			<!-- logged / webcam ON / audio off / expert is not in consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
				 <div class="status-wrapper phone offline">
				 	{* -- do not display - to change --
						<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
					 Retour à <span class="status-display-back">{$voyant.consultationTime}</span><br>
						 <span class="status-display-alert">M'alerter par email de son retour</span>
						</div>
					-- do not display -- to change -- *}
					</div>

			<!-- logged / audio on / waiting for consultation response -->			
			{elseif $voyant.displayPhone && $voyant.consultationStatus=="P"}	
					<div class="status-wrapper phone busy">
						<div class="status-display">
							<span class="status-display-text">En consultation</span><br>
							{* depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span> *}
						</div>
					</div>

			  <!-- user loggedIn && Webcam on && audio off && waiting for consultation response -->
				{elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
				
				<div class="status-wrapper phone offline">
					{* -- do not display - to change --
						<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
					  {*	Retour à <span class="status-display-back">19h00</span><br> *}
						{* <span class="status-display-alert">M'alerter par email de son retour</span> *}
						</div>
					-- do not display -- to change -- *}
					</div>

			<!-- logged / audio ON / In consultation -->	
			{elseif $voyant.displayPhone && $voyant.consultationStatus=="B"}
				
				<div class="status-wrapper phone busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					depuis <span class="status-display-time clock_{$voyant.voyantId}">
					<input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
					<input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
					<input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
					</span>
					</div>
				</div>
				
		  <!-- logged / webcam ON / audio off / In consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
				<div class="status-wrapper phone offline">
				{* -- do not display - to change --
					<div class="status-display">
					<span class="status-display-text">indisponible</span><br>
					depuis <span class="status-display-time clock_{$voyant.voyantId}">
					<input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
					<input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
					<input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
					</span>
					</div>
				-- do not display -- to change -- *}
				</div>

			<!-- logged / audio OFF / expert is offline -->	
			{elseif (($voyant.displayPhone==0) || empty($voyant.displayPhone)) && $voyant.consultationStatus=="OF"}
					<div class="status-wrapper phone offline">
					{* -- do not display - to change --
						<div class="status-display">
							<span class="status-display-text">indisponible</span><br>
						  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
							<span class="status-display-alert">M'alerter par email de son retour</span>
						</div>
					-- do not display -- to change -- *}
					</div>

				<!-- unlogged / audio ON / expert is offline -->	
				{elseif $voyant.displayPhone}
						<div class="status-wrapper phone offline">
						{* -- do not display - to change --
							<div class="status-display">
								<span class="status-display-text">indisponible</span><br>
							  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
								<span class="status-display-alert">M'alerter par email de son retour</span>
							</div>
						-- do not display -- to change -- *}
						</div>

			{else}
					<div class="status-wrapper phone disable"></div>
			{/if}
		</div>
	</div>	


	<div class="expert-action-line">
		<div class="expert-action-icon">
			{if $voyant.displayEmail}
				{* {assign var="eUrl" value="/consultation/start/".$voyant.voyantId."/email"} *}
				{assign var="eUrl" value="/".$voyant.urlName}
				<a href="{$eUrl|url}" class="status-wrapper chat present" title="Chat"></a>
			{else}
				<div class="status-wrapper chat disable"></div>
			{/if}
		</div>

		<div class="expert-action-icon">
			{if $voyant.displayEmail}
				{* {assign var="eUrl" value="/consultation/start/".$voyant.voyantId."/email"} *}
				{assign var="eUrl" value="/".$voyant.urlName}
				<a href="{$eUrl|url}" class="status-wrapper email present" title="Email"></a>
			{else}
				<div class="status-wrapper email disable"></div>
			{/if}
		</div>
	</div>
	<div class="expert-current-status">
		disponible
	</div>
</div>
{* -- END - Expert Action -- *}


</div>
</div>
{/foreach}


</div>
</div>
</section>

{include file="includes/footer.tpl"}