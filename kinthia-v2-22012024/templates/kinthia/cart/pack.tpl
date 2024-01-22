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
{/capture}

{include file="includes/header.tpl" title="{'cartCheckout_html_title'|lang}" metaDescription="{'cartCheckout_meta_description'|lang}"}

<section id="pack-to-sold">
{include file="cart/includes/steps.tpl" step=1}

<div class="container">
<div class="row">
	{foreach from=$packages item=package}
		<div class="col-lg-12 mb-4" >
			<div  {if $package.packagePromo==1} class="package-container-promo" {else} class="package-container" {/if}>
				{if $package.packagePromo==1} 
				<div class="voyantdetailsitemcaddie" style="float: right;">
					<img src="{'/templates/kinthia/images/timepackpromo.png'|resurl}" />
				</div>
				{/if}
				<p>{$package.packageName}</p>
				<p>{$package.packageTime} Minute</p>
				<p>{$package.packageDescription|htmlspecialchars_decode}</p>
				<p>{$package.packagePrice}€ &nbsp; &nbsp;{if $package.packageBarredPrice} <strike>{$package.packageBarredPrice}€ </strike> {/if}</p>
				<div class="voyantdetailsitemcaddie">
				
				<button class="btn btn-kin-orange w-100 fsize-16 mt-1" onclick="goli('{$package.packageId}');">Ajouter au panier</button>
				</div>
			</div>
		</div>
	{/foreach}
</div>


<div id="breadcrumb">
<a href="https://www.kinthia.com/" class="link_showarbo">{'show_arbo_voyance'|lang}</a> &gt; 
<a href="{'/'|url}" class="link_showarbo">{'show_arbo_tirage'|lang}</a> &gt; 
<a href="{'/cart/checkout'|url}" class="link_showarbo">{'cartCheckout_arbo'|lang}</a>
</div>

</div>
</section>

{include file="includes/footer.tpl"}