{if $session.user}    
	{if isset($mailToVoyant)}
    Successfully Mail Sent  To {$voyantEmail.email} 

    {else}
       Mail is not Sent
    {/if}

   {else}

   <h2 class="voyanth2 mb-5">Please <a href="{"/user/main/logIn/"|url}"> login </a> or <a href="{"/user/main/logIn/"|url}"> Register </a> for Alert</h2>
 

 {/if}   