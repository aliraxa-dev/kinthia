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
                    <a href="{'/user/order'|url}">{'orderIndex_arbo'|lang}</a>&gt;
                    <a href="{'/user/order/phone'|url}">{'Consultation par téléphone'|lang}</a>
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
	                <a href="{'/user/order/chat'|url}" class="btn btn-primary">Consultation par chat ({$chatCount})</a>
                </div>
            </div>
        </div>


<div class="row">
            <div class="col-lg-12">
                <table class="tablemanage table table-sm table-bordered table-responsive-md">
					<thead class="small-hidden tiny-hidden">
						<tr>
							<th>{'Consultation N°'|lang}</th>
							<th>{'orderIndex_purchase_date'|lang}</th>
							<th>{'Durée'|lang}</th>
							<th>{'orderIndex_voyant'|lang}</th>
							<th>{'orderIndex_rating_comment'|lang}</th>
							<th>{'Private Message'|lang}</th>
						</tr>
					</thead>

					<tbody>
					 {if $userChatConsultations}
				       {foreach from=$userChatConsultations item=consltationArr key=mkey}
						<tr class="line{cycle values='1,2'}">

							<td class="td_left">
							{* {math equation="($mkey+1)"} *}
							{$consltationArr.userconsultationId}
							</td>
							<td class="td_left">{$consltationArr.date}</td>
							<td class="td_left">{$consltationArr.durationMinutes}</td>
							<td class="td_left">{$consltationArr.voyantName}</td>

							{* <td class="td_left">
								<a href=""/user/comment/popup/$order.orderId"|url" class="link_panel_grey_underline dialog" title="{'orderIndex_comment_rating_title'|lang} $order.voyant.name">{'orderIndex_comment_rating'|lang}</a>
							</td> *}

							<td class="td_left">
								<a href="{"/user/comment/popupconsultation/$consltationArr.userconsultationId/P"|url}" class="link_panel_grey_underline dialog" title="{'orderIndex_comment_rating_title'|lang} ">{'orderIndex_comment_rating'|lang}</a>
								<br/>
								<br/>
							</td>

							{* <td class="td_left"><a href="{'/user/privateMessage/details'|url}" class="link_panel_grey_underline">{'Sent / See'|lang}</a></td> *}

							<td class="td_left"><a href="{'/user/privateMessage/details/'.$consltationArr.voyantId}" class="link_panel_grey_underline" title="{'orderIndex_contact_voyant_title'|lang} {$consltationArr.voyantName}">{'Sent / See'|lang}</a></td>
						</tr>
						{/foreach}
					  {/if}
					</tbody>
				</table>
            </div>
        </div>
    </div>
</section>

{include file="includes/footer.tpl"}
