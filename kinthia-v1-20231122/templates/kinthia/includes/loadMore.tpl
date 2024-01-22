{if !empty($pageNavigation.totalPages) && $pageNavigation.totalPages > 1}
<div id="column_in_pagination">
{assign var="visiblePageRadius" value=5}
{math equation="max(1, x - r)" r=$visiblePageRadius x=$pageNavigation.currentPage assign="startLimit"}
{math equation="min(x + r*2, y) + 1" r=$visiblePageRadius x=$startLimit y=$pageNavigation.totalPages assign="stopLimit"}
{math equation="x - 1" x=$pageNavigation.currentPage assign="previousPage"}
{math equation="x + 1" x=$pageNavigation.currentPage assign="nextPage"}

  
 

{if $pageNavigation.currentPage < $pageNavigation.totalPages}
{assign var="pageLink" value=$pageNavigation.baseLink|cat:$nextPage}       
<a href="{$pageLink|url}"{if !empty($pageNavigation.title)} title="{$pageNavigation.title} - {'page'|lang} {$nextPage}"{/if}> 
 <div class="text-center">
 <button id="load-more-btn" onclick="loadMoreBtn('{$pageLink|url}')" type="submit" class="btn btn-violet">More Expert</button>
 </div>
</a>
{/if}   
 
</div>
{/if}