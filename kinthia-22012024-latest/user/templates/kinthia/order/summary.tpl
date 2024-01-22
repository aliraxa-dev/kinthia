{include file="includes/header.tpl" title="{'orderSummary_title_html'|lang} $order.orderId" metaDescription="{'orderSummary_meta_description'|lang} $order.orderId"}

<section id="user-photo">
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12">
				<div id="breadcrumb">
					<a href="https://www.kinthia.com/" class="link_showarbo">{'show_arbo_voyance'|lang}</a> &gt;
					<a href="{'/'|url}" class="link_showarbo">{'show_arbo_tirage'|lang}</a> &gt;
					<a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
					<a href="{"/user/order/summary/$order.orderId"|url}" class="link_showarbo">{'orderSummary_arbo'|lang} {$order.orderId}</a>
				</div>
			</div>
		</div>

		<div class="row">
            <div class="col-lg-12">
                {include file="includes/profileMenu.tpl"}
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="kin-container">
				{foreach from=$order.userQuestions item=userQuestion}
					{if $userQuestion.summary}
						<h1 class="voyanth1">{'orderSummary_h1'|lang} {$userQuestion.voyantQuestion.title}</h1>
						{$userQuestion.summary|htmlspecialchars_decode}
					{/if}
				{/foreach}
				</div>
            </div>
        </div>

	</div>
</section>

{include file="includes/footer.tpl"}