{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript">
    var pendingMsg = new Array();
    pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};
</script>
{/capture}

{include file="includes/header.tpl" title="{'orderIndex_title_html'|lang}" metaDescription="{'orderIndex_meta_description'|lang}"}

<section id="user-photo">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div id="breadcrumb">
                    <a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
					<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
					<a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
					<a href="{'/user/order'|url}">{'orderIndex_arbo'|lang}</a>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                {include file="includes/profileMenu.tpl"}
            </div>
        </div>

<div class="row">
            <div class="col-lg-12">
                <table class="tablemanage table table-sm table-bordered table-responsive-md">
					<thead class="small-hidden tiny-hidden">
						<tr>
							<th>{'Invoice N°'|lang}</th>
							<th>{'orderIndex_purchase_date'|lang}</th>
							<th>{'Item'|lang}</th>
							<th>{'Price'|lang}</th>
							<th>{'Invoice'|lang}</th>
						</tr>
					</thead>

					<tbody>

					{if $orders}
					{foreach from=$orders item=order key=key}
					<tr class="line{cycle values='1,2'}">
						<td class="td_left">{$order.invoiceId}</td>
						<td class="td_left">{$order.purchaseDate|date_format:"%d/%m/%Y"}</td>
						<td class="td_left">
							{foreach from=$order.orderItems item=orderItem}
								{if $orderItem.itemId}
									{$orderItem.title}<br/>
								{else if orderItem.packid}
									{$orderItem.packageName}<br/>
								{/if}
							{/foreach}
						</td>
						<td class="td_left">{$order.amount}</td>
						<td class="td_left">
							<a href="{"/user/order/details/$order.orderId"|url}" title="{'orderIndex_comment_rating_title'|lang} $order.voyant.name">{'see'|lang}</a>
						</td>
					</tr>
					{/foreach}
					{/if}

					</tbody>
				</table>
            </div>
        </div>
    </div>
</section>

{include file="includes/footer.tpl"}