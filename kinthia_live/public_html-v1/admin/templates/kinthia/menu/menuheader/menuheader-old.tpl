<div id="menutop"> 
<ul>
<li{if $page == 'index'} class="current"{/if}><a href="{'/admin/'|url}" title="{'MenuHeader_Directory'|lang}">{'MenuHeader_Directory'|lang}</a></li>
<li{if $page == 'setting'} class="current"{/if}><a href="{'/admin/setting'|url}" title="{'MenuHeader_Settings'|lang}">{'MenuHeader_Settings'|lang}</a></li>
<li{if $page == 'ad'} class="current"{/if}><a href="{'/admin/ad'|url}">{'MenuHeader_Adsense'|lang}</a></li>
<li{if $page == 'user'} class="current"{/if}><a href="{'/admin/user'|url}" title="{'MenuHeader_Users'|lang}" >{'MenuHeader_Users'|lang}</a></li>
<li{if $page == 'template'} class="current"{/if}><a href="{'/admin/template'|url}">{'MenuHeader_Templates'|lang}</a></li>
<li{if $page == 'system'} class="current"{/if}><a href="{'/admin/system'|url}" title="{'MenuHeader_System'|lang}">{'MenuHeader_System'|lang}</a></li>
</ul>
</div>
