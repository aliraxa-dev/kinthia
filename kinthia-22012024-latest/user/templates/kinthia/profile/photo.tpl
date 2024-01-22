{capture assign="headData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<link href="{'/templates/kinthia/css/upload.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery.livequery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.fileUploader.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.photoEditor.js'|resurl}"></script>
<!-- <script type="text/javascript" src="{'/user/javascript/profile/photoOnLoad.js'|resurl}"></script> -->
<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript">
setting.item = {$itemJson|htmlspecialchars_decode};
 var pendingMsg = new Array();
 pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};

</script>
{/capture}

{include file="includes/header.tpl" title="{'photoIndex_title_html'|lang}" metaDescription="{'photoIndex_meta_description'|lang}"}

<section id="user-photo">
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12">
	        	<div id="breadcrumb">
					<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
					<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
					<a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
					<a href="{'/user/profile/photo'|url}">{'photoIndex_arbo'|lang}</a>
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
                <div class="login-container">
					<h1 class="voyanth1">{'photoIndex_h1'|lang}</h1>
					<div class="grid-2-small-1 man mbs pan">
					<div class="titleform small-hidden tiny-hidden">&nbsp;</div>
					<div class="infos">{'photoIndex_desc'|lang}</div>
					</div>

					<div class="grid-2-small-1 man mbs pan">
					<div class="titleform">{'photoIndex_add_photo'|lang} </div>
					<div class="infos"><div id="fileUploadPanel" class="fileUploader"></div></div>
					</div>
				</div>
            </div>
        </div>
	</div>
</section>

{include file="includes/footer.tpl"}