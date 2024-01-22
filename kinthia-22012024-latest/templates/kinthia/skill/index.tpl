{capture assign="headData"}
<script type="text/javascript" src="{'/javascript/jquery/jquery.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/bootstrap/bootstrap.bundle.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/main/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
 
 


{/capture}
{capture assign="footerData"}
<script type="text/javascript">
  var voyantIdsArr = new Array();
  voyantIdsArr.voyantIdArr = {$voyantIdArr|htmlspecialchars_decode};
 </script>
{/capture}

{include file="includes/header.tpl" title="{'voyantComment_html_title'|lang}" metaDescription="{'voyantComment_meta_description'|lang}  {'voyantComment_meta_description1'|lang}"}

<div class="padding-wrapper aftermenutop">
	<div id="breadcrumb">
	<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
	<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt; {'voyantSkill_arbo'|lang}
	</div>
	<div class="row">
		<div class="col-md-12">
		<div class="searchengine">
			<div class="row">
				<div class="col-md-6">
					  <form action="/skill" method="post">
					<div class="input-group">
		            <input  name="expert" type="search" placeholder="Search an Expert" aria-describedby="button-addon5" class="form-control">
		            <div class="input-group-append">
		              <button id="button-addon5" type="submit" class="btn btn-primary mb-0"><i class="fa fa-search"></i></button>
		            </div>
					</div>
					</form>
	          		<div class="searchengine-advanced-text" data-toggle="collapse" data-target="#collapseAdvancedSearch" aria-expanded="false" aria-controls="collapseAdvancedSearch">Recherche avancée</div>
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
                    <div class="form-group">
                      <div class="custom-control custom-checkbox">
                      	{if $session.user}
                   

						<input onclick="getFavorite({$userid});" class="custom-control-input filter-item category-filter-item " type="checkbox" id="favorite_data_{$userid}" value="Favorites" data-fav="Favorites">
                          <label for="favorite_data_{$userid}" class="custom-control-label">Favorites</label>

                          {/if}
                        </div>
                    </div>
				</div>
			</div>
		</div>
		<div class="collapse" id="collapseAdvancedSearch">
		    <div class="collapseAdvancedSearchContainer">
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
				     { if $voyantlanguages}
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
		</div>
	</div>
	   

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
</div>

<div class="grid-2-small-1 man pae" id="asdf">
	{foreach from=$voyants value=voyant}
		{if $voyantSkills && $voyant.skillIds}
			<div class="voyantcontainer pas" id="infav1_{$voyant.voyantId}">
				<h2 class="voyanth2">{$voyant.headerDescription}</h2>
				 
 {if $voyant.ratingAverage==0.00}
 <span style="">N/a</span>

 {/if}

  {if $voyant.ratingAverage==1.00}
  <span class="fa fa-star star-checked"></span>
 
  
  	{/if}
  {if $voyant.ratingAverage==2.00}
  <span class="fa fa-star star-checked"></span>
  <span class="fa fa-star star-checked"></span>
  
  	{/if}
  
  {if $voyant.ratingAverage==3.00}
  <span class="fa fa-star star-checked"></span>
  <span class="fa fa-star star-checked"></span>
  <span class="fa fa-star star-checked"></span>
  	{/if}
	  {if $voyant.ratingAverage==4.00}
  <span class="fa fa-star star-checked"></span>
  <span class="fa fa-star star-checked"></span>
  <span class="fa fa-star star-checked"></span>
    <span class="fa fa-star star-checked"></span>
  	{/if}

  {if $voyant.ratingAverage==5.00}
  <span class="fa fa-star star-checked"></span>
  <span class="fa fa-star star-checked"></span>
  <span class="fa fa-star star-checked"></span>
    <span class="fa fa-star star-checked"></span>
	<span class="fa fa-star star-checked"></span>
  	{/if}



				<div class="grid-2-small-1 man pan">
					<div class="voyantimageindex">
						<a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="imagevoyant" /></a>
						 {if $session.user}
						 
								{if in_array($voyant.voyantId, $userFav)}	
								<a href="#infav1_{$voyant.voyantId}" onclick="userFav({$voyant.voyantId},{$userid})" >
			                  		 					<i id="infav_{$voyant.voyantId}" class="fas fa-heart infav" data-toggle="tooltip" data-html="true" title="Expert dans mes favoris"></i></a>					   
								{else}	
								<a href="#infav1_{$voyant.voyantId}" id="infav_{$voyant.voyantId}" onclick="userFav({$voyant.voyantId},{$userid})" ><i  class="fas fa-heart userfav" data-toggle="tooltip" data-html="true" title="Make favoris "></i></a>
								{/if}
					 
						 {else}
						   <a href="#" onclick="getLogin()"><i class="fas fa-heart withoutfav" data-toggle="tooltip" data-html="true" title="Please Login"></i></a>
					{/if} 
						<form action="{'/user/Fav/save'|url}" method="post" id="voyantFrm">  
							<input type="hidden" name="voyantId" id="voyantId" value="">
							<input type="hidden" name="userId" id="userId" value="">
						</form>
						<form action="{'/skill/sortBy'|url}" method="post" id="sortFrm">  
							<input type="hidden" name="sortValues" id="sortValues" value="">
							 
						</form>
						<!--  
							<div class="experts-tools">
								<i class="fas fa-bell" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available."></i>
								<i class="fas fa-play-circle" data-toggle="tooltip" data-html="true" title="Lessen <span class='kin-color-1'>{$voyant.name}</span> presentation"></i>
								<i class="fas fa-heart" data-toggle="tooltip" data-html="true" title="Add <span class='kin-color-1'>{$voyant.name}</span> to your fav list"></i>
							</div>
							<div class="experts-tools">
								<i class="fas fa-bell" data-toggle="tooltip" data-html="true" title="Send an email when<br><span class='kin-color-1'>{$voyant.name}</span> is available."></i>
								<i class="fas fa-pause-circle" data-toggle="tooltip" data-html="true" title="Stop <span class='kin-color-1'>{$voyant.name}</span> presentation"></i>
								<i class="fas fa-heart infav-remove" data-toggle="tooltip" data-html="true" title="Remove <span class='kin-color-1'>{$voyant.name}</span> to your fav list"></i>
							</div>
						-->
						<div class="experts-flags">
							{* <img src="{'/uploads/images-flags/fr.png'|resurl}" data-toggle="tooltip" data-html="true" title="<span class='kin-color-1'>{$voyant.name}</span> talk french" />
							<img src="{'/uploads/images-flags/us.png'|resurl}" data-toggle="tooltip" data-html="true" title="<span class='kin-color-1'>{$voyant.name}</span> talk english" /> *}
							{if $voyantlanguages && $voyant.languageIds}
								{foreach from=$voyantlanguages item=lang key=mkey}
									{if in_array($lang.languageId, $voyant.languageIds)}						   
										<img src="{$lang.languageFlag|realImgSrc:'language'}" data-toggle="tooltip" data-html="true" title="<span class='kin-color-1'>{$voyant.name}</span> talk {$lang.language}" style="width: 28px"/> 					
									{/if}
								{/foreach}
							{/if}
						</div>
					</div>
					<div class="voyantcontainerdesc">
						<div class="grid-2-small-1 man pan">
							<div class="man pbs txtratinglineheight">
								<span class="txtrating">Nombre de consultations</span><br />
								<span class="txtrating2">{$voyant.answeredCount}</span>
							</div>
							<div class="man pbs txtratinglineheight">
								<span class="txtrating">Note des consultants</span><br />
								<span class="txtrating2">{if $voyant.ratingAverage > 0}{$voyant.ratingAverage} sur {$statistic.voyantCommentValidatedCount} avis{else}n/a{/if}</span>
							</div>
						</div>
						{$voyant.shortDescription|htmlspecialchars_decode}<br><br>
						<div class="index-skills-list">
							Skill list : 
							{if $voyantSkills && $voyant.skillIds}
								{foreach from=$voyantSkills item=skill}
										{if in_array($skill.skillId, $voyant.skillIds)}						   
											<a href="{'/abvoyance/skill/skill-two'|url}">{$skill.name}</a>,						
										{/if}
								{/foreach}
							{/if}
						</div>
					</div>
				</div>
				<!--
					<div class="column_in_box_voyant_contact">
					{$voyant.contactDescription|htmlspecialchars_decode}
					</div>
				-->
		
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
					{* {$voyant.consultationTime|date_format:'%H:%M:%S'} *} 
					<input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
					<input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
					<input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
					
					</span>
					</div>
				</div>
				<div class="status-name">Webcam</div>	

			<!-- logged / webcam OFF / expert is offline -->	
			{elseif (($voyant.displayWebcam==0) || empty($voyant.displayWebcam)) && $voyant.consultationStatus=="OF"}
					<div class="status-wrapper webcam offline">
						<div class="status-display">
							<span class="status-display-text">indisponible</span><br>
						  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
							<span class="status-display-alert">M'alerter par email de son retour</span>
							</div>
						</div>
					<div class="status-name">Webcam</div>

				<!-- unlogged / webcam ON / expert is offline -->	
				{elseif $voyant.displayWebcam}
						<div class="status-wrapper webcam offline">
							<div class="status-display">
								<span class="status-display-text">indisponible</span><br>
							  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
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
					<input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
					<input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
					<input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
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
					<input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
					<input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
					<input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
					</span>
					</div>
				</div>
				<div class="status-name">Tél</div>

			<!-- logged / audio OFF / expert is offline -->	
			{elseif (($voyant.displayPhone==0) || empty($voyant.displayPhone)) && $voyant.consultationStatus=="OF"}
					<div class="status-wrapper phone offline">
						<div class="status-display">
							<span class="status-display-text">indisponible</span><br>
						  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
							<span class="status-display-alert">M'alerter par email de son retour</span>
							</div>
					</div>
					<div class="status-name">Tél</div>

				<!-- unlogged / audio ON / expert is offline -->	
				{elseif $voyant.displayPhone}
						<div class="status-wrapper phone offline">
							<div class="status-display">
								<span class="status-display-text">indisponible</span><br>
							  	Retour à <span class="status-display-back">{$voyant.nextTimeSlot}</span><br>
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
				{* {assign var="eUrl" value="/consultation/start/".$voyant.voyantId."/email"} *}
				{assign var="eUrl" value="/".$voyant.urlName}
				<a href="{$eUrl|url}" class="status-wrapper email present" title="Email"></a>
				<div class="status-name">Email</div>
			{else}
				<div class="status-wrapper email disable"></div>
				<div class="status-name">Email</div>
			{/if}
		</div>	
	</div>

		
		{/if}

		</div>
		
	{/foreach}
 
	
   <!--{include file="includes/loadMore.tpl"} -->
    <!--{include file="includes/pageNavigation.tpl"}-->
   
</div>
<div class="grid-2-small-1 voyantcontainer1">

</div>
 

 

 	{if isset($nextPage)}
<input type="hidden" value="{$pageNavigation.baseLink|cat:$nextPage}" data-next-link>
 <input type="hidden"  value="{$pageNavigation.totalPages}" data-all-pages>
 <input type="hidden"  value="{$pageNavigation.currentPage}" data-this-page>
 <input type="hidden"  value="https://preprod.kinthia.com/skill/" data-coll-url>
 <div class="load-more_wrap text-center">
 <button id="loadData1" class="btn js-load-more btn btn-violet">
 <span load-more-text>More Expert</span>
 <span class="hide" loader>
 
 </span>
 </button>
 </div>
 {/if}
 


<div class="padding-wrapper">
<h1 class="voyanth1">Consultation de voyance & tirage des cartes avec des voyantes passionnées</h1>
<!--
{include file="includes/profileBox.tpl"}
-->
<p>Nous sommes issues d’une famille très ouverte spirituellement parlant, nous baignons dans l’ésotérisme depuis 3 générations.<br />
Nous sommes donc habituées à parler d’ésotérisme et à pratiquer les tirages.</p>
<p>C’est <u>une histoire de famille et de transmission de savoirs</u>. Rouge Pivoine est ma maman, et je suis donc fatalement sa fille.<br />
Mon grand-père avait des talents de magnétiseur, ma grand-mère est intuitive, mes oncles et tantes pratiquent également.<br />
Je suis la seule de ma génération a avoir repris de façon durable le flambeau.</p>

<h2 class="voyanth2">Depuis 2006, des réponses à des milliers de questions</h2>
<p>Le site Kinthia.com est né le 4 septembre 2006.<br />
Nous proposons depuis presque <strong>10 ans nos services de voyance</strong>  en direct et de tirages de tarots et cartes en ligne et ce de façon gratuite et payante.<br />
Nous avons traité plus de <strong><u>350 questions par mois</u></strong>, soit environ <strong><u>42 000 questions en 10 ans</u></strong>.</p>

<ul>
<li><a href="https://forum.kinthia.com/fruit-des-voyances-f69.html" class="linklist">Vous pouvez consulter ici les retours que nous avons eus par les utilisateurs qui nous ont fait confiance</a>.</li>
<li><a href="https://www.kinthia.com/livre-dor/guestbook.php" class="linklist">Vous pouvez consulter ici le livre d’or du site</a>.</li>
</ul>
<p><strong>Vous êtes donc bien en mesure de juger notre travail et ses résultats</strong>.</p>

<p>Nous continuons de proposer des consultations de voyance gratuites (très limité), tout en mettant à votre disposition des consultations de voyance par téléphone, Skype ou par email (traités en priorité), plus complets, où nous réalisons nous-mêmes vos voyances.
Nous mettons en œuvre ce que nous pouvons et savons faire pour votre satisfaction.</p>

<p>Nous ne nous considérons pas comme « voyante-médium », nous transmettons uniquement les messages que nous recevons et interprétons les tirages.<br />
Sans les supports divinatoires nous ne sommes rien.</p>

<p>Nous nous sentons à l’aise dans cet univers et espérons que nous réussissons à vous transmettre notre passion.<br />
Chaque jour, nous nous enrichissons de lectures, d’expériences, d’exercices pour agrandir nos connaissances ésotériques et spirituelles.<br />
Le fait d’être officiellement reconnues pour notre travail n’est à notre sens que la suite logique de notre parcours ésotérique.</p>

<p>Comme chaque personne, nous souhaitons vivre de notre passion. Nous fourmillons de projets à long terme et espérons que ceux-ci vous permettront d’en apprendre toujours davantage dans ce domaine encore trop mal perçu.</p>
<p>Nous souhaitons poursuivre avec vous notre aventure étoilée.</p>

<p>Ici, la voyance en direct et le tirage des tarots en ligne est une histoire de passion.<br />
Nous respecterons votre vie privée et votre confiance.<br />
Nous nous engageons à vous transmettre les réponses à vos questions, dans la sincérité la plus grande.</p>

<h2 class="voyanth2">Faites comme les plus de 5500 membres qui nous ont fait confiance</h2>
<p>Nous souhaitons également faire un clin d’œil spécial pour toutes les personnes qui nous soutiennent depuis le début de la création du forum, et qui nous apportent fidélité, et témoignage de leur affection.<br /> 
Ces personnes se reconnaîtront.</p>

<p><span class="text_sign">Rouge Pivoine & Kinthia</span></p>
</div>



{include file="includes/footer.tpl"}