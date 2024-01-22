{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
 
<script type="text/javascript" src="{'/javascript/jquery/jquery.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/voyant/detailsOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/alert/alertOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/voyant/displayTime.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/voyant/calanderUserConsultation.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/main/indexOnLoad.js'|resurl}"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  

<script>
//var setting = new Array();
//setting.questionPrices = {$questionPrices|htmlspecialchars_decode};

var questionPrices = new Array();	
setting.questionPrices = {$questionPrices|htmlspecialchars_decode};
var voyantId = {$voyant.voyantId};
var consultationStatus = "{$voyant.consultationStatus}";
var displayPhone = "{$voyant.displayPhone}";
var displayWebcam = "{$voyant.displayWebcam}";
var displayEmail = "{$voyant.displayEmail}";
var availabilityRefreshRate = {$availabilityRefreshRate};
</script>
{/capture}

{assign var="pageTitle" value=$voyant.title}

{if $voyant.metaDescription}
{assign var="metaDescription" value=$voyant.metaDescription}
{/if}

{if $pageNavigation.currentPage > 1}
   {assign var="pageTitle" value=$pageTitle|cat:" - {'page'|lang} "|cat:$pageNavigation.currentPage}
   {assign var="metaDescription" value=$voyant.metaDescription|cat:" - {'page'|lang} "|cat:$pageNavigation.currentPage}
{/if}

{include file="includes/header.tpl" title=$pageTitle}
<section id="expert-details">
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
					{if $voyantSkills && $skillIds}
						{foreach from=$voyantSkills item=skill}
							{if in_array($skill.skillId, $skillIds)}						   
			                  	<a href="{"/skill/detail/".$skill.slug}">{$skill.name}</a>,	 					
							{/if}
						{/foreach}
					{/if}
				</div>
				<div class="expert-details-tools">
				{* -- START - ALERT -- *}

					{if $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
 
						<span class="disable" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available.">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
								<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
							</svg>
						</span>
				 
					<!-- logged / webcam ON / audio Off / waiting for consultation response -->	
					{elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}

						{*<a id="alert" href="{'/popUp/alert'$voyant.voyantId|url}">*}
						<a id="alert" href="{'/popUp/alert'|url}">
							<span class="" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available.">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
									<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
								</svg>
							</span>
						</a>

					<!-- logged / webcam ON / In consultation -->	
					{elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}

						<span class="disable" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available.">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
								<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
							</svg>
						</span>
						 

					<!-- logged / webcam OFF / expert is offline -->	
					{elseif (($voyant.displayWebcam==0) || empty($voyant.displayWebcam)) && $voyant.consultationStatus=="OF"}

						{*<a id="alert" href="{'/popUp/alert'$voyant.voyantId|url}">*}
						<a id="alert" href="{'/popUp/alert'|url}">
							<span class="" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available.">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
									<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
								</svg>
							</span>
						</a>

					<!-- unlogged / webcam ON / expert is offline -->	
					{elseif $voyant.displayWebcam}

						{*<a id="alert" href="{'/popUp/alert'$voyant.voyantId|url}">*}
						<a id="alert" href="{'/popUp/alert'|url}">
							<span class="" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available.">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
									<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
								</svg>
							</span>
						</a>
					{else}
						<span class="disable" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available.">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
								<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
							</svg>
						</span>
					{/if}

				{* -- END - ALERT --*}
				{* -- START - FAV -- *}

					{if $session.user}
						{if in_array($voyant.voyantId, $userFav)}	
							
			            	<span onclick="userFav({$voyant.voyantId},{$userid})" class="infav" data-toggle="tooltip" data-html="true">
			            		<svg xmlns="http://www.w3.org/2000/svg" id="infav_{$voyant.voyantId}" class="infav_{$voyant.voyantId}" width="16" height="16" fill="#ad3b3b" viewBox="0 0 16 16" title="Supprimer le favoris">
									<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
								</svg>
			            	</span>
			            					   
						{else}	
							
							<span onclick="userFav({$voyant.voyantId},{$userid})" class="userfav" data-toggle="tooltip" data-html="true">
								<svg xmlns="http://www.w3.org/2000/svg" id="infav_{$voyant.voyantId}" class="infav_{$voyant.voyantId}" width="16" height="16" fill="#000" viewBox="0 0 16 16" title="Make favoris">
									<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
								</svg>
							</span>
						
						{/if}
					 
					{else}
						<a href="#" onclick="getLogin()">
							<span class="withoutfav" data-toggle="tooltip" data-html="true" title="Please Login">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
									<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
								</svg>
							</span>
						</a>
					{/if}
					 <form action="{'/user/Fav/save'|url}" method="post" id="voyantFrm" style="display: contents;">  
    		 			<input type="hidden" name="voyantId" id="voyantId" value="">
						<input type="hidden" name="userId" id="userId" value="">
    		 		</form>

    		 	{* -- END - FAV -- *}

				 {if $voyant.audioSrc}
    		 	{* -- START - AUDIO PRESENTATION -- *}
				<span class="player"  onclick="togglePlay(this)" style="margin: 0 0;">
					<span id="button" class="icon" data-toggle="tooltip" data-html="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
							<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM6.79 5.093A.5.5 0 0 0 6 5.5v5a.5.5 0 0 0 .79.407l3.5-2.5a.5.5 0 0 0 0-.814l-3.5-2.5z"/>
						</svg>
					</span>
					<audio id="voyant-presentation">
						<source src="/uploads/audio/{$voyant.audioSrc}" />
					</audio>
				</div>
    		 		
    		 	{* -- END - AUDIO PRESENTATION -- *}
				{/if}

				</div>



				{* -- START - TAB -- *}
				<div class="details-tab-menu">
				<ul class="nav details">
				  <li class="nav-item">
				    <a class="nav-link active" href="{$voyant|objurl:'voyantDetails'}">Profil</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="{$voyant|objurl:'voyantComments'}">Avis clients</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="#expert-details-message-box">Envoyer un message prive</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="#expert-details-report">Dénoncer un abus</a>
				  </li>
				</ul>
			</div>
				{* -- END - TAB -- *}


		{* -- START - CONSULTATION -- *}
		<div class="expert-details-consultations">
		<p>Consulter <span class="expert-details-consultations-name">« {$voyant.headerDescription} »</span> par</p>
		<input type="hidden" id="vid" value="{$voyant.voyantId}">
		<ul class="expert-detail-ul-consultation">	
			<li>
			<!-- logged / webcam ON / expert is not in consultation -->
			{if $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
			{assign var="mUrl" value="/consultation/start/".$voyant.voyantId."/webcam"}
				<a id="startConsultation-webcam" href="{$mUrl|url}" class="status-wrapper webcam-details present typ" title="Webcam"></a>

			<!-- logged / webcam ON / audio Off / waiting for consultation response -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
				
				<div class="status-wrapper webcam-details busy">
					{*<div class="status-display">
						<span class="status-display-text">En consultation</span><br>
						 depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span> 
					</div>*}
				</div>

			<!-- logged / webcam ON / In consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
				
				<div class="status-wrapper webcam-details busy">
					<div class="status-display">
						<span class="status-display-text">En consultation</span><br>
						depuis <span class="status-display-time clock_{$voyant.voyantId}">
							<input type="hidden" class="cHour" value="{$voyant.consultationTime|date_format:'%H'}">
							<input type="hidden" class="cMin" value="{$voyant.consultationTime|date_format:'%M'}">
							<input type="hidden" class="cSec" value="{$voyant.consultationTime|date_format:'%S'}">
						</span>
					</div>
				</div>	

			<!-- logged / webcam OFF / expert is offline -->	
			{elseif (($voyant.displayWebcam==0) || empty($voyant.displayWebcam)) && $voyant.consultationStatus=="OF"}
				<div class="status-wrapper webcam-details offline">
					{* -- START - To change --
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
				  		Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
						<span class="status-display-alert">M'alerter par email de son retour</span>
					</div>
					-- END - To change -- *}
				</div>

			<!-- unlogged / webcam ON / expert is offline -->	
			{elseif $voyant.displayWebcam}
				<div class="status-wrapper webcam-details offline">
					{* -- START - To change --
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
					  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
						<span class="status-display-alert">M'alerter par email de son retour</span>
					</div>
					-- END - To change -- *}
				</div>
			{else}
				<div class="status-wrapper webcam-details disable"></div>
			{/if}
			</li>
	

			<li>
			<!-- logged / audio ON / expert is not in consultation -->
			{if $voyant.displayPhone && $voyant.consultationStatus=="ON"}
				{assign var="pUrl" value="/consultation/start/".$voyant.voyantId."/phone"}
				<a id="startConsultation-phone" href="{$pUrl|url}" class="status-wrapper phone-details present typ" title="Tél"></a>

			<!-- logged / webcam ON / audio off / expert is not in consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
				 <div class="status-wrapper phone-details offline">
				 	{* -- START - To change --
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
				 		Retour à <span class="status-display-back">{$voyant.consultationTime}</span><br>
						<span class="status-display-alert">M'alerter par email de son retour</span>
					</div>
					-- END - To change -- *}
				</div>

			<!-- logged / audio on / waiting for consultation response -->			
			{elseif $voyant.displayPhone && $voyant.consultationStatus=="P"}	
				<div class="status-wrapper phone-details busy">
					<div class="status-display">
						<span class="status-display-text">En consultation</span><br>
						{* depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span> *}
					</div>
				</div>

			<!-- user loggedIn && Webcam on && audio off && waiting for consultation response -->
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
				
				<div class="status-wrapper phone-details offline">
					{* -- START - To change --
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
				  		{*	Retour à <span class="status-display-back">19h00</span><br> *}
						{* <span class="status-display-alert">M'alerter par email de son retour</span> *}
					</div>
					-- END - To change -- *}
				</div>

			<!-- logged / audio ON / In consultation -->	
			{elseif $voyant.displayPhone && $voyant.consultationStatus=="B"}
				
				<div class="status-wrapper phone-details busy">
					<div class="status-display">
						<span class="status-display-text">En consultation</span><br>
						depuis <span class="status-display-time clock_{$voyant.voyantId}">
						<input type="hidden" class="cHour" value="{$voyant.consultationTime|date_format:'%H'}">
						<input type="hidden" class="cMin" value="{$voyant.consultationTime|date_format:'%M'}">
						<input type="hidden" class="cSec" value="{$voyant.consultationTime|date_format:'%S'}">
						</span>
					</div>
				</div>
				
			<!-- logged / webcam ON / audio off / In consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
				<div class="status-wrapper phone-details offline">
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
						depuis <span class="status-display-time clock_{$voyant.voyantId}">
							<input type="hidden" class="cHour" value="{$voyant.consultationTime|date_format:'%H'}">
							<input type="hidden" class="cMin" value="{$voyant.consultationTime|date_format:'%M'}">
							<input type="hidden" class="cSec" value="{$voyant.consultationTime|date_format:'%S'}">
						</span>
					</div>
				</div>

			<!-- logged / audio OFF / expert is offline -->	
			{elseif (($voyant.displayPhone==0) || empty($voyant.displayPhone)) && $voyant.consultationStatus=="OF"}
				<div class="status-wrapper phone-details offline">
					{* -- START - To change --
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
					  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
						<span class="status-display-alert">M'alerter par email de son retour</span>
					</div>
					-- END - To change -- *}
				</div>

			<!-- unlogged / audio ON / expert is offline -->	
			{elseif $voyant.displayPhone}
				<div class="status-wrapper phone-details offline">
					{* -- START - To change --
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
					  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
						<span class="status-display-alert">M'alerter par email de son retour</span>
					</div>
					-- END - To change -- *}
				</div>

			{else}
				<div class="status-wrapper phone-details disable"></div>
			{/if}
			</li>		

			<!-- consultation chat -->
			<li>				
				{if $voyant.displayEmail}
					{assign var="eUrl" value="/consultation/start/".$voyant.voyantId."/chat"}
					<a id="startConsultation-chat" href="{$eUrl|url}" class="status-wrapper chat-details present typ" title="Chat"></a>
				{else}
					<div class="status-wrapper chat-details disable"></div>
				{/if}
			</li>

			<!-- consultation email -->
			<li>				
				{if $voyant.displayEmail}
					{assign var="eUrl" value="/".$voyant.urlName}
					<a href="javascript:void(0)" id="scroll-to-question-list" class="status-wrapper email-details present" title="Email"></a>
				{else}
					<div class="status-wrapper email-details disable"></div>
				{/if}
			</li>	

		</ul>

			<!-- logged / webcam ON / audio Off / waiting for consultation response --> <!-- logged / audio on / waiting for consultation response -->	
			{if ($voyant.displayWebcam && $voyant.consultationStatus=="P") || ($voyant.displayPhone && $voyant.consultationStatus=="P")}
				<div class="status-time">
					<span class="expert-status-time bg-busy">Occupé</span>
				</div>
			{/if}

			<!-- logged / webcam ON / In consultation --> <!-- logged / audio ON / In consultation -->	
			{if ($voyant.displayWebcam && $voyant.consultationStatus=="B") || ($voyant.displayPhone && $voyant.consultationStatus=="B")}
				<div class="status-time">
					<span class="expert-status-time bg-busy clock_{$voyant.voyantId}">
						Occupé ~<span class="hours">00</span>:<span class="minutes">04</span>:<span class="seconds">18</span>
					</span>
					<input type="hidden" id="startConsultTime" value="{$timeStamp}">
				</div>
				<div class="expert-status-time-remaining">
					Temps max. restant de la consultation en cours : <span class="clock"></span>
				</div>
			{/if}
		</div>
		{* -- END - CONSULTATION -- *}
				<div class="expert-details-stats">
					<div class="row">
						<div class="col">
							<p>Consultations</p>
							<div><b>{if isset($voyant.userQuestions[0])}{$answeredCount}{else}0{/if}</b></div>
						</div>
						<div class="col">
							<p>Note moyenne</p>
							{if $voyant.ratingAverage > 0}
							<div class="average-rating">
								<span class="average-rating-star"></span>
								{$voyant.ratingAverage}
							</div>
							{/if}
						</div>
						<div class="col">
							<p>Nombre d'avis</p>
							<div class="expert-stats-avis"><b>{$statistic.voyantCommentValidatedCount}</b></div>
						</div>
					</div>
				</div>

				<div class="expert-details-text-content">
					<div class="expert-details-text-quote">
						{if !empty($voyant.voyantQuote)}
							{$voyant.voyantQuote|htmlspecialchars_decode}
						{/if}
					</div>
					<div class="expert-text-description reduced">
						{if !empty($voyant.voyantDescription)}
							{$voyant.voyantDescription|htmlspecialchars_decode}
						{/if}
						<div class="expert-text-description-expander"><span>En savoir plus</span></div>
					</div>
				</div>
				
				{if $nextTimeSlot}
					<div class="expert-details-planning">
						<h2>Planning de <span>{$voyant.headerDescription}</span></h2>
						{if !empty($voyant.timezone)}
							<div class="expert-details-timezone">
								<p>Fuseau horaire : <b>{$voyant.timezone|htmlspecialchars_decode}</b></p>
							</div>
						{/if}
						<div class="container">
							{foreach from=$nextTimeSlot key=firstKey item=dateTimeSlot}
								{if "now"|date_format:'%Y-%m-%d' == $firstKey|date_format:'%Y-%m-%d'}
									<div class="row expert-details-calendar active">
								{else}
									<div class="row expert-details-calendar">
								{/if}
									<div class="col details-day">
										{$firstKey|date_format:"%A %d/%m/%Y"}
									</div>
									<div class="col details-hour">
										{foreach from=$dateTimeSlot item=timeSlot}
											<div class="items">{$timeSlot[0]} à {$timeSlot[1]}</div>
										{/foreach}
									</div>
								</div>
							{/foreach}
						</div>
					</div>
				{/if}


				{* -- START - EXPERT ARTICLE TO BUY -- *}
				<div id="article-to-buy" class="expert-details-article-to-buy">
					<h2><span>{$voyant.headerDescription}</span> répond par écrit</h2>
				{if $voyant.available}
				<div class="row">
					{foreach from=$voyant.voyantQuestions item=voyantQuestion}
						<div class="col-lg-4">
							{if $voyantQuestion.displayOnline && $voyantQuestion.adminValidation}
								<div class="question-container">
								<h2 onclick='javascript:location.href="{$voyantQuestion|objurl:"voyantQuestionDetails"}"'>{$voyantQuestion.title}</h2>
									{* -- START - DO NOT DISPLAY IMAGE --
									<div class="voyantdetailsitemimage" onclick='javascript:location.href="{$voyantQuestion|objurl:"voyantQuestionDetails"}"'>
										<a href="{$voyantQuestion|objurl:'voyantQuestionDetails'}"><img src="{$voyantQuestion.imageSrc|realImgSrc:'voyantQuestion'}" alt="{$voyantQuestion.title}" class="imagecarte" /></a>
									</div>
									-- START - DO NOT DISPLAY IMAGE -- *}

								<div class="question-description">
									{$voyantQuestion.shortDescription|htmlspecialchars_decode}
								</div>

								<div class="question-price">
									<span class="price">{$voyantQuestion.price} {'euro_symbole'|lang}</span><br />
								</div>

								{* -- START - DO NOT DISPLAY MULTI PRICE && DISCOUNT --
								<div class="column_in_box_voyant_question_list_price_select">
									{'voyantDetails_quantity'|lang}
									<select name="priceId">
									<option value="">1 = {$voyantQuestion.price}{'euro_symbole'|lang}</option>
									{foreach from=$voyantQuestion.voyantQuestionPrices item=voyantQuestionPrice}
									{math equation="100 - (100 * t / (x * q))" x=$voyantQuestion.price t=$voyantQuestionPrice.price q=$voyantQuestionPrice.quantity assign="pricePercentageDiscount"}
									<option value="{$voyantQuestionPrice.priceId}">{$voyantQuestionPrice.quantity} = {$voyantQuestionPrice.price}{'euro_symbole'|lang}{if $pricePercentageDiscount} - {'voyantDetails_you win'|lang} {$pricePercentageDiscount|round}%{/if}</option>
									{/foreach}
									</select>
								</div>
								-- END - DO NOT DISPLAY MULTI PRICE && DISCOUNT -- *}

								<div class="grid-2-small-2 voyantdetailsitembottom man">
								    {if $voyant.displayEmail}
										<input type="hidden" name="questionId" value="{$voyantQuestion.questionId}">
										<button class="btn btn-add-to-cart w-100 add-to-cart" onclick="ga('send', 'event', 'voyantProductPage', 'addToCart', '{$voyantQuestion.title}');">Ajouter au panier</button>
									{else}
					 					<span>You can't buy this item for the moment.</span>
									{/if}
								</div>

								</div>
							{/if}
						</div>
					{/foreach}
				</div>

				{else}
					<div class="row">
						<div class="col-lg-12">
						{'voyantDetails_voyant_not_available'|lang}
						</div>
					</div>
				{/if}

				{if $voyant.available}
					<div class="row">
						<div class="col-lg-12">
						{include file="includes/pageNavigation.tpl"}
						</div>
					</div>
				{/if}
				</div>
				{* -- END - EXPERT ARTICLE TO BUY -- *}

				{* -- START - REVIEWS -- *}
				<div class="expert-details-reviews">
					<h2>Avis client</h2>
				<div class="row">
					<div class="col-lg-12">
						{if $Reviewvoyant}
							<div class="review-container">
							{foreach from=$Reviewvoyant item=voyantComment}
							<div class="expert-details-review-container">

							    {if $voyantComment.type=='W'}
									<i class="fas fa-video"></i>
								{elseif $voyantComment.type=='Q'}
									<span class="review-type">
										<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="#fff" class="review-icon-envelop" viewBox="0 0 16 16">
  											<path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555ZM0 4.697v7.104l5.803-3.558L0 4.697ZM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757Zm3.436-.586L16 11.801V4.697l-5.803 3.546Z"/>
										</svg>
									</span>
								{elseif $voyantComment.type=='P'}
									<span class="review-type">
										<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="#fff" class="review-icon-envelop" viewBox="0 0 16 16">
										  <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/>
										</svg>
									</span>
								{elseif $voyantComment.type=='E'}
									<span class="review-type">
										<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="#fff" class="review-icon-envelop" viewBox="0 0 16 16">
  											<path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555ZM0 4.697v7.104l5.803-3.558L0 4.697ZM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757Zm3.436-.586L16 11.801V4.697l-5.803 3.546Z"/>
										</svg>
									</span>
								{else}
								 	N/A
								{/if}
					
								<span class="review-pseudo">{$voyantComment.name}</span>
								<span class="review-date">{$voyantComment.date|date_format:"%d.%m.%Y"}</span>
								<span class="review-start float-right">
									{if $voyantComment.rating==1}
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
									{/if}

					         		{if $voyantComment.rating==2}
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
									{/if}

									{if $voyantComment.rating==3}
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
							   		{/if}

									{if $voyantComment.rating==4}
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
									{/if}

									{if $voyantComment.rating==5}
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
											<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
										</svg>
									{/if}
								</span>

								<div class="review-txt">
									{$voyantComment.text}
								</div>
								{if $voyantComment.replyText}
									<div class="review-txt-answer">
										<div class="review-answer-pseudo">Réponse de <span>{$voyant.headerDescription}</span></div>
											<div class="review-answer-msg">{$voyantComment.replyText}</div>
									</div>
								{/if}

								{* -- START - DO NOT DISPLAY --
								<div class="details-stars">
									{if $voyantComment.rating > 0}{$voyantComment.rating} / 5{else}n/a{/if}
								</div>
							 
								<div class="details-see-reviews">
									<a href="{$voyant|objurl:'voyantComments'}">Voir plus</a>
								</div>
								-- END - DO NOT DISPLAY -- *}

							</div>
							{/foreach}
							</div>

		 				{else}
	 						<div class="text-center">No Reviews</div>
						{/if}
					</div>

					{if $Reviewvoyant|@count > $reviewLimit - 1}
						<div id="more-review" class="col-lg-12">
							<div class="review-load-more">
								<button class="btn btn-kin1" onclick="loadMoreReviews({$voyant.voyantId},{$reviewLimit})">Load more reviews</button>
							</div>
						</div>
					{/if}
				</div>
				</div>
				{* -- END - REVIEWS -- *}

				{* -- START - MESSAGE -- *}
				{if $session.user}
				<div class="expert-details-message">
						<div class="row">
							<div class="col-lg-12">
								<div id="expert-details-message-box" class="expert-details-message-box">
									<div class="expert-details-display-msg">
										Envoyer un message à <span>{$voyant.headerDescription}</span>
									</div>
									<div class="expert-details-display-msg-to-display" style="display: none;">
										{if $session.user && !empty($isConsultWithVoyant)}
										<div>
											<a href="{"/user/privateMessage/details/$voyant.voyantId"|url}"><strong>Consulter / envoyer des messages privés</strong></a>
										</div>
										{/if}

										{if $session.user && empty($isConsultWithVoyant)}
										<div class="alert alert-danger">
											Vous ne pouvez pas envoyer de message privé car vous n'avez pas encore consulté cet expert
										</div>
										{/if}
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div id="expert-details-report" class="expert-details-report">
									<div class="expert-details-display-report">
										Dénoncer un abus sur <span>{$voyant.headerDescription}</span>
									</div>
									<div class="expert-details-display-report-to-display" style="display: none;">
										<div>
											<ol>
												<li>Vous avez rencontré un souci important (d'ordre majeur) lors d'une consultation avec un expert</li>
												<li>Un expert vous a insulté, a été grossié ou encore, vous a critiqué sans aucune raison valable</li>
												<li>Un expert essaye d'abuser de votre naïveté pour vous faire consulter sans modération</li>
												<li>Un expert essaye de vous soutirer de l'argent</li>
												<li>Un expert dénigre un autre expert d'Idealvoyance</li>
												<li>Un expert vous propose de la magie noire ou de l'occulte ( sorcellerie, désenvoutement, exorcisme, ... ) avec ou sans échange d'argent</li>
												<li>Un expert vous donne un pronostic de santé et vous conseille de renoncer à un traitement médical ou vous annonce un décès</li>
												<li>Un expert vous divulgue des informations concernant un autre consultant et ne respecte pas le secret professionnel</li>
												<li>Un expert effectue une consultation à un mineur (personne de moins de 18 ans)</li>
												<li>Vous êtes tombés 1x ou plus sur le répondeur privé de l'expert sans avoir eu de consultation.</li>
											</ol>
											<p>Les messages pour dénoncer un abus sont transmis à notre service de plainte. Ces messages sont traités dans la plus STRICTE confidentialité !</p>
											<div>
												{if $session.user && !empty($voyantConsFromUserCons) }
												<form action="{"/voyantReport/record"|url}" method="post">
												 	<div class="form-group">
													    <label>Select consultation</label>
													    <select  class="form-control" name="consultantName" required>

													    	<option>Select consultation</option>
															{foreach from=$voyantConsFromUserCons item=userQuestions}
													     	 	<option> {$userQuestions.start_time} - {$userQuestions.type} - duration : {if  $userQuestions.duration}{$userQuestions.duration}{else}00.00.00{/if} </option>
															{/foreach}

													    </select>
													</div>
													<div class="form-group">
													    <textarea required name="explainProblem" class="form-control" rows="5" placeholder="Indiquez la date et l'heure de la consultation ainsi que le problème rencontré avec {$voyant.headerDescription}"></textarea>
												  	</div>
												  	<button type="submit" class="btn btn-kin1">Submit</button>
													<input type="hidden" name="voyantId" value="{$voyant.voyantId}" />
												</form>
												{/if}
													
												{if $session.user && empty($voyantConsFromUserCons)}
													<div class="alert alert-danger">
														You haven't consulted this expert. You can't send a Report
													</div>
												{/if}
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
				</div>
				{else}
				<div class="expert-details-message">
						<div class="row">
							<div class="col-lg-12">
								<div id="expert-details-message-box" class="expert-details-message-box">
									<a href="{'/user/main/logIn'|url}">
										<div>Envoyer un message à <span>{$voyant.headerDescription}</span></div>
									</a>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div id="expert-details-report" class="expert-details-report">
									<a href="{'/user/main/logIn'|url}">
										<div>Dénoncer un abus sur <span>{$voyant.headerDescription}</span></div>
									</a>
								</div>
							</div>
						</div>
				</div>
				{/if}
				{* -- END - MESSAGE -- *}			

			</div>	
			</div>
		</div>
	</div>
</section>
<section id="breadcrumb">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb-bottom">
					<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt; <a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt; <a href="{$voyant|objurl:'voyantDetails'}">{if $voyant.navigationName}{$voyant.navigationName}{else}{$voyant.name}{/if}</a>
				</div>
			</div>
		</div>
	</div>
</section>






{* START EXPERT LIST  -- DO NOT DISPLAY --
	<div class="voyantdetailsdetails">
		
		<div id="sidebox-experts">
			<div class="sb-experts-online">
				<div class="text">Recherche d'experts</div>
				<div class="line"></div>
			</div>
  
					 	<div class="input-group">
				<input id="textInput" type="search" name="filtervoaynt" placeholder="Search an Expert" aria-describedby="button-addon5" class="form-control live-search-box">
				<div class="input-group-append">
					<button id="button-addon5" type="submit" class="btn btn-primary mb-0"><i class="fa fa-search"></i></button>
				</div>
			</div>
			 
		

			<div>
				active filter
			</div>
			<div>
				<div class="filter-item "  id="displayText">
					search : "Search  Expert "  <i class="fas fa-times font-size-close"></i>
				</div>
			</div>
		


            <section class="live-search-list" style="height:400px;overflow-y: scroll;">
		 {foreach from=$allVoyantFromVoyantSkills item=allvoyant key=mkey}

			<div  class="side-r-experts" data-href="/expert-url/">
			<i style="display:none;"> {$allvoyant.name}</i> 
				<a href="../{$allvoyant.name|replace:' ':'-'}"><img src="{$allvoyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$allvoyant.title}" class="img-expert-small" /></a>
				<div class="voyantName">
					{$allvoyant.name}  {if $allvoyant.ratingAverage > 0}{$allvoyant.ratingAverage} / 5 sur {$statistic.voyantCommentValidatedCount} avis{else}n/a{/if} <br>
				 
					

 

                    	 {if $allvoyant.displayWebcam && $allvoyant.consultationStatus=="ON"}
			 <span class="text-green">  online   </span>
				 
			<!-- logged / webcam ON / audio Off / waiting for consultation response -->	
			{elseif $allvoyant.displayWebcam && $allvoyant.consultationStatus=="P"}
				
			<span class="text-green">  Available   </span>
				 

			<!-- logged / webcam ON / In consultation -->	
			{elseif $allvoyant.displayWebcam && $allvoyant.consultationStatus=="B"}
				
			 <span class="text-green"> Busy   </span>

			<!-- logged / webcam OFF / expert is offline -->	
			{elseif (($allvoyant.displayWebcam==0) || empty($allvoyant.displayWebcam)) && $allvoyant.consultationStatus=="OF"}
					 <span class="text-green">  offline </span>

				<!-- unlogged / webcam ON / expert is offline -->	
				{elseif $allvoyant.displayWebcam}
					 <span class="text-green">  INDISPONIBLE </span>
						 
			{else}
				 <span class="text-green">  INDISPONIBLE  </span>
			 
			{/if}



				</div>
			 {if $allvoyant.displayWebcam && $allvoyant.consultationStatus=="ON"}
			{assign var="mUrl" value="/consultation/start/".$allvoyant.voyantId."/webcam"}
				<a id="startConsultation-webcam" href="{$mUrl|url}" class="status-wrapper webcam present typ" title="Webcam"></a>
				 
			<!-- logged / webcam ON / audio Off / waiting for consultation response -->	
			{elseif $allvoyant.displayWebcam && $allvoyant.consultationStatus=="P"}
				
				<div class="status-wrapper webcam busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					 depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span> 
					</div>
				</div>
				 

			<!-- logged / webcam ON / In consultation -->	
			{elseif $allvoyant.displayWebcam && $allvoyant.consultationStatus=="B"}
				
				<div class="status-wrapper webcam busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					depuis <span class="status-display-time clock_{$allvoyant.voyantId}">
						<input type="hidden" class="cHour" value="{$allvoyant.consultationTime|date_format:'%H'}">
						<input type="hidden" class="cMin" value="{$allvoyant.consultationTime|date_format:'%M'}">
						<input type="hidden" class="cSec" value="{$allvoyant.consultationTime|date_format:'%S'}">
					</span>
					</div>
				</div>
			 

			<!-- logged / webcam OFF / expert is offline -->	
			{elseif (($allvoyant.displayWebcam==0) || empty($allvoyant.displayWebcam)) && $allvoyant.consultationStatus=="OF"}
					<div class="status-wrapper webcam offline">
						<div class="status-display">
							<span class="status-display-text">indisponible</span><br>
						  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
							<span class="status-display-alert">M'alerter par email de son retour</span>
							</div>
						</div>
				 

				<!-- unlogged / webcam ON / expert is offline -->	
				{elseif $allvoyant.displayWebcam}
						<div class="status-wrapper webcam offline">
							<div class="status-display">
								<span class="status-display-text">indisponible</span><br>
							  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
								<span class="status-display-alert">M'alerter par email de son retour</span>
								</div>
							</div>
						 
			{else}
				<div class="status-wrapper webcam disable"></div>
			 
			{/if}
			</div>
			
			{/foreach}
			</section>

			 
			<!-- <div class="text-center" id="button_new">
				<button id="button-addon5" type="text" class="btn btn-violet">More Expert</button>
			</div>
			-->
		 
		</div>
-- --- END EXPERT LIST - DO NOT DISPLAY -- *}

{include file="includes/footer.tpl"}