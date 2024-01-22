{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
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

<section id="user-fav1" class="mb-3">
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

				<div class="kin-container">
				{foreach from=$userAlert item=userAlert }
					<div class="row">
						<div class="col-md-4 voyantimageindex">
							<h2 class="expert-h2"><a id="" href="">{$userAlert.name}</a></h2><br>
							<a href="$voyant|objurl:'voyantDetails'">
							<img class="expert-img" style="width:77px; height: 99px" src="{$userAlert.imageSrc|realImgSrc:'voyant':'small'}" alt="{$userAlert.headerDescription}" class="imagevoyant" /></a>
						</div>

						<div class="col-md-4">
							Type : {$userAlert.consname}<br> 
							Horaires :  {$userAlert.timeslots|date_format:"%I:%M %p"}  <br>
							Jours :  {$userAlert.schedule_date|date_format:"%A"}<br>
							Validité : 30 jours 
						</div>
						<div class="col-md-4">
							<button type="submit" class="btn btn-kin1">Extend</button>
							<a  onclick="return confirm('Do you really want to delete it?')" href="{"/user/alert/deleteAlert/$userAlert.id"|url}"><button type="submit" class="btn btn-danger" >Delete</button></a>
						</div>
					</div>
				{/foreach}
				</div>

			</div>
		</div>
	</div>
</section>

{include file="includes/footer.tpl"}