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
                <div class="mb-3">
                    <a href="{'/user/order/mail'|url}" class="btn btn-primary">Consultation par email ({$session.user.ordersCount})</a>
                    <a href="{'/user/order/phone'|url}" class="btn btn-primary">Consultation par téléphone ({$phoneCount})</a>
                    <a href="{'/user/order/webcam'|url}" class="btn btn-primary">Consultation par webcam ({$webcamCount})</a>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <table class="tablemanage table table-sm table-bordered table-responsive-md">
                    <thead class="small-hidden tiny-hidden">
                        <tr>
                            <th>{'orderIndex_order_number'|lang}</th>
                            <th>{'orderIndex_purchase_date'|lang}</th>
                            <th>{'orderIndex_items'|lang}</th>
                            <th>{'orderIndex_quantity'|lang}</th>
                            <th>{'orderIndex_status'|lang}</th>
                            <th>{'orderIndex_questions'|lang}</th>
                            <th>{'orderIndex_voyant'|lang}</th>
                            <th>{'orderIndex_see_summary'|lang}</th>
                            <th>{'orderIndex_rating_comment'|lang}</th>
                            <th>{'orderIndex_see_invoice'|lang}</th>
                            <th>{'Private message'|lang}</th>
                        </tr>
                    </thead>

                <tbody>
                {foreach from=$orders value=order}
                <tr class="tableline{cycle values='1,2'}">
                <td class="td_left">{$order.orderId}</td>
                <td class="td_left">{$order.purchaseDate|date_format:"%d/%m/%Y"}</td>
                <td class="td_left">

                {assign var=itemVal value=""}
                {foreach from=$order.orderItems item=orderItem}
                    {if $orderItem.itemId}
                        {if $itemVal != $orderItem.itemId}
                            {$orderItem.title} <br/><br/>
                            {assign var=itemVal value=$orderItem.itemId}
                        {/if}
                    {/if}
                {/foreach}
                </td>
                <td class="td_left">
                {assign var=itemQtyVal value=""}
                {assign var=itemQty value=""}
                {foreach from=$order.orderItems item=orderItem}
                    {if $itemQtyVal != $orderItem.itemId}
                        {$orderItem.quantity} <br/><br/>
                         {assign var=itemQtyVal value=$orderItem.itemId}
                         {assign var=itemQty value=$orderItem.itemId}
                    {else}
                         {assign var=itemQtyVal value=$orderItem.itemId}
                    {/if}
                {/foreach}
                </td>
                <td class="td_left">
                {switch from=$order.status}
                {case value="pending"}
                {'orderIndex_pending'|lang}
                {case value="unpaid"}
                {'orderIndex_unpaid'|lang}
                {case value="paid"}
                {'orderIndex_paid'|lang}
                {/switch}</td>
                <td class="td_left">
                {if $order.status == "paid"}
                    {if !empty($order.userQuestions)}{'orderIndex_pending'|lang} {$order.userQuestions|@count}
                    {else}
                    {'orderIndex_answered'|lang}
                    {/if}
                {else}
                    -
                {/if}
                </td>
                <td class="td_left">{$order.voyant.name}</td>

                {if $order.status == "paid"}

                    <td class="td_left">
                     {assign var=itemVal value=""}
                	 {foreach from=$order.orderItems item=orderItem}
                        {if $orderItem.itemId}
                            {if $itemVal != $orderItem.itemId}
                                <a href="{"/user/order/summary/$order.orderId/$orderItem.itemId"|url}" class="link_panel_grey_underline">{'orderIndex_see'|lang}</a><br/><br/>
                                 {assign var=itemVal value=$orderItem.itemId}
                            {/if}
                        {/if}
                        {/foreach}
                    </td>

                <td class="td_left">
                    {assign var=itemVal value=""}
                	{foreach from=$order.orderItems item=orderItem}
                        {if $orderItem.itemId}
                         {if $itemVal != $orderItem.itemId}
                            <a href="{"/user/comment/popup/$orderItem.itemId/$order.orderId/Q"|url}" class="link_panel_grey_underline dialog" title="{'orderIndex_comment_rating_title'|lang} {$orderItem.title}">{'orderIndex_comment_rating'|lang}</a>
                            <br/>
                            <br/>
                             {assign var=itemVal value=$orderItem.itemId}
                        {/if}
                        {/if}
                    {/foreach}
                    
                	<!-- <a href="{"/user/comment/popup/$order.orderId"|url}" class="link_panel_grey_underline dialog" title="{'orderIndex_comment_rating_title'|lang} {$order.voyant.name}">{'orderIndex_comment_rating'|lang}</a> --></td>
                <td class="td_left"><a href="{"/invoice/orderInvoice/$order.orderId"|url}" class="link_panel_grey_underline">{'orderIndex_see'|lang}</a></td>
                {else}
                    <td class="td_left">-</td>
                    <td class="td_left">-</td>
                    <td class="td_left">-</td>
                {/if}
                <td class="td_left"><a href="{'/user/privateMessage/details/'.$order.voyantId}" class="link_panel_grey_underline" title="{'orderIndex_contact_voyant_title'|lang} {$order.voyant.name}">{'Sent / See'|lang}</a>
                </td>

                <!--
                <td class="td_left"><a href="{"/contact/contactPopup/$order.voyantId"|url}" class="link_panel_grey_underline dialog" title="{'orderIndex_contact_voyant_title'|lang} {$order.voyant.name}">{'orderIndex_contact_voyant'|lang}</a>
                </td>
                -->
                </tr>
                {/foreach}
                </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
{include file="includes/footer.tpl"}