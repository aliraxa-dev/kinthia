{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/setting/indexOnLoad.js'|resurl}"></script>
<script type="text/javascript">
var setting = new Array();
setting.settingJSON = {$settingJSON|htmlspecialchars_decode};
</script>
{/capture}
{include file='includes/header.tpl' page="setting" title="{'Settings'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Settings</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard v3</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

<!-- Main content -->
<div class="content">
<div class="container-fluid">
<div class="row">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Main setting</h3>
        </div>
          <!-- /.card-header -->
          <div class="card-body table-responsive p-0">
        <table class="table text-nowrap">
<form action="{'/admin/setting/save'|url}" method="post" id="settingEditForm">
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
<tr class="line1">
    <td>An expert is new during (days)  : </td>
    <td><input type="text" class="input_text_small" name="newVoyantDuration" value="" /></td>
</tr>

<tr class="line1">
    <td>An expert maxinum waiting timing (seconds)  : </td>
    <td><input type="text" class="input_text_small" name="consultation_waiting_time" value="" /></td>
</tr>
<tr class="line1">
    <td>Expert availability refresh rate (seconds)  : </td>
    <td><input type="text" class="input_text_small" name="availability_refresh_rate" value="" /></td>
</tr>
</tbody>
</table>
</div>
</div>

<div class="card">
    <div class="card-header" id="inscription">
    <h3 class="card-title">Registration, email and newsletter</h3>
    </div>
      <!-- /.card-header -->
    <div class="card-body table-responsive p-0">
    <table class="table text-nowrap">
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
</div>


<div class="card">
    <div class="card-header" id="captcha">
    <h3 class="card-title">Captcha - Security code</h3>
    </div>
    <!-- /.card-header -->
    <div class="card-body table-responsive p-0">
    <table class="table text-nowrap">
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
<div class="card-footer clearfix">
    <input type="submit" class="button" value="Save" />
</div>
</div>


<div class="card">
    <div class="card-header" id="captcha">
    <h3 class="card-title">Company information (invoice creation)</h3>
    </div>
    <!-- /.card-header -->
    <div class="card-body table-responsive p-0">
    <table class="table text-nowrap">
<col class="col1-1" /><col class="col2-2" />
<thead>
    <tr>
        <th>Explanation</th>
        <th>Value</th>
    </tr>
</thead>
    <tbody>
        <tr class="line1">
            <td>Name of the company: </td>
            <td><input type="text" class="input_text_small" name="companyName" value="" /></td>
        </tr>
        <tr class="line2">
            <td>Company number(SIRET): </td>
            <td><input type="text" class="input_text_small" name="companyNumber" value="" /></td>
        </tr>
        <tr class="line3">
            <td>APE code of the company: </td>
            <td><input type="text" class="input_text_small" name="apeCompanyCode" value="" /></td>
        </tr>
        <tr class="line4">
            <td>VAT number of the company: </td>
            <td><input type="text" class="input_text_small" name="vatCompanyNumber" value="" /></td>
        </tr>
        <tr class="line5">
            <td>VAT (%): </td>
            <td><input type="text" class="input_text_small" name="vatPercent" value="" /></td>
        </tr>
    </tbody>
</table>
</div>
<div class="card-footer clearfix">
    <input type="submit" class="button" value="Save" />
</div>
</div>

<div class="card">
    <div class="card-header" id="captcha">
    <h3 class="card-title">Platform information (invoice creation)</h3>
    </div>
    <!-- /.card-header -->
    <div class="card-body table-responsive p-0">
    <table class="table text-nowrap">
<col class="col1-1" /><col class="col2-2" />
<thead>
    <tr>
        <th>Explanation</th>
        <th>Value</th>
    </tr>
</thead>
    <tbody>
        <tr class="line1">
            <td>Address: </td>
            <td><input type="text" class="input_text_small" name="platformAddress" value="" /></td>
        </tr>
        <tr class="line2">
            <td>Zipcode: </td>
            <td><input type="text" class="input_text_small" name="platformZipcode" value="" /></td>
        </tr>
        <tr class="line3">
            <td>City: </td>
            <td><input type="text" class="input_text_small" name="platformCity" value="" /></td>
        </tr>
        <tr class="line4">
            <td>Country: </td>
            <td><input type="text" class="input_text_small" name="platformCountry" value="" /></td>
        </tr>
      
    </tbody>
</table>
</div>
<div class="card-footer clearfix">
    <input type="submit" class="button" value="Save" />
</div>
</div>

</div>
</div>
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file="includes/footer.tpl"}
