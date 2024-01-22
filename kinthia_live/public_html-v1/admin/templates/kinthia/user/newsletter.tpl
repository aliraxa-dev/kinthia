{capture assign="headData"}
{/capture}
{capture assign="footerData"}
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.backgroundTask.js'|resurl}"></script>
<script type="text/javascript" src="{'/admin/javascript/user/newsletterOnLoad.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="user" title="{'Mass Mailer - Newsletter'|lang}"}  
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">{'Mass Mailer - Newsletter'|lang}</h1>
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
        <div class="card-body">
        {'You can send an e-mail to all webmasters'|lang}.<br />
        {'The e-mails are sent in background, so you can leave your administration and go walk without being worried'|lang}.<br />
        {'You can also stop and resume at anytime sends'|lang}.<br />
        {'A notification will be sent when the shipment is completed'|lang}.
        </div>
    </div>

    <div class="card">
        <div class="card-header">
        <h3 class="card-title">{'Mass Mailer - Newsletter / Management'|lang}</h3>
    </div>
<div class="card-body table-responsive">
<form id="backgroundTaskControlForm">
<table class="table text-nowrap">
<tbody>
<tr>
	<td>{'Subject'|lang}: </td>
	<td><input type="text" class="input_text_medium" name="subject" value="" /></td>
</tr>
<tr>
	<td>{'Message'|lang}: </td>
	<td><textarea class="textarea_extra_large" name="text" cols="50" rows="5"></textarea></td>
</tr>
<tr>
	<td>{'Number of mail sent per minute'|lang}: </td>
	<td><input type="text" class="input_text_small" name="mailsPerMinute" value="20" /></td>
</tr>
<tr>
    <td>{'Send the newsletter to'|lang}: </td>
    <td><input type="radio" name="newsletterType" value="subscribers" checked="checked"/> {'subscribers'|lang} <br/>
        <input type="radio" name="newsletterType" value="all"/> {'all persons'|lang} <br/>
        <input type="radio" name="newsletterType" value="admin"/> {'only admin'|lang}
    </td>
</tr>
<tr>
	<td></td>
	<td>
    <div style="display:none" id="progressInformation">
    {'Status'|lang}: <b><span id="taskStatus"> </span></b> &nbsp;
    {'Progress'|lang}: <b><span id="taskPercentage">0%</span></b> &nbsp;
    {'Emails sent'|lang}: <b><span id="taskParsedItems">0</span></b> 
    <br/>
    <div style="width:250px;border: 1px solid #000; background: #fff; height: 10px;display:none" id="progressBarOutline">
       <div style="width:0%; background: #7AB; height: 100%" id="progressBar"></div>
    </div>
    <br/>
    </div>  
   
    <input type="button" class="button" name="start" value="{'Send'|lang}" />
    <input type="button" class="button" name="pause" value="{'Pause'|lang}" style="display:none" />
    <input type="button" class="button" name="resume" value="{'Resume'|lang}" style="display:none" />
    <input type="button" class="button" name="stop" value="{'Stop'|lang}" style="display:none" /></td>
</tr>
</tbody>
</table>
</form>
</div>
    </div>

    </div>
</div>

  </div>
  <!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file='includes/footer.tpl'}    