<div class="row">
{foreach from=$voyants value=voyant key=mkey}
{if $filteredSkills && $voyant.skillIds}
{assign var=val value=""}

	{foreach from=$filteredSkills item=skill key=fkey}
		{if in_array($skill.skillId, $voyant.skillIds) }
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