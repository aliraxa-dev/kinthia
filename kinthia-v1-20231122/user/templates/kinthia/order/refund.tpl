{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/refundValidate.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript">
    var pendingMsg = new Array();
    pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};
</script>
{/capture}

{include file="includes/header.tpl" title="{'orderRefund_title_html'|lang}" title="{'orderRefund_meta_description'|lang}"}

<div class="padding-wrapper aftermenutop">
<div id="breadcrumb">
<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
<a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
<a href="{'/user/order/refund'|url}">{'orderRefund_arbo'|lang}</a>
</div>

<!--
{include file="includes/profileBox.tpl"}
-->

{include file="includes/profileMenu.tpl"}


<form action="{'/user/order/sendRefundEmail'|url}" method="post" id="refundForm">

<fieldset class="fieldset pas">
<h1 class="voyanth1">{'orderRefund_h1'|lang}</h1>

<div class="grid-2-small-1 man mbs pan">
<div class="titleform small-hidden tiny-hidden">&nbsp;</div>
<div class="infos">{'orderRefund_h1'|lang}</div>
</div>

<div class="grid-2-small-1 man mbs pan form">
<div class="titleform">{'orderRefund_order_paiement'|lang}</div>
<div class="infos">
<select name="orderId">
<option value="">{'orderRefund_select_order_paiement'|lang}</option>
{foreach from=$orders item=order}
<option value="{$order.orderId}">{$order.orderId}</option>
{/foreach}
</select>
</div>
</div>

<div class="grid-2-small-1 man mbs pan form">
<div class="titleform">{'orderRefund_message'|lang} <span class="textmandatory">*</span></div>
<div class="infos"><textarea class="textarea_large" name="text" cols="50" rows="5" id="categoryDescription"></textarea></div>
</div>

<div class="grid-2-small-1 man mbs pan">
<div class="titleform small-hidden tiny-hidden">&nbsp;</div>
<div class="infos"><input type="submit" class="btn purple" value="{'orderRefund_button_send'|lang}" /></div>
</div>

</fieldset>

</form>




</div>
{include file="includes/footer.tpl"}