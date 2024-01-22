<head>
<meta name="robots" content="noindex, nofollow" />
</head>

<link href="{'/templates/kinthia/jquery/jquery-rating/jquery.rating.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/jquery/jquery-rating/jquery.rating.js'|resurl}"></script>
<script type="text/javascript" src="{'/user/javascript/order/ratingCommentOnLoad.js'|resurl}"></script>


{if $canVote}

<form action="{'/user/comment/savePlatformComment'|url}" method="post" id="commentPopupForm">
<input type="hidden" name="userconsultationId" value="{$userConsultation.userconsultationId}">
<input type="hidden" name="type" value="{$type}">  
<fieldset class="fieldsetpopin pas">

<h3 class="voyanth3">{'commentPopup_post_comment'|lang}</h3>

<div class="grid-2-small-1 man mbs pan form">
<div class="titleform">{'commentPopup_rating'|lang} <span class="textmandatory">*</span></div>
<div class="infos">
    
<input name="rating" type="radio" class="star" value="1"/>
<input name="rating" type="radio" class="star" value="2"/>
<input name="rating" type="radio" class="star" value="3"/>
<input name="rating" type="radio" class="star" value="4"/>
<input name="rating" type="radio" class="star" value="5"/>

</div>
</div>
    
<div class="grid-2-small-1 man mbs pan form">
<div class="titleform">{'commentPopup_message'|lang} <span class="textmandatory">*</span></div>
<div class="infos"><textarea class="textarea_large" name="text" cols="50" rows="5" id="categoryDescription"></textarea></div>
</div>

<div class="form_popup">
<div class="titleform">&nbsp;</div>
<div class="infos"><input type="submit" class="btn purple" value="{'commentPopup_button_send'|lang}" /> <!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button close" value="{'commentPopup_button_cancel'|lang}" /> --></div>
</div>

</fieldset>
</form>

{else}
{'commentPopup_already_commented'|lang}
{/if}






    