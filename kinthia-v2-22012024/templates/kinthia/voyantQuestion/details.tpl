{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/voyant/detailsOnLoad.js'|resurl}"></script>
<script>
setting.questionPrices = {$questionPrices|htmlspecialchars_decode};
</script>
{/capture}

{assign var="title" value=$voyantQuestion.metaTitle|default:$voyantQuestion.title}
{assign var="metaDescription" value=$voyantQuestion.metaDescription|default:$title}

{include file="includes/header.tpl" title=$title}
<div class="padding-wrapper aftermenutop">
<div id="breadcrumb">
<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
<a href="{$voyantQuestion.voyant|objurl:'voyantDetails'}">{$voyantQuestion.voyant.navigationName|default:$voyantQuestion.voyant.name}</a> &gt;
<a href="{$voyantQuestion|objurl:'voyantQuestionDetails'}">{$voyantQuestion.navigationName|default:$voyantQuestion.title}</a>
</div>
<!--
{include file="includes/profileBox.tpl"}
-->
<div class="voyantcontainerdetails pas">
<h1 class="voyanth1">{$voyantQuestion.headerDescription}</h1>
<div class="grid-3-small-2 man mbm">

<div class="voyantquestiondetailsitemimage">
<img src="{$voyantQuestion.imageSrc|realImgSrc:'voyantQuestion'}" alt="{$voyantQuestion.metaDescription|default:$title}" class="imagecarte" />
</div>

<div class="voyantquestiondetailsitemdesc">
{$voyantQuestion.longDescription|htmlspecialchars_decode}
</div>


<!--
<div>
{'voyantQuestionDetails_quantity'|lang}
<select name="priceId">
<option value="">1 = {$voyantQuestion.price}{'euro_symbole'|lang}</option>
{foreach from=$voyantQuestion.voyantQuestionPrices item=voyantQuestionPrice}
{math equation="100 - (100 * t / (x * q))" x=$voyantQuestion.price t=$voyantQuestionPrice.price q=$voyantQuestionPrice.quantity assign="pricePercentageDiscount"}
<option value="{$voyantQuestionPrice.priceId}">{$voyantQuestionPrice.quantity} = {$voyantQuestionPrice.price}{'euro_symbole'|lang}{if $pricePercentageDiscount} - {'voyantQuestionDetails_you win'|lang} {$pricePercentageDiscount|round}%{/if}</option>
{/foreach}
</select>
</div>
-->
{if $voyantQuestion.voyant.displayEmail}
<div class="voyantquestiondetailsitemprice">
<input type="hidden" name="questionId" value="{$voyantQuestion.questionId}">
<p class="price">{$voyantQuestion.price} {'euro_symbole'|lang}</p>
<img src="{'/templates/kinthia/images/caddie.png'|resurl}" alt="" class="image_caddie_question_detail" />
</div>
{/if}

</div>

<div class="grid-1">
	<div class="w100 man pan">
	
	</div>
</div>

</div>

{include file="includes/footer.tpl"}
