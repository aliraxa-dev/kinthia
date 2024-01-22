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
                    <a href="{'/user/order/chat'|url}" class="btn btn-primary">Consultation par chat ({$chatCount})</a>
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
                           <!-- <th>{'orderIndex_see_invoice'|lang}</th> -->
                            <th>{'Private message'|lang}</th>
                        </tr>
                    </thead>

                <tbody>
                    {foreach from=$orders item=order}
                        <tr>
                            <td>{$order.orderId}</td>
                            <td>{$order.purchaseDate|date_format:"%d/%m/%Y"}</td>
                            <td>
                                {foreach from=$order.orderItems item=orderItem}
                                    {$orderItem.title}<br><br>
                                {/foreach}
                            </td>
                            <td>
                                {foreach from=$order.orderItems item=orderItem}
                                    {$orderItem.quantity}<br><br>
                                {/foreach}
                            </td>
                            <td>
                                {foreach from=$order.orderItems item=orderItem}
                                    {$order.status}<br><br>
                                {/foreach}
                            </td>
                            <td>
                                {foreach from=$order.userQuestions item=question}
                                    {if $question|@count > 0}
                                        {$question.status}<br><br>
                                    {else}
                                        - <br><br>
                                    {/if}
                                {/foreach}
                            </td>
                            <td>
                                {foreach from=$order.orderItems item=orderItem}
                                    {$orderItem.name}<br><br>
                                {/foreach}
                            </td>
                            <td>
                                {if $order.status == "paid"}
                                    {foreach from=$order.userQuestions item=question}
                                        <a href="{"/user/order/summary/$order.orderId/$question.questionId"|url}" class="link_panel_grey_underline">{'orderIndex_see'|lang}</a><br/><br>
                                    {/foreach}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td>
                                {if $order.status == "paid"}
                                    {foreach from=$order.userQuestions item=question}
                                        <a href="{"/user/comment/popup/$question.questionId/$order.orderId/Q"|url}" class="link_panel_grey_underline dialog" title="{'orderIndex_comment_rating_title'|lang} {$orderItem.title}">{'orderIndex_comment_rating'|lang}</a><br><br>
                                    {/foreach}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td>
                                {foreach from=$order.orderItems item=orderItem}
                                    <a href="{'/user/privateMessage/details/'.$orderItem.voyantId}">Sent / See</a><br><br>
                                {/foreach}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
{include file="includes/footer.tpl"}
