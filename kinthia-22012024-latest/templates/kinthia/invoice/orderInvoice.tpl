<!doctype html>
<html class="no-js" lang="fr">
<head>
<meta charset="UTF-8">
<title>Facture N° /KIN/{$invoice.invoiceId}</title>
<link href="{'/templates/kinthia/css/invoice.css'|resurl}" rel="stylesheet" type="text/css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
{literal}<!--[if lt IE 9]>
<style>
/* #### - css for IE8 and under - also copy the css for the desktop menu here for IE7/8 compatibility #### */
/* copy and paste desktop menu css here */
#menu .toggle-sub { display:none } /* hide arrows (no rotate in IE7/8) */
#menu ul ul .toggle-sub { display:inline-block } /* reinstate right arrows on subs */
#menu ul li a { padding-right:1.5em } /* remove extra space previously reserved for down arrows */
</style> 
<![endif]-->{/literal}
</head>
<body>
<div id="principal">

<div class="grid-2-small-2 man pan">
<div class="topleft">
<b>Identification de l'entrepreneur</b><br /><br />
{if $invoice.voyant.displayNameOnInvoice}
{$invoice.voyant.name}<br/>
{/if}
{if $invoice.voyant.displayFirstNameOnInvoice}
Prénom : {$invoice.voyant.firstName}<br />
{/if}
{if $invoice.voyant.displayLastNameOnInvoice}
Nom : {$invoice.voyant.lastName}<br />
{/if}
Adresse : {$invoice.voyant.address} {$invoice.voyant.zipCode} {$invoice.voyant.city}<br />
SIREN : {$invoice.voyant.companyTaxNumber}
</div>

<div class="topright">
<b>Client</b><br /><br />
{if $invoice.user.firstName && $invoice.user.lastName}
Prénom : {$invoice.user.firstName}<br />
Nom : {$invoice.user.lastName}<br />
{else}
Pseudo : {$invoice.user.name}<br />
{/if}
</div>
</div>


<div class="grid-2-small-2 man pan">
<div class="topleft1">
Dispensé d’immatriculation au registre du commerce et des sociétés (RCS) et au répertoire<br /> des métiers (RM)
</div>

<div class="topright1">
Date : {$invoice.purchaseDate|date:"d/m/Y"}<br />
Facture N° /KIN/{$invoice.invoiceId}<br />
Mode de règlement : PayPal
</div>
</div>


<div class="padding-wrapper">

<table id="table_invoice" cellspacing="0">
<thead>
<tr>
<th class="left">Produits</th>
<th class="right">Quantité</th>
<th class="right">Prix {if $invoice.voyant.displayTvaOnInvoice}HT{/if}</th>
</tr>
</thead>

<tbody>

{foreach from=$invoice.orderItems item=orderItem}
<tr>
<td class="item ">
{$orderItem.quantity} {$orderItem.voyantQuestion.title}
</td>
<td class="right">
1
</td>
<td class="right">
{if $invoice.voyant.displayTvaOnInvoice}
{math equation="x - x * y / 100" x=$orderItem.totalPrice y=$invoice.voyant.tva format="%.2f"} EUR
{else}
{$orderItem.totalPrice} EUR
{/if}
</td>
</tr>
{/foreach}

<tr>
<td class="none">&nbsp;

</td>
<td class="none">&nbsp;

</td>
<td class="none">&nbsp;

</td>
</tr>

{if $invoice.voyant.displayTvaOnInvoice}
<tr>
<td class="price_none">
</td>
<td class="price">
<b>Prix total HT</b>
</td>
<td class="price_right">
{math equation="x - x * y / 100" x=$invoice.amount y=$invoice.voyant.tva format="%.2f"} EUR
</td>
</tr>

<tr>
<td class="price_none">
</td>
<td class="price">
<b>TVA ({$invoice.voyant.tva} %)</b>
</td>
<td class="price_right">
{math equation="x * y / 100" x=$invoice.amount y=$invoice.voyant.tva format="%.2f" assign="taxAmount"}
{$taxAmount} EUR
</td>
</tr>
{/if}


<tr>
<td class="price_none">
</td>
<td class="price">
<b>Prix global en euros</b><br />
{if $invoice.voyant.displayTvaOnInvoice}
<b>Prix total TTC</b>
{else}
TVA non applicable, art. 293 B du CGI
{/if}
</td>
<td class="price_right">
{$invoice.amount} EUR
</td>
</tr>

</tbody>
</table>



<div id="bottom">
<div class="column_bottom">
{$invoice.voyant.firstName} {$invoice.voyant.lastName}<br />
{$invoice.voyant.address} {$invoice.voyant.zipCode} {$invoice.voyant.city}<br />
SIREN {$invoice.voyant.companyTaxNumber}
</div>
</div>

</div>

</div>
</body>
</html> 