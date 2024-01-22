<div class="row">
{foreach from=$filtersFromUserFav value=voyant}

	{include file="voyant/list.tpl"}

{/foreach}
</div>
{include file="includes/ajaxsearch.tpl"}