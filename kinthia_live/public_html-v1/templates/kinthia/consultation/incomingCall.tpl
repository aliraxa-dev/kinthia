<h2 class="voyanth2 mb-5">Start consultation </h2>
<p>{$pendingRequests.voyant.name} souhaite 
commencer la consultation par {$pendingRequests.type}</p>


<div class="text-center">
    <a href="javascript:void(0)" onclick="consultationRequest('accept','{$pendingRequests.userconsultationId}','{$pendingRequests.userId}','{$pendingRequests.voyantId}')">
    <div class="status-wrapper phone present">
    </div>
    </a>
</div>

<div class="text-center">
    <a href="javascript:void(0)" onclick="consultationRequest('cancel','{$pendingRequests.userconsultationId}','{$pendingRequests.userId}','{$pendingRequests.voyantId}')">
    <div class="status-wrapper phone refuse">
    </div>
    </a>
</div>