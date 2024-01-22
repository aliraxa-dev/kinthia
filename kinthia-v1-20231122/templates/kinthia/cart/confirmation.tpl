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

	<h1 class="voyanth1">Paiement en cours de validation</h1>
<p>
	{'cartConfirmation_desc'|lang}<br />
	{'cartConfirmation_desc0'|lang}<br /><br />
	{'cartConfirmation_desc1'|lang}<br /><br />
	{'cartConfirmation_desc2'|lang}<br />
	{'cartConfirmation_desc3'|lang}<br /><br />
	{'cartConfirmation_desc4'|lang}
</p>
</div>

{include file="includes/footer.tpl"}