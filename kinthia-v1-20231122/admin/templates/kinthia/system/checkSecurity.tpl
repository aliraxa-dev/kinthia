{if $installDirExists || $newVersionAvailable}
    <div id="column_in_warning_out">
    {if $newVersionAvailable}
        <div class="column_in_warning">
        {'Your installation is not up to date, an update is available at this address: http://www.arfooo.com.'|lang}
        {'You need to update your installation for security reasons.'|lang}
    </div>
    {/if}
    {if $installDirExists}
        <div class="column_in_warning">
        {'Warning, the install/ directory is still present on the server. For safety reasons, remove it.'|lang}
        </div>
    {/if}
    </div>
{/if}