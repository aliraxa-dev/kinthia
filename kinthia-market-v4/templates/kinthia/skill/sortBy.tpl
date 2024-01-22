<div class="row">
{if isset($sortObjFromVoyant)}
	{foreach from=$sortObjFromVoyant value=voyant key=mkey}

		{include file="voyant/list.tpl"}

	{/foreach}
 	{include file="includes/ajaxsearch.tpl"}
 {/if}


 {if isset($sortObjFromVoyantBest)}
 	{foreach from=$sortObjFromVoyantBest value=voyant key=mkey}

 		{include file="voyant/list.tpl"}
 
 	{/foreach}
 	{include file="includes/ajaxsearch.tpl"}
 {/if}
 

{if isset($voyantDetails)}
	{foreach from=$voyantDetails value=voyant key=mkey}

 		{include file="voyant/list.tpl"}

 	{/foreach}
 	{include file="includes/ajaxsearch.tpl"}
{/if}


{if isset($voyantDetailsPhone)}
	{foreach from=$voyantDetailsPhone value=voyant key=mkey}

 		{include file="voyant/list.tpl"}

	{/foreach}
 	{include file="includes/ajaxsearch.tpl"}
{/if}


{if isset($voyantDetailsEmail)}
    {foreach from=$voyantDetailsEmail value=voyant key=mkey}

 		{include file="voyant/list.tpl"}

	{/foreach}
	{include file="includes/ajaxsearch.tpl"}
 {/if}
</div>