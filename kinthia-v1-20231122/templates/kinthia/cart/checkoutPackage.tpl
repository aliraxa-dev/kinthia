{capture assign="headData"}
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
{/capture}

{include file="includes/header.tpl" title="{'cartCheckout_html_title'|lang}" metaDescription="{'cartCheckout_meta_description'|lang}"}

<div class="padding-wrapper aftermenutop">
<div id="breadcrumb">
<a href="https://www.kinthia.com/" class="link_showarbo">{'show_arbo_voyance'|lang}</a> &gt; 
<a href="{'/'|url}" class="link_showarbo">{'show_arbo_tirage'|lang}</a> &gt; 
<a href="{'/cart/checkout'|url}" class="link_showarbo">{'cartCheckout_arbo'|lang}</a>
</div>
</div>
<!--
{include file="includes/profileBox.tpl"}
-->
<div class="padding-wrapper-2">
{include file="cart/includes/steps.tpl" step=1}

{foreach from=$cart.baskets item=basket}
<form action="{"/cart/paymentDetails/$basket.package.packageId"|url}" method="post">
<table class="tablepayment">
<thead>
<tr>
<th class="paiementfirst">{'cartCheckout_table_item'|lang} {* {$basket.package.name} *}</th>
<th class="paiementcenter">{'cartCheckout_quantity'|lang}</th>
<th class="paiementcenter">{'cartCheckout_price'|lang}</th>
<th class="paiementcenter">{'cartCheckout_delete'|lang}</th>
</tr>
</thead>

<tbody>

{foreach from=$basket.items item=item}
<tr class="line{cycle values='1,2'}">
<td class="td_left"> <p class="voyantpaiementtitle">{$item.name}</p></td>
<td class="td_center"><span class="paiementquantity">Quantité : </span>{$item.quantity}</td>
<td class="td_center"><span class="pricepayment">{$item.totalPrice} {'euro_symbole'|lang}</span></td>
<td class="td_center"><a href="{"/cart/deleteItem/$item.cartItemId"|url}" class="linkdelete">{'cartCheckout_delete'|lang}</a></td>
</tr>
{/foreach}

</tbody>
</table>

<table class="tablepaymenttotal">
<thead>
<tr>
<th class="paiement">{'cartCheckout_caddies_total'|lang}</th>
<th class="none"></th>
</tr>
</thead>
<tbody>
<tr class="line1">
<td class="td_right">{'cartCheckout_total_price'|lang}</td>
<td class="td_price">{$basket.totalPrice} {'euro_symbole'|lang}</td>
</tr>
<tr class="line_button">
<td class="td_button"><a href="{'/'|url}" class="link_showarbo"><img src="{'/templates/kinthia/images/continue_achats.png'|resurl}" alt="" class="" /></a></td>
<td class="td_button"><input type="image" src="{'/templates/kinthia/images/valider_panier.png'|resurl}" alt="" class="" /></td>
</tr>
</tbody>
</table>
</form>
<div class="clear"> </div>

{/foreach}
</div>

{include file="includes/footer.tpl"}