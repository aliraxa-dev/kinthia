<div class="row">
{foreach from=$voyants value=voyant key=mkey}
{if $filteredCons && $voyant.consultationIds}
{assign var=val value=""}

	{foreach from=$filteredCons item=consultation key=fkey}
		{if in_array($consultation.id, $voyant.consultationIds) }
			{if !$val}

				{assign var=val value=$voyant.voyantId}
				{include file="voyant/listAjax.tpl"}		  

			{/if}
		{/if}
	{/foreach}

{/if} 
{/foreach}
</div>
{include file="includes/ajaxsearch.tpl"}