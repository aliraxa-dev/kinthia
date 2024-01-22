{capture assign="headData"}
<script type="text/javascript" src="{'/javascript/jquery/jquery.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/bootstrap/bootstrap.bundle.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript">
	var setting = new Array();
	 
    var pendingMsg = new Array();
    pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};
</script>
{/capture}

{include file="includes/header.tpl" title="{'managementIndex_title_html'|lang}" metaDescription="{'managementIndex_meta_description'|lang}"}

<section id="user-home">
<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div id="breadcrumb">
					<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
					<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
					<a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a>
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
				<h2 class="voyanth2">{'managementIndex_manage_my_account'|lang}</h2>
				&gt; <a href="{'/user/profile'|url}" class="linkusermanage">{'managementIndex_change_personnal_info'|lang}</a><br />
				{'managementIndex_email_first_name'|lang}<br />
				&gt; <a href="{'/user/profile'|url}" class="linkusermanage">{'managementIndex_change_pass'|lang}</a><br>
				&gt; <a href="{'/user/profile/photo'|url}" class="linkusermanage">{'photo'|lang}</a>

				<!--
				<h2 class="voyanth2">{'managementIndex_manage_photos'|lang}</h2>
				&gt; <a href="{'/user/profile/photo'|url}" class="linkusermanage">{'managementIndex_add_delete_photos'|lang}</a><br />
				{'managementIndex_photos_more_info'|lang}
				-->

				<h2 class="voyanth2">{'managementIndex_order_tracking'|lang}</h2>
				&gt; <a href="{'/user/order'|url}" class="linkusermanage">{'managementIndex_see_order_tracking'|lang}</a><br />
				{'managementIndex_order_tracking_more_info'|lang}

				<h2 class="voyanth2">{'managementIndex_payment_methods'|lang}</h2>
				{'managementIndex_security_shopping'|lang}<br />
				&gt; <a href="{'/user/order/refund'|url}" class="linkusermanage">{'managementIndex_reimbursed'|lang}</a>
			</div>
		</div>
	</div>
</section>

{include file="includes/footer.tpl"}