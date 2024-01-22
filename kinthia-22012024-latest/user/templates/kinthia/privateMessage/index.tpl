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


<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>

<script type="text/javascript">
  var setting = new Array();
setting.expertRecds = {$expertRecds|htmlspecialchars_decode}

var pendingMsg = new Array();
pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode}

</script>
{/capture}

{include file="includes/header.tpl" title="{'orderIndex_title_html'|lang}" metaDescription="{'orderIndex_meta_description'|lang}"}

<section id="user-message">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div id="breadcrumb">
                    <a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
                    <a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
                    <a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
                    <a href="{'/user/privateMessage'|url}">{'Messages privés'|lang}</a>
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
				<form action="{'/user/privateMessage/getPrivateMessage'|url}" method="post" id="getPrivateMsg">
					<div class="input-group">
						
							<input type="hidden" name="voyantEmailId" id="voyantEmailId">
							<input type="search" placeholder="Search an Expert" aria-describedby="button-addon5" class="form-control" id="searchExprtEmailId" name="searchExprtEmailId">			
					
							<div class="input-group-append" style="font-size:0.8em !important;">
								<p id="button-addon5" class="btn btn-primary mb-0" onclick="getSearch();"><i class="fa fa-search"></i></p>	
							</div>
					
						<br>		
					</div>
					<div id="myVoyants"></div>
					<div class="input-group" id="expId"></div>
			    </form>

				<div id="appnd">
					
				</div>
			</div>
		</div>

		<div class="row">
            <div class="col-lg-12">
				<div class="kin-container" id="voyDetails1" style="display: none;">
					<h2>{'Résultat'|lang}</h2>

					<div class="container">
						<div class="row">
							<div class="col-lg-4" id="detil">
								<div class="voyantimageindex">
									<span></span>
									<a href="" id="voyantName1"></a><br>
									<p id="voyantDescription1"></p>
								</div>
							</div>
							<div class="col-lg-4">
								<span id="pendingMsgCount1"></span><br>
							</div>
							<div class="col-lg-4" id="msgDetail1">
								
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

		<div class="row">
            <div class="col-lg-12">

				{if $voyantRecords}
				<table class="tablemanage table table-sm table-bordered table-responsive-md">
					<thead class="small-hidden tiny-hidden">
					<tr>
						<th>Date</th>
						<th>Voyant Name</th>
						<th>Action</th>
					</tr>
					</thead>

					<tbody>	
					   {foreach from=$voyantmessages item=voyantmessage}
				            <tr class="{cycle values='bg-grey-kin, '}">
				              <td  class="td_left">{$voyantmessage.date|date_format:"%d-%m-%Y at %I:%M %p"}</td>
				            
				              <td  class="td_left">{$voyantmessage.voyant.name}</td>
				              
							  <td class="td_left">
								
								<a href="{"/user/privateMessage/details/$voyantmessage.voyantId"|url}" class="link_panel_grey_underline dialog">
								{'see'|lang}
								</a>
							</td> 
				            </tr>
				            {/foreach}
					</tbody>
				</table>
				{/if}
			</div>
		</div>
	</div>
</section>

{include file="includes/footer.tpl"}