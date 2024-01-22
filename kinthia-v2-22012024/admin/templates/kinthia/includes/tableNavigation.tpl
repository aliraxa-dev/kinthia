{if !empty($pageNavigation.totalPages) && $pageNavigation.totalPages > 1}
<div class="card-tools">
	<ul class="pagination pagination-sm float-right">
		{math equation="x + 1" x=$pageNavigation.totalPages assign="stopLimit"}

		{for start=1 stop=$stopLimit step=1 value=page}

		{if $page == $pageNavigation.currentPage}
		<li class="page-item"><b><a class="page-link">{$page}</a></b></li>
		{else}
		{assign var="pageLink" value=$pageNavigation.baseLink|cat:$page}
		<li class="page-item"><a class="page-link" href="{$pageLink|url}">{$page}</a></li>
		{/if}

		{/for}
	</ul>
</div>
{/if}