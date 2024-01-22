{if $action!="pack"}
	{if isset($allPromoPackages) && !empty($allPromoPackages)}
	<section class="top-bar">
		<div class="promo">
  		{foreach from=$allPromoPackages item=package}
  			<div id="packagesName" style="background: red;color: #fff;text-align: center; ">
  				{$package}
  			</div>
  		{/foreach}
  		</div>
	</section>
	{/if}
{/if}
