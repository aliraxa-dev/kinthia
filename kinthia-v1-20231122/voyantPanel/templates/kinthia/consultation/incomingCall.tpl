<h2 class="voyanth2 mb-5">Incoming call <span class="kin-color-1">{$pendingRequests.type}</span></h2>
<p>{$pendingRequests.user.name} souhaite vous consulter par {$pendingRequests.type}</p>


<div class="text-center">
    <a href={$redirectUrl}>
    <div class="status-wrapper phone present">
    </div>
    </a>
</div>

<div class="text-center">
    <a href="javascript:void(0)" onclick="cancelConsultationRequest('{$cancelUrl}','{$pendingRequests.userconsultationId}','{$pendingRequests.userId}','{$voyant.voyantId}')">
    <div class="status-wrapper phone refuse">
    </div>
    </a>
</div>