{capture assign="headData"}
	<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="{'/javascript/config'|resurl}"></script>
	<!-- <script type="text/javascript" src="{'/javascript/bootstrap/bootstrap.bundle.min.js'|resurl}"></script> -->
	<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/main/indexOnLoad.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/main/displayTime.js'|resurl}"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
{/capture}

{capture assign="footerData"}
    <script type="text/javascript">
        var voyantIdsArr = new Array();
        voyantIdsArr.voyantIdArr = {$voyantIdArr|htmlspecialchars_decode};
    </script>
{/capture}
	
{* {if $pageNavigation.currentPage > 1}
    {assign var="pageTitle" value="{'mainIndex_html_title'|lang} - {'page'|lang} $pageNavigation.currentPage"}
    {assign var="metaDescription" value="{'mainIndex_meta_description'|lang} - {'page'|lang} $pageNavigation.currentPage"}
{else} *}
    {assign var="pageTitle" value=$setting.siteTitle}
    {assign var="metaDescription" value=$setting.siteDescription}
{* {/if} *}
	
{include file="includes/header.tpl" title=$pageTitle}
{* -- BEGIN SEARCH SECTION -- *}
<section id="search">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <!-- SEARCH PANEL -->
                <div class="searchengine">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="input-group">
                                <input id="inputvoyantName" name="expert" type="search" placeholder="Search an Expert (Min 3 Char)" aria-describedby="button-addon5" class="form-control">
                                <div class="input-group-append">
                                    <button id="button-addon5" class="btn btn-primary mb-0" onclick="filterByInput()">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div id="collapseAdvancedSearch" class="searchengine-advanced-text btn btn-secondary py-1 mt-2">Recherche avancée</div>
                        </div>
                        <div class="col-md-6 text-center">
                            Quel type de consultation préférez-vous ?
                            {if $consultations}
                                <div class="row consult-options">
                                {foreach from=$consultations item=consultation}
                                    <div class="col-md-2 custom-control custom-checkbox">
                                        <input onclick="getConsultOption({$consultation.id})" class="custom-control-input filter-item category-filter-item" type="checkbox" id="consultation_data_{$consultation.id}" value="{$consultation.name}" data-cons="{$consultation.name}">
                                        <label for="consultation_data_{$consultation.id}" class="custom-control-label">{$consultation.name}</label>
                                    </div>
                                {/foreach}
                                {if $session.user}
                                    <div class="col-md-2 custom-control custom-checkbox">
                                        <input onclick="getFavorite({$userid});" class="custom-control-input filter-item category-filter-item " type="checkbox" id="favorite_data_{$userid}" value="Favorites" data-fav="Favorites">
                                        <label for="favorite_data_{$userid}" class="custom-control-label">Favorites</label>
                                    </div>
                                {/if}
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
                <!-- SEARCH PANEL END -->

                <!-- FILTER PANEL -->
                <div id="collapseAdvancedSearchContainer" class="search-collapse">
                    <div class="AdvancedSearchContainer">
                        <h3>Filter By Skills</h3>
                        {if $voyantSkills}			
                            {foreach from=$voyantSkills item=skill}		
                                <div class="filter-container" id="skill_data_{$skill.skillId}" onclick="getSkill({$skill.skillId});" data-skill="{$skill.name}">
                                    <div  class="filter-item category-filter-item" data-skill="{$skill.name}" id="skill_{$skill.skillId}">
                                        <span>{$skill.name}</span> 
                                    </div>
                                </div> 					
                            {/foreach}
                        {/if}

                        <h3 class="mt-5">Filter By Expert</h3>
                        {foreach from=$experts item=exp}
                            <div class="filter-container" id="expert_data_{$exp}" onclick="getExpert('{$exp}');" data-expert="{$exp}">
                                <div class="filter-item category-filter-item" data-expert="{$exp}" id="expert_{$exp}">
                                    <span>{$exp}</span>
                                </div>
                            </div>
                        {/foreach}

                        <h3 class="mt-5">Filter By Languages</h3>
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
                <!-- FILTER PANEL END -->

                <!-- ACTIVE FILTER PANEL -->
                <div class="searchengine-filter" style="display: none">   
                    <div class="active-filter-text">
                        Active filter:
                    </div>
                    <div class="active-filter-items"></div>
                    <form action="{'/main/expertlist/1'|url}" method="post" id="filterSkillFrm">
                        <input type="hidden" name="filterSkillIds" id="filterSkillIds" value="">
                    </form>
                    <form action="{'/main/expertlist/1'|url}" method="post" id="filterLanguageFrm">
						<input type="hidden" name="filterLanguageIds" id="filterLanguageIds" value="">
					</form>
                    <form action="{'/main/expertlist/1'|url}" method="post" id="filterConsultationFrm">
						<input type="hidden" name="filterConsultationIds" id="filterConsultationIds" value="">
					</form>
                    <form action="{'/main/expertlist/1'|url}" method="post" id="filterExpertFrm">
						<input type="hidden" name="filterExpertValues" id="filterExpertValues" value="">
					</form>
                    <form action="{'/main/expertlist/1'|url}" method="post" id="filterFavFrm">
						<input type="hidden" name="filterFav" id="filterFav" value="">
					</form>
                    <button class="btn filter-reset" onclick="removeAllFilters()"></button>
                </div>
                <!-- ACTIVE FILTER PANEL END -->

                <!-- SORT EXPERTS PANEL -->
                <div class="expert-sort-wrapper">
                    <form action="{'/main/expertlist'|url}" method="post" id="sortFrm">
                        <input type="hidden" name="sortValues" id="sortValues" value="">
                    </form>
                    <div class="expert-sort-panel"> 
                        <span class="expert-sort-title">Trier par : </span>
                        <select class="form-control" aria-colcount="sort" id="sort" onchange="fetch_sort(this.value);">
                            <option value="default">default</option>
                            <option value="1">availability</option>
                            <option value="bestRated">best rated</option>
                            <option value="W">best rated webcam</option>
                            <option value="P">best rated phone</option>
                            <option value="E">best rated email</option>
                            <option value="C">best rated chat</option>
                        </select>
                    </div>
                </div>
                <!-- SORT EXPERTS PANEL END -->
            </div>
        </div>
    </div>
</section>
{* -- END SEARCH SECTION -- *}

{* -- BEGIN EXPERT LIST SECTION -- *}
<section id="expert-list">
    <div class="container mb-5 expert-list-container" id="expert-list-container" >
        {* -- Call expert.tpl file -- *}
        {include file="/main/expertlist.tpl"}
{*        <div class="col-lg-12 list-loader">*}
{*            <img src="{'/templates/kinthia/images/loader.gif'|resurl}">*}
{*        </div>*}
    </div>
    <div class="container mb-5" id="sort-expert-list-container" >

    </div>
</section>
{* -- END EXPERT LIST SECTION -- *}

{* -- BEGIN DESCRIPTION SECTION -- *}
<section id="main-description"></section>
{* -- END DESCRIPTION SECTION -- *}
{include file="includes/footer.tpl"}