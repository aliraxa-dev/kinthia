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
<script type="text/javascript" src="{'/javascript/main/indexOnLoad.js'|resurl}"></script>
{/capture}

{include file="includes/header.tpl" title="{'voyantComment_html_title'|lang} $voyant.name" metaDescription="{'voyantComment_meta_description'|lang} $voyant.name {'voyantComment_meta_description1'|lang}"}

<div class="padding-wrapper aftermenutop">
	<div id="breadcrumb">
	<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
	<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
	<a href="{$voyant|objurl:'voyantDetails'}">{if $voyant.navigationName}{$voyant.navigationName}{else}{$voyant.name}{/if}</a> &gt;
	<a href="{$voyant|objurl:'voyantComments'}">{'voyantComment_arbo'|lang} {$voyant.name}</a>
	</div>
<!--
	{include file="includes/profileBox.tpl"}
-->
	<div class="voyantcommentcontainer pas">
	<h1 class="voyanth1">{$voyant.headerDescription}</h1>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>

		<div class="grid-3-small-2 man pan">
			<div class="voyantimagedetails">
			<img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.title}" class="imagevoyant" />
			       {if $session.user}
						 
								{if in_array($voyant.voyantId, $userFav)}	
								<a href="#" onclick="userFav({$voyant.voyantId},{$userid})" >
			                  		 					<i class="fas fa-heart infav" data-toggle="tooltip" data-html="true" title="Expert dans mes favoris"></i></a>					   
								{else}	
								<a href="#" onclick="userFav({$voyant.voyantId},{$userid})" ><i  class="fas fa-heart userfav" data-toggle="tooltip" data-html="true" title="Make favoris "></i></a>
								{/if}
					 
						 {else}
						   <a href="{'user/main/logIn'}"><i class="fas fa-heart withoutfav" data-toggle="tooltip" data-html="true" title="Please Login"></i></a>
					{/if}
				          
				
				 <form action="{'/user/Fav/save'|url}" method="post" id="voyantFrm">  
    		 	<input type="hidden" name="voyantId" id="voyantId" value="">
				<input type="hidden" name="userId" id="userId" value="">
    		 </form>
		<div class="experts-tools">
			<a id="alert" href="{'/popup/alert'|url}">
				<i class="fas fa-bell" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available."></i>
			</a>
			<i class="fas fa-play-circle" data-toggle="tooltip" data-html="true" title="Lessen <span class='kin-color-1'>{$voyant.name}</span> presentation"></i>
			<i class="fas fa-heart" data-toggle="tooltip" data-html="true" title="Add <span class='kin-color-1'>{$voyant.name}</span> to your fav list"></i>
		</div>
		<div class="experts-tools">
			<i class="fas fa-bell" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available."></i>
			<i class="fas fa-pause-circle" data-toggle="tooltip" data-html="true" title="Stop <span class='kin-color-1'>{$voyant.name}</span> presentation"></i>
			<i class="fas fa-heart infav-remove" data-toggle="tooltip" data-html="true" title="Remove <span class='kin-color-1'>{$voyant.name}</span> to your fav list"></i>
		</div>
		<div class="experts-flags">
			<img src="{'/uploads/images-flags/fr.png'|resurl}" data-toggle="tooltip" data-html="true" title="<span class='kin-color-1'>{$voyant.name}</span> talk french" />
			<img src="{'/uploads/images-flags/us.png'|resurl}" data-toggle="tooltip" data-html="true" title="<span class='kin-color-1'>{$voyant.name}</span> talk english" />
		</div>
		</div>

		<div class="voyantcontainermiddledetails">
	<div class="grid-3-small-1 man pan">
	<div class="man pbs txtratinglineheight">
	<span class="txtrating">Nombre de consultations</span><br />
	
	<span class="txtrating2">{if isset($voyant.countAnswer)} 
	 {$voyant.countAnswer}
	{else}0
	
	{/if}</span>
	</div>
	<div class="man pbs txtratinglineheight">
	<span class="txtrating">Note des consultants</span><br />
	<span class="txtrating2">{if $voyant.ratingAverage > 0}{$voyant.ratingAverage} / 5 sur {$statistic.voyantCommentValidatedCount} avis{else}n/a{/if}</span>
	</div>
	<div class="man pbs txtratinglineheight">
	<span class="txtrating">Avis & commentaires</span><br />
	<span class="txtrating2"><a href="{$voyant|objurl:'voyantComments'}" class="linkcheckavis">Consulter les avis</a></span>
	</div>
	</div>
	<div class="details-skills-list">
		Skill list : 
		{if $voyantSkills && $skillIds}
		 
			{foreach from=$voyantSkills item=skill}
			
					{if in_array($skill.skillId, $skillIds)}						   
                  		<a href="{"/skill/detail/".$skill.slug}">{$skill.name}</a>,	 					
					{/if}
			{/foreach}
		{/if}
	</div>
 <div class="details-expert-status">
		<input type="hidden" id="vid" value="{$voyant.voyantId}">
		<div class="row txtcenter">		
			<div class="col-sm-4">
			<!-- logged / webcam ON / expert is not in consultation -->
			{if $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
			{assign var="mUrl" value="/consultation/start/".$voyant.voyantId."/webcam"}
				<a id="startConsultation-webcam" href="{$mUrl|url}" class="status-wrapper webcam present typ" title="Webcam"></a>
				<div class="status-name">Webcam</div>

			<!-- logged / webcam ON / audio Off / waiting for consultation response -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
				
				<div class="status-wrapper webcam busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					{* depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span> *}
					</div>
				</div>
				<div class="status-name">Webcam</div>

			<!-- logged / webcam ON / In consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
				
				<div class="status-wrapper webcam busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					depuis <span class="status-display-time clock_{$voyant.voyantId}">
						<input type="hidden" class="cHour" value="{$voyant.consultationTime|date_format:'%H'}">
						<input type="hidden" class="cMin" value="{$voyant.consultationTime|date_format:'%M'}">
						<input type="hidden" class="cSec" value="{$voyant.consultationTime|date_format:'%S'}">
					</span>
					</div>
				</div>
				<div class="status-name">Webcam</div>	

			<!-- logged / webcam OFF / expert is offline -->	
			{elseif (($voyant.displayWebcam==0) || empty($voyant.displayWebcam)) && $voyant.consultationStatus=="OF"}
					<div class="status-wrapper webcam offline">
						<div class="status-display">
							<span class="status-display-text">indisponible</span><br>
						  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
							<span class="status-display-alert">M'alerter par email de son retour</span>
							</div>
						</div>
					<div class="status-name">Webcam</div>

				<!-- unlogged / webcam ON / expert is offline -->	
				{elseif $voyant.displayWebcam}
						<div class="status-wrapper webcam offline">
							<div class="status-display">
								<span class="status-display-text">indisponible</span><br>
							  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
								<span class="status-display-alert">M'alerter par email de son retour</span>
								</div>
							</div>
						<div class="status-name">Webcam</div>
			{else}
				<div class="status-wrapper webcam disable"></div>
				<div class="status-name">Webcam</div>
			{/if}
		</div>
	
		<div class="col-sm-4">
			<!-- logged / audio ON / expert is not in consultation -->
			{if $voyant.displayPhone && $voyant.consultationStatus=="ON"}
				{assign var="pUrl" value="/consultation/start/".$voyant.voyantId."/phone"}
				<a id="startConsultation-phone" href="{$pUrl|url}" class="status-wrapper phone present typ" title="Tél"></a>
				<div class="status-name">Tél</div>

			<!-- logged / webcam ON / audio off / expert is not in consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
				 <div class="status-wrapper phone offline">
						<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
					 Retour à <span class="status-display-back">{$voyant.consultationTime}</span><br>
						 <span class="status-display-alert">M'alerter par email de son retour</span>
						</div>
					</div>
					<div class="status-name">Tél</div>

			<!-- logged / audio on / waiting for consultation response -->			
			{elseif $voyant.displayPhone && $voyant.consultationStatus=="P"}	
					<div class="status-wrapper phone busy">
						<div class="status-display">
							<span class="status-display-text">En consultation</span><br>
							{* depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span> *}
						</div>
					</div>
					<div class="status-name">Tél</div>	

			  <!-- user loggedIn && Webcam on && audio off && waiting for consultation response -->
				{elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
				
				<div class="status-wrapper phone offline">
						<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
					  {*	Retour à <span class="status-display-back">19h00</span><br> *}
						{* <span class="status-display-alert">M'alerter par email de son retour</span> *}
						</div>
					</div>
					<div class="status-name">Tél</div>	

			<!-- logged / audio ON / In consultation -->	
			{elseif $voyant.displayPhone && $voyant.consultationStatus=="B"}
				
				<div class="status-wrapper phone busy">
					<div class="status-display">
					<span class="status-display-text">En consultation</span><br>
					depuis <span class="status-display-time clock_{$voyant.voyantId}">
						<input type="hidden" class="cHour" value="{$voyant.consultationTime|date_format:'%H'}">
						<input type="hidden" class="cMin" value="{$voyant.consultationTime|date_format:'%M'}">
						<input type="hidden" class="cSec" value="{$voyant.consultationTime|date_format:'%S'}">
					</span>
					</div>
				</div>
				<div class="status-name">Tél</div>
				
		  <!-- logged / webcam ON / audio off / In consultation -->	
			{elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
				<div class="status-wrapper phone offline">
					<div class="status-display">
						<span class="status-display-text">indisponible</span><br>
						depuis <span class="status-display-time clock_{$voyant.voyantId}">
							<input type="hidden" class="cHour" value="{$voyant.consultationTime|date_format:'%H'}">
							<input type="hidden" class="cMin" value="{$voyant.consultationTime|date_format:'%M'}">
							<input type="hidden" class="cSec" value="{$voyant.consultationTime|date_format:'%S'}">
						</span>
					</div>
				</div>
				<div class="status-name">Tél</div>

			<!-- logged / audio OFF / expert is offline -->	
			{elseif (($voyant.displayPhone==0) || empty($voyant.displayPhone)) && $voyant.consultationStatus=="OF"}
					<div class="status-wrapper phone offline">
						<div class="status-display">
							<span class="status-display-text">indisponible</span><br>
						  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
							<span class="status-display-alert">M'alerter par email de son retour</span>
						</div>
					</div>
					<div class="status-name">Tél</div>

				<!-- unlogged / audio ON / expert is offline -->	
				{elseif $voyant.displayPhone}
						<div class="status-wrapper phone offline">
							<div class="status-display">
								<span class="status-display-text">indisponible</span><br>
							  	Retour à <span class="status-display-back">{$nextTimeSlot}</span><br>
								<span class="status-display-alert">M'alerter par email de son retour</span>
								</div>
							</div>
						<div class="status-name">Tél</div>

				{else}
					<div class="status-wrapper phone disable"></div>
					<div class="status-name">Tél</div>
				{/if}
			</div>		

			<div class="col-sm-4">				
				{if $voyant.displayEmail}
					{assign var="eUrl" value="/".$voyant.urlName}
					<a href="{$eUrl|url}" class="status-wrapper email present" title="Email"></a>
					<div class="status-name">Email</div>
				{else}
					<div class="status-wrapper email disable"></div>
					<div class="status-name">Email</div>
				{/if}
			</div>		
		</div>

	{* <div class="row txtcenter">		
		<div class="col-sm-4">
			<div class="status-wrapper webcam busy">
				<div class="status-display">
				<span class="status-display-text">En consultation</span><br>
				depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span>
				</div>
			</div>
			<div class="status-name">Webcam</div>
		</div>
			
		<div class="col-sm-4">
			<div class="status-wrapper phone busy">
				<div class="status-display">
				<span class="status-display-text">En consultation</span><br>
				depuis <span class="status-display-time">00</span>:<span class="status-display-time">02</span>:<span class="status-display-time">45</span>
				</div>
			</div>
			<div class="status-name">Tél</div>
		</div>
	
		<div class="col-sm-4"></div>
	</div>

	<div class="row txtcenter">
	
		<div class="col-sm-4">
			<div class="status-wrapper webcam offline">
				<div class="status-display">
				<span class="status-display-text">indisponible</span><br>
				Retour à <span class="status-display-back">19h00</span><br>
				<span class="status-display-alert">M'alerter par email de son retour</span>
				</div>
			</div>
			<div class="status-name">Webcam</div>
		</div>
		
		<div class="col-sm-4">
			<div class="status-wrapper phone offline">
				<div class="status-display">
				<span class="status-display-text">indisponible</span><br>
				Retour à <span class="status-display-back">19h00</span><br>
				<span class="status-display-alert">M'alerter par email de son retour</span>
				</div>
			</div>
			<div class="status-name">Tél</div>
		</div>
	
	
		<div class="col-sm-4">
			<div class="status-wrapper email offline">
				<div class="status-display">
				<span class="status-display-text">indisponible</span><br>
				Retour à <span class="status-display-back">19h00</span><br>
				<span class="status-display-alert">M'alerter par email de son retour</span>
				</div>
			</div>
			<div class="status-name">Email</div>
		</div>	
	</div> *}

	</div>


	<div class="details-tab-menu">
	 	<ul class="nav details">
		  <li class="nav-item">
		    <a class="nav-link active" href="{$voyant|objurl:'voyantDetails'}">Profil</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="{$voyant|objurl:'voyantComments'}">Avis clients</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="{"/voyantPrivateMessage/contact/$voyant.voyantId"|url}">Envoyer un message prive</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="{$voyant|objurl:'voyantReport'}">Dénoncer un abus</a>
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
				<input id="textInput" type="search" name="filtervoaynt" placeholder="Search an Expert" aria-describedby="button-addon5" class="form-control live-search-box">
				<div class="input-group-append">
					<button id="button-addon5" type="submit" class="btn btn-primary mb-0"><i class="fa fa-search"></i></button>
				</div>
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
				<img src="{$allvoyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$allvoyant.title}" class="img-expert-small" />
				<div class="voyantName">
					{$allvoyant.name}  {if $allvoyant.ratingAverage > 0}{$allvoyant.ratingAverage} / 5 sur {$statistic.voyantCommentValidatedCount} avis{else}n/a{/if} <br>
					<span class="text-green">Disponible</span>
				</div>
				<div class="status-wrapper webcam present">
				</div>
			</div>
			
			{/foreach}
			</section>

		</div>
		{* END EXPERT LIST *}
	<h3 class="voyanth3">{'voyantDetails_hourly'|lang}</h3>
	<div>
	{$voyant.hourlyDescription|htmlspecialchars_decode}
	</div>

	<h3 class="voyanth3">{'voyantDetails_contact_possibilites'|lang}</h3>
	<div>
	{$voyant.contactDescription|htmlspecialchars_decode}
	</div>

	<h3 class="voyanth3">{'voyantDetails_support_divinatory'|lang}</h3>
	<div>
	{$voyant.supportDescription|htmlspecialchars_decode}
	</div>

	</div>
	
	</div>
</div>	







	<h1 class="voyanth1">Avis sur la voyante {$voyant.name} - Note : {if $voyant.ratingAverage > 0}{$voyant.ratingAverage} / 5{else}n/a{/if}</h1>

	{if $voyant.ratingAverage > 0}
	{else}
	<p>Aucun commentaire ajouté</p>
	{/if}

	{foreach from=$voyant.voyantComments item=comment}
	<div class="voyantcommentdesc {cycle values=',bckgv'}">
	<p>
		 
		  {if $comment.type=='W'}
<i class="fas fa-video"></i>
				 {elseif $comment.type=='Q'}
				   <i class="fas fa-envelope"></i> 
				   {elseif $comment.type=='P'}
				   <i class="fas fa-phone-alt"></i>
				    {elseif $comment.type=='E'}
				  <i class="fas fa-envelope"></i> 
				    {else} N/A
				 {/if}
				

		<span class="txtrating3">{$comment.user.name}</span><span class="txtrating4">, {'voyantComment_write_on'|lang} {$comment.date|date_format:"%d/%m/%Y"} -</span> <span class="txtrating3">{'voyantComment_rating'|lang}</span> <span class="txtrating2">{$comment.rating} / 5
		
         	{if $comment.rating==1}
		<span class="fa fa-star star-checked"></span>
 
	 
		 
	   {/if}

         	{if $comment.rating==2}
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
	 
		 
	   {/if}

			{if $comment.rating==3}
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		 
	   {/if}
		{if $comment.rating==4}
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
	   {/if}
	   {if $comment.rating==5}
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
		<span class="fa fa-star star-checked"></span>
	   {/if}

		</span>
	</p>
	<p>{$comment.text|nl2br}</p>
	{if $comment.replyText}
	<p>{'voyantComment_reply'|lang} {$voyant.name} :</p>
	<p><i>{$comment.replyText|nl2br}</i></p>
	{/if}
	</div>
	{/foreach}

	{include file="includes/pageNavigation.tpl"}

	</div>
	</div>

</div>
{include file="includes/footer.tpl"}