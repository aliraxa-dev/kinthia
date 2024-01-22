{if $session.user}
<h2 class="voyanth2 mb-5">Entrer en consultation {$type} avec <span class="kin-color-1">{$expertName}</span></h2>

<div class="text-center">
<a href="{'/consultation/'|url}">Enter in consultation</a>
</div>
{else}

<h2 class="voyanth2 mb-5">Please login or Register for Entrer en consultation {$type} avec <span class="kin-color-1">{$expertName}</span></h2>

<div class="text-center">
<a href="{'/user/main/logIn/'|url}">Enter in consultation</a>
</div>

{/if}
