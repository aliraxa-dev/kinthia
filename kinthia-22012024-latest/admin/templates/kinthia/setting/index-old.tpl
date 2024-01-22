{capture assign="headData"}
<script type="text/javascript" src="{'/javascript/jquery/jquery.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/setting/indexOnLoad.js'|resurl}"></script>

<link href="{'/javascript/jquery/tooltip/jquery.tooltip.css'|resurl}" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="{'/javascript/jquery/tooltip/jquery.tooltip.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.addTooltip.js'|resurl}"></script>

<script type="text/javascript">
var setting = new Array();
setting.settingJSON = {$settingJSON|htmlspecialchars_decode};
</script>

{/capture}

{include file='includes/header.tpl' page="setting" title="{'Settings'|lang}"}
<div id="left">

{include file='menu/menuleft/menuleftSettings.tpl'}

</div>

<div id="right">
</div>

<div id="middle">
<div class="column">

<div class="title_h_1">
<h1>Main setting</h1>
</div>
<div class="column_in_table2">
<form action="{'/admin/setting/save'|url}" method="post" id="settingEditForm">
<table class="table1" cellspacing="1">
<col class="col1-1" /><col class="col2-2" />
<thead>
<tr>
    <th>Explanation</th>
    <th>Value</th>
</tr>

</thead>
<tbody>
<tr class="line1">
    <td>Language choice: </td>
    <td><select name="language">
    <option label="English" value="en">English</option>
<option label="Français" value="fr">Français</option>
</select></td>
</tr>
<tr class="line2">
    <td>Kinthia script title:<br />

    <span class="text_explication">Title corresponding to the HTML title tag in the directory index.</span></td>
    <td><input type="text" class="input_text_large" name="siteTitle" value="" /></td>
</tr>
<tr class="line1">
    <td>Kinthia script description:<br />
    <span class="text_explication">Description corresponding to the meta tags description in the directory index.</span></td>
    <td><input type="text" class="input_text_large" name="siteDescription" value="" /></td>
</tr>
<tr class="line2">
    <td>Administrator e-mail: </td>
    <td><input type="text" class="input_text_large" name="adminEmail" value="" /></td>
</tr>
<tr class="line1">
    <td>Kinthia script address (Url): </td>
    <td><input type="text" class="input_text_large" name="siteRootUrl" value="" /></td>
</tr>
<tr class="line2">
    <td>Cookie domain name: </td>
    <td><input type="text" class="input_text_large" name="cookieDomain" value="" /></td>
</tr>
<tr class="line1">
    <td>Cookie path: </td>
    <td><input type="text" class="input_text_large" name="cookiePath" value="" /></td>
</tr>
<tr class="line2">
    <td>Url rewriting is enabled: </td>
    <td><input type="radio" name="urlRewriting" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="urlRewriting" value="0" /> OFF</td>
</tr>
<tr class="line1">
    <td>Voyant number displayed by page  : </td>
    <td><input type="text" class="input_text_small" name="voyantsPerPage" value="" /></td>
</tr>
<tr class="line2">
    <td>Questions displayed by page  : </td>
    <td><input type="text" class="input_text_small" name="voyantQuestionsPerPage" value="" /></td>
</tr>
</tbody>
</table>
</div>


<div class="title_h_2" id="inscription">
<h2>Registration, email and newsletter</h2>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<col class="col1-1" /><col class="col2-2" />
<thead>
<tr>
    <th>Explanation</th>
    <th>Value</th>

</tr>
</thead>
<tbody>
<tr class="line1">
    <td>Enable confirmation by email:<br />
    <span class="text_explication">The user must confirm his account by email.</span></td>
    <td><input type="radio" name="emailConfirmationEnabled" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="emailConfirmationEnabled" value="0" /> OFF</td>
</tr>
<tr class="line2">
    <td>User receive an email after have buy question (whit invoice):</td>
    <td><input type="radio" name="sendEmailToUserAfterUserBoughtQuestion" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="sendEmailToUserAfterUserBoughtQuestion" value="0" /> OFF</td>
</tr>
<tr class="line1">
    <td>Voyant receive an email for know he have work:</td>
    <td><input type="radio" name="sendEmailToVoyantAfterUserBoughtQuestion" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="sendEmailToVoyantAfterUserBoughtQuestion" value="0" /> OFF</td>
</tr>
<tr class="line2">
    <td>Voyant receive an email when user have submitted new comment/rating:</td>
    <td><input type="radio" name="sendEmailToVoyantAfterUserSubmitComment" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="sendEmailToVoyantAfterUserSubmitComment" value="0" /> OFF</td>
</tr>
<tr class="line1">
    <td>Enable registration to the newsletter: </td>
    <td><input type="radio" name="newsletterEnabled" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="newsletterEnabled" value="0" /> OFF</td>
</tr>
</tbody>
</table>
</div>


<div class="title_h_2" id="captcha">
<h2>Captcha - Security code</h2>
</div>
<div class="column_in_table2">
<table class="table1" cellspacing="1">
<col class="col1-1" /><col class="col2-2" />
<thead>
<tr>
    <th>Explanation</th>

    <th>Value</th>
</tr>
</thead>
<tbody>
<tr class="line1">
    <td>Display the captcha at the users registration: </td>
    <td><input type="radio" name="captchaInRegistrationEnabled" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="captchaInRegistrationEnabled" value="0" /> OFF</td>
</tr>
<tr class="line2">
    <td>Display the captcha on the page of the contact form: </td>
    <td><input type="radio" name="captchaInContactFormEnabled" value="1" /> ON &nbsp;&nbsp;<input type="radio" name="captchaInContactFormEnabled" value="0" /> OFF</td>
</tr>
</tbody>
</table>
</div>


<div class="column_in_table2">


<div class="column_in_center">
<input type="submit" class="button" value="Save" />
</div>

</form>

</div>


</div>
</div>

<div class="fixe">

&nbsp;
</div>

</div>
</div>

<div id="bottom">
<div class="column_bottom">
Powered by <a href="http://www.arfooo.net/" title="Directory for seo" target="_blank" class="link_black_grey">Arfooo Directory</a> &copy; 2007 - 2008&nbsp; &nbsp; Generated in 0.224 Queries: 3</div>

</div>

</div>
</body>
</html>