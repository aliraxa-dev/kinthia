{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/main/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/main/displayTime.js'|resurl}"></script>
{/capture}
{capture assign="footerData"}
{/capture}

{if !empty($skill.title)}
	{assign var="pageTitle" value=$skill.title}
{else}
	{assign var="pageTitle" value=$skill.name}
{/if}

{if $skill.metaDescription}
	{assign var="metaDescription" value=$skill.metaDescription}
{/if}

{if $skill.metaRobots}
	{assign var="metaRobots" value=$skill.metaRobots}
{/if}

{include file="includes/header.tpl" title=$pageTitle}

<section id="search">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div id="breadcrumb">
					<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
					<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt; 
					{$skill.breadcrumb}
					{$skill.h1_tag}{$skill.breadcrumb}
				{$skill.longDescription}
				{$skill.longDescription2}
				{$skill.longDescription2|@var_dump}
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				{* -- START Search -- *}
				<div class="searchengine">
					<div class="row">
						<div class="col-md-6">
		                    <form action="" method="post">
								<div class="input-group">
					            	<input  name="expert" type="search" placeholder="Search an Expert" aria-describedby="button-addon5" class="form-control">
					            	<div class="input-group-append">
					            		<button id="button-addon5" type="submit" class="btn btn-primary mb-0"><i class="fa fa-search"></i></button>
					            	</div>
								</div>
							</form>
			          		<div id="collapseAdvancedSearch" class="searchengine-advanced-text">Recherche avancée</div>
						</div>
						<div class="col-md-6 text-center">
							Quel type de consultation préférez-vous ?
				        	<div class="form-group">
							{if $allconsultations}
								<div class="row">
								{foreach from=$allconsultations item=consultation} 
									<div class="col-md-2 custom-control custom-checkbox">
		          						<input onclick="getConsultation({$consultation.id});" class="custom-control-input filter-item category-filter-item " type="checkbox" id="consultation_data_{$consultation.id}" value="{$consultation.name}" data-cons="{$consultation.name}">
										<label for="consultation_data_{$consultation.id}" class="custom-control-label">{$consultation.name}</label>
		                        	</div>
								{/foreach}
								</div>
							{/if}
							</div>
							{if $session.user}
							<div class="form-group">
								<div class="custom-control custom-checkbox">
		                      	
									<input onclick="getFavorite({$userid});" class="custom-control-input filter-item category-filter-item " type="checkbox" id="favorite_data_{$userid}" value="Favorites" data-fav="Favorites">
									<label for="favorite_data_{$userid}" class="custom-control-label">Favorites</label>
		                        </div>
		                    </div>
		                    {/if}
						</div>
					</div>
				</div>
				<div id="collapseAdvancedSearchContainer" class="search-collapse">
		    	<div class="AdvancedSearchContainer">
		    	<h3>Filter by skills</h3>
			    {if $voyantSkills}			
					{foreach from=$voyantSkills item=skill}			
			        <div class="filter-container" id="skill_data_{$skill.skillId}" onclick="getSkill({$skill.skillId});" data-skill="{$skill.name}">
						<div  class="filter-item category-filter-item" data-skill="{$skill.name}" id="skill_{$skill.skillId}">
							<span>{$skill.name}</span> 
						</div>
					</div> 					
					{/foreach}
				{/if}	
				<h3 class="mt-5">Filter by Expert</h3>				 
				{foreach from=$expert item=exp}
					<div class="filter-container" id="expert_data_{$exp}" onclick="getExpert('{$exp}');" data-expert="{$exp}">
						<div  class="filter-item category-filter-item" data-expert="{$exp}" id="expert_{$exp}">
							<span>{$exp}</span> 
						</div>
					</div> 
				{/foreach}
				<h3 class="mt-5">Filter by languages</h3>
			    	{if $voyantlanguages}
						{foreach from=$voyantlanguages item=language}
							<div class="filter-container" id="language_data_{$language.languageId}"  onclick="getLanguage({$language.languageId});" data-language="{$language.language}">
								<div class="filter-item category-filter-item" data-lang="{$language.language}" id="language_{$language.languageId}">
									<span>{$language.language}</span> 
								</div>
							</div> 					
						{/foreach}
					 {/if}
				</div>
				</div>
				<div class="searchengine-filter">
					<div class="active-filter-text">
						Active filter:
					</div>			 		 
					<div id="activefiltersskill"></div> 
					<div id="activefilterslang"></div> 
					<div id="activefilterscons"></div> 
					<div id="activefiltersexperts"></div> 
					<div id="activefiltersfav"></div>
					<form action="{'/skill/ajaxpage'|url}" method="post" id="filterSkillFrm">  
					    <input type="hidden" name="filterSkillIds" id="filterSkillIds" value="">
					</form>
					<form action="{'/skill/ajaxpage1'|url}" method="post" id="filterLanguageFrm">  
					    <input type="hidden" name="filterLanguageIds" id="filterLanguageIds" value="">
					</form>
					<form action="{'/skill/ajaxpage2'|url}" method="post" id="filterConsultationFrm">  
					    <input type="hidden" name="filterConsultationIds" id="filterConsultationIds" value="">
					</form>
					<form action="{'/skill/ajaxpage3'|url}" method="post" id="filterExpertFrm">  
					    <input type="hidden" name="filterExpertValues" id="filterExpertValues" value="">
					</form>
					<form action="{'/skill/ajaxpage4'|url}" method="post" id="filterFavFrm">  
						<input type="hidden" name="filterFav" id="filterFav" value="">
					</form>	 
				 </div>
				<!-- </div>  
				</div> -->
				<form action="{'/skill/sortBy'|url}" method="post" id="sortFrm">  
					<input type="hidden" name="sortValues" id="sortValues" value="">
				</form>
					<div class="row">
						<div class="col-md-12 text-right"> Trier par : 
							<select name="sort" id="sort" class="" onchange="fetch_sort(this.value);">
								<option value="default">default</option>
								<option value="1">availability</option>
								<option value="bestRated">best rated</option>
								<option value="W">best rated webcam</option>
								<option value="P">best rated phone</option>
								<option value="E">best rated email</option>
							</select>
						</div>
					</div>
				<!--</div>-->
			{* -- END Search -- *}
			</div>
		</div>
	</div>
</section>

<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<div class="skill-description-above">
				<h1>{$skill.h1_tag}{$skill.breadcrumb} $h1_tag is do not displayed</h1>
				{$skill.longDescription} $longDescription is not displayed <br>
				{$skill.longDescription2} $longDescription2 is not displayed
				{$skill.longDescription2|@var_dump}
			</div>
		</div>
	</div>
</div>

<section id="expert-list">.
<div class="container" id="asdf">
	<div class="row">
	{foreach from=$voyants value=voyant}
			{if $filteredSkills && $voyant.skillIds}
			{assign var=val value=""}
				{foreach from=$filteredSkills item=skill key=fkey}
				{if in_array($skill.skillId, $voyant.skillIds) }
 					{if !$val}
  						{assign var=val value=$voyant.voyantId}	
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
							<div class="expert-stats-cons"><b>{$voyant.answeredCount}</b> consultations</div>
							<div class="expert-stats-avis"><b>{$statistic.voyantCommentValidatedCount}</b> avis</div>
						</div>
				</div>

				<div class="expert-image">
					{if isset($voyant.imageSrc)}
						<a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="expert-img" width="77px" height="99px" /></a>
					{else}
						<a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.firstGalleryImageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="expert-img" width="77px" height="99px" /></a>
					{/if}
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
					{/if}
				{/if}
			{/foreach}
		{/if}
	{/foreach}
	</div>

	<div class="row">
		<div class="col-lg-12">
			{include file="includes/pageNavigation.tpl"}
			<div class="text-center">
				<button id="button-addon5" type="submit" class="btn btn-violet">More Expert</button>
			</div>
		</div>
	</div>


</div>
</section>













{* -- START - DO NOT DISPLAY -- OLD VERSION OF SKILL PAGE --
<div class="padding-wrapper aftermenutop">
	<div id="breadcrumb">
	<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
	<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt; {'{$skill.breadcrumb}'|lang}
	</div>
	<div class="row">
		<div class="col-md-12">
		<div class="searchengine">
			<div class="row">
				<div class="col-md-6">
					<div class="input-group">
		            <input type="search" placeholder="Search an Expert" aria-describedby="button-addon5" class="form-control">
		            <div class="input-group-append">
		              <button id="button-addon5" type="submit" class="btn btn-primary mb-0"><i class="fa fa-search"></i></button>
		            </div>
	          		</div>
	          		<div class="searchengine-advanced-text" data-toggle="collapse" data-target="#collapseAdvancedSearch" aria-expanded="false" aria-controls="collapseAdvancedSearch">Recherche avancée</div>
				</div>
				<div class="col-md-6 text-center">
					Quel type de consultation préférez-vous ?
					<div class="form-group">
                        <div class="custom-control custom-checkbox">
                          <input class="custom-control-input" type="checkbox" id="customCheckbox1" value="option1">
                          <label for="customCheckbox1" class="custom-control-label">Webcam</label>
                        </div>
                        <div class="custom-control custom-checkbox">
                          <input class="custom-control-input" type="checkbox" id="customCheckbox2" value="option2">
                          <label for="customCheckbox2" class="custom-control-label">Phone</label>
                        </div>
                        <div class="custom-control custom-checkbox">
                          <input class="custom-control-input" type="checkbox" id="customCheckbox3" value="option3">
                          <label for="customCheckbox3" class="custom-control-label">Email</label>
                        </div>
                      </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox">
                      	{if $session.user}
                          <input class="custom-control-input" type="checkbox" id="customCheckbox4" value="option4">
                          <label for="customCheckbox4" class="custom-control-label">Favorites</label>
                          {/if}
                        </div>
                    </div>
				</div>
			</div>
		</div>
		<div class="collapse" id="collapseAdvancedSearch">
		    <div class="collapseAdvancedSearchContainer">
		    	<h3>Filter by skills</h3>
			    	<div class="category-filter-item">
						<span>Astrologues</span>
					</div>
					<div class="category-filter-item active">
						<span>Cartomanciens</span>
					</div>
					<div class="category-filter-item">
						<span>Astrologues</span>
					</div>
					<div class="category-filter-item">
						<span>Astrologues</span>
					</div>
					<div class="category-filter-item">
						<span>Astrologues</span>
					</div>
					<div class="category-filter-item">
						<span>Astrologues</span>
					</div>
					<div class="category-filter-item">
						<span>Astrologues</span>
					</div>
					<div class="category-filter-item">
						<span>Astrologues</span>
					</div>
				<h3 class="mt-5">Filter by Expert</h3>
			    	<div class="category-filter-item">
						<span>Nouveau</span>
					</div>
					<div class="category-filter-item active">
						<span>Femme</span>
					</div>
					<div class="category-filter-item">
						<span>Homme</span>
					</div>
				<h3 class="mt-5">Filter by languages</h3>
			    	<div class="category-filter-item">
						<span>Français</span>
					</div>
					<div class="category-filter-item active">
						<span>Anglais</span>
					</div>
					<div class="category-filter-item">
						<span>Italien</span>
					</div>
		    </div>
		</div>
		<div class="searchengine-filter">
			<div class="active-filter-text">
				Active filter:
			</div>
			
			{if $voyantSkills}			
						{foreach from=$voyantSkills item=skill}
									{if in_array($skill.skillId , $voyantSkil)}
				                  		<div class="filter-container" onclick="getSkill({$skill.skillId});">
											<div class="filter-item" id="skill_{$skill.skillId}">
												{$skill.name} 
											</div>										
										</div> 					
									{/if}
								 
						{/foreach}
					{/if}	

			 <form action="{'/skill/ajaxpage'|url}" method="post" id="filterSkillFrm">  
    		 	<input type="hidden" name="filterSkillIds" id="filterSkillIds" value="">
    		 </form>
		</div>

		</div>
	</div>
	<div class="row">
		<div class="col-md-12 text-right"> Trier par : 
			<select name="sort" id="sort" class="">
			<option value="defaut">defaut</option>
			<option value="availability">availability</option>
		    <option value="bestRated">best rated</option>
		    <option value="bestRatedWebcam">best rated webcam</option>
		    <option value="bestRatedPhone">best rated phone</option>
		    <option value="bestRatedEmail">best rated email</option>
		</select>
		</div>
	</div>
</div>
-- START - DO NOT DISPLAY -- *}


{include file="includes/footer.tpl"}