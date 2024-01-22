<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{'language'|lang}" lang="{'language'|lang}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="noindex, nofollow" />
<script type="text/javascript" src="{'/javascript/cart/addPack.js'|resurl}"></script>
</head>

<div class="grid-1 man pan">
<h3 class="voyanth3 w100 man pan">{'cartAddItem_title'|lang}</h3>
</div>


<div class="grid-3-small-3 man pae">
	{* <div class="voyantpopupadditemimage">
	<img src="{$voyantQuestion.imageSrc|realImgSrc:'voyantQuestion'}" alt="" class="imagecarte">
	</div> *}

	<div class="voyantpopupadditemdesc">
	<strong>{$timePackage.packageName}</strong>
	<p class="txtquantity"><strong>{$timePackage.packageTime} Minute</strong></p>
	{$timePackage.packageDescription|htmlspecialchars_decode}
	<p class="txtquantity">{'cartAddItem_quantity'|lang} 1 </p>
	</div>
	<div class="voyantpopupadditemprice">
	<span class="price">{$timePackage.packagePrice} {'euro_symbole'|lang}</span>
	</div>
</div>

<div class="grid-2-small-1 man pan">
	<div class="voyantpopupadditemcontinue">
	<img src="{'/templates/kinthia/images/continue.png'|resurl}" alt="" class="cart_add_item_continue cursorpointer">
	</div>
	<div class="voyantpopupadditemcaddie">
	<img src="{'/templates/kinthia/images/go_to_basket.png'|resurl}" alt="" class="cart_add_pack_checkout cursorpointer">
	</div>

</div>








    

