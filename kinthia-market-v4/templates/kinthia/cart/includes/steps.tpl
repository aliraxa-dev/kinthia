<div class="container my-3">
	<div class="row text-center">
		<div class="col {if $step == 1}font-weight-bold{else}{/if}">
			{if $step == 1}
				<img src="{'/templates/kinthia/images/1_on.png'|resurl}" alt="" /><br />
			{else}
				<img src="{'/templates/kinthia/images/1_off.png'|resurl}" alt="" /><br />  
			{/if}
				{'cartSteps_caddies'|lang}
		</div>
		<div class="col {if $step == 2}font-weight-bold{else}{/if}">
			{if $step == 2}
				<img src="{'/templates/kinthia/images/2_on.png'|resurl}" alt="" /><br />
			{else}
				<img src="{'/templates/kinthia/images/2_off.png'|resurl}" alt="" /><br />  
			{/if}
				{'cartSteps_payment'|lang}
		</div>
		<div class="col {if $step == 3}font-weight-bold{else}{/if}">
			{if $step == 3}
				<img src="{'/templates/kinthia/images/3_on.png'|resurl}" alt="" /><br />
			{else}
				<img src="{'/templates/kinthia/images/3_off.png'|resurl}" alt="" /><br />  
			{/if}
				{'cartSteps_confirmation'|lang}
		</div>
	</div>
</div>