<div class="row">
{foreach from=$voyantDetails value=voyant key=mkey}

	{include file="voyant/list.tpl"}

{/foreach}
</div>
{include file="includes/ajaxsearch.tpl"}