{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>

<script type="text/javascript">
    var pendingMsg = new Array();
    pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};
</script>
{/capture}

{include file="includes/header.tpl" title="{'orderIndex_title_html'|lang}" metaDescription="{'orderIndex_meta_description'|lang}"}

<section id="user-photo">
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12">
	        	<div id="breadcrumb">
					<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
					<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
					<a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
					<a href="{'/user/order'|url}">{'orderIndex_arbo'|lang}</a>
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
                <div class="mb-3">
					<a href="{'/user/order/mail'|url}" class="btn btn-primary">Consultation par email ({$session.user.ordersCount})</a>
					<a href="{'/user/order/phone'|url}" class="btn btn-primary">Consultation par téléphone ({$phoneCount})</a>
					<a href="{'/user/order/webcam'|url}" class="btn btn-primary">Consultation par webcam ({$webcamCount})</a>
				</div>
            </div>
        </div>

	</div>
</section>

{include file="includes/footer.tpl"}