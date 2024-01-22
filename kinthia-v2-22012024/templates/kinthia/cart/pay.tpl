<!doctype html>
<html class="no-js" lang="fr">
<head>
    <meta charset="UTF-8">
    <title>{'cartPay_html_title'|lang}</title>
    <link href="{'/templates/kinthia/css/style_paid_redirect.css'|resurl}" rel="stylesheet" type="text/css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    {literal}<!--[if lt IE 9]>
    <style>
        /* #### - css for IE8 and under - also copy the css for the desktop menu here for IE7/8 compatibility #### */
        /* copy and paste desktop menu css here */
        #menu .toggle-sub {
            display: none
        }

        /* hide arrows (no rotate in IE7/8) */
        #menu ul ul .toggle-sub {
            display: inline-block
        }

        /* reinstate right arrows on subs */
        #menu ul li a {
            padding-right: 1.5em
        }

        /* remove extra space previously reserved for down arrows */
    </style>
    <![endif]-->{/literal}
</head>
<body onload="document.getElementById('paymentForm').submit();">
<form action="{$paymentDetails.actionUrl}" method="post" id="paymentForm">
    <input type="hidden" name="charset" value="utf-8">
    {foreach from=$paymentDetails.formFields key=formFieldName value=formFieldValue}
        <input type="hidden" name="{$formFieldName}" value="{$formFieldValue}"/>
    {/foreach}
</form>

<div id="wrapper">
    <div id="inner">
        <img src="{'/templates/kinthia/images/kinthia-logo3.png'|resurl}" alt="" class=""/><br/><br/>
        <span class="txt1">{'cartPay_html_desc'|lang}</span><br/>
        <span class="txt2">{'cartPay_html_desc0'|lang}</span><br/><br/>
        <img src="{'/templates/kinthia/images/loader.gif'|resurl}" alt="" class="loader"/>
    </div>
</div>
<script>
    {literal}
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
        a = s.createElement(o),
            m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-1365604-1', 'auto');
    ga('send', 'pageview');
    ga('require', 'ecommerce');

    ga('ecommerce:addTransaction', {
        'id': '{/literal}{$paymentDetails.formFields.custom}{literal}',                     // Transaction ID. Required.
        'revenue': '{/literal}{$cart.totalPrice}{literal}',               // Grand Total.
    });

    {/literal}
    {foreach from=$cart.baskets item=basket}
    {foreach from=$basket.items item=item}
    {literal}
    ga('ecommerce:addItem', {
        'id': '{/literal}{$paymentDetails.formFields.custom}{literal}',                     // Transaction ID. Required.
        'name': '{/literal}{$item.name}{literal}',    // Product name. Required.
        'price': '{/literal}{$item.totalPrice}{literal}',                 // Unit price.
        'quantity': '{/literal}{$item.quantity}{literal}'                   // Quantity.
    });
    {/literal}
    {/foreach}
    {/foreach}
    {literal}
    ga('ecommerce:send');
    {/literal}
</script>


{include file="includes/footerTransaction.tpl"}
