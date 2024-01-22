{include file="includes/header.tpl" title="{'cartConfirmation_html_title'|lang}" metaDescription="{'cartConfirmation_meta_description'|lang}"}

<div class="padding-wrapper aftermenutop">
<div id="breadcrumb">
	<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
	<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
	{'cartConfirmation_arbo'|lang}
</div>


<!--
{include file="includes/profileBox.tpl"}
-->

{include file="cart/includes/steps.tpl" step=3}

	<h1 class="voyanth1" style="margin-left: 30px;">Paiement en cours de validation</h1>
	{if isset($latestOrderStatus) && $latestOrderStatus eq 'paid'}
	    <h1 class="voyanth1">Empty the basket, <span class="badge rounded badge-print-light" style="background-color: #01b887; color: white;">Payment accepted</span></h1>
	{elseif isset($latestOrderStatus) && $latestOrderStatus eq 'unpaid'}
	    <h1 class="voyanth1">Keep the basket,  <span class="badge rounded badge-print-light" style="background-color: #FF8C00; color: black;">Payment Un Paid</span></h1>
	{elseif isset($latestOrderStatus) && $latestOrderStatus eq 'denied'}
	    <h1 class="voyanth1">Keep the basket,  <span class="badge rounded badge-print-light" style="background-color: #E74C3C; color: white;">Payment Cancelled</span></h1>
	{elseif isset($latestOrderStatus) && $latestOrderStatus eq 'pending'}
	    <h1 class="voyanth1">Keep the basket,  <span class="badge rounded badge-print-light" style="background-color: #E74C3B; color: white;">Payment Pending</span></h1>
	{else}
	{/if}

<p style="margin-left: 30px;">
	{'cartConfirmation_desc'|lang}<br />
	{'cartConfirmation_desc0'|lang}<br /><br />
	{'cartConfirmation_desc1'|lang}<br /><br />
	{'cartConfirmation_desc2'|lang}<br />
	{'cartConfirmation_desc3'|lang}<br /><br />
	{'cartConfirmation_desc4'|lang}
</p>
</div>

{include file="includes/footer.tpl"}

