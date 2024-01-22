<div class="row">
{foreach from=$voyants value=voyant key=mkey}
{if $filteredLangs && $voyant.languageIds} 
{assign var=val value=""}

	{foreach from=$filteredLangs item=language key=fkey}
		{if in_array($language.languageId, $voyant.languageIds) }
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