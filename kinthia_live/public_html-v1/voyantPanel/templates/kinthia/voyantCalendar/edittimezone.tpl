{capture assign="headData"}
{/capture}
{capture assign="footerData"}
  <link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
  <script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
  <script type="text/javascript" src="{'/node_modules/socket.io/client-dist/socket.io.js'|resurl}"></script>
  <script type="text/javascript" src="{'/voyantPanel/javascript/user/chat.js'|resurl}"></script>
{/capture}
{include file='includes/header.tpl' page="index" title="{'Calendar - Kinthia'|lang}"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <div class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1 class="m-0">Calendar</h1>
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
              <div class="row">
                <div class="col-md-6">
                  <h3 class="card-title">{'Manage Timezone'|lang}</h3>
                </div>
              </div>


            </div>
            <div class="card-body table-responsive p-0">
              <table class="table text-nowrap">
                <tbody>
                  <form action="{'/voyantPanel/voyantCalendar/savetimezone'|url}" method="post" id="saveTimezone">
                    <tr>
                      <td>
                        <div class="form-group card-details-actions w-50">

                          <select id="update-timezone-status" name="timezone" class="custom-select"
                            aria-label="update-timezone-status" required="required">
                            {if empty($voyant.timezone)}
                              <option value="" selected="selected" disabled>Please Select Timezone</option>
                            {/if}
                            {foreach from=$timezones item=text key=value}
                              {if $value|strstr:"region"}
                                <option value="{$value}" disabled="disabled">===={$text}====</option>
                              {else}
                                {if $voyant.timezone == $value}
                                  <option value="{$value}" selected="selected">{$text}</option>
                                {else}
                                  <option value="{$value}">{$text}</option>
                                {/if}
                              {/if}
                            {/foreach}
                          </select>
                        </div>
                      </td>
                    </tr>

                    <tr>
                      <td>

                        <button type="submit" class="btn btn-primary">Save</button>

                      </td>
                      <td></td>
                    </tr>
                  </form>
                </tbody>
              </table>
            </div>
          </div>
          <!-- /.card -->
        </div>
      </div>

    </div>
    <!-- /.container-fluid -->
  </div>
  <!-- /.content -->
</div>
<!-- /.content-wrapper -->
{include file="includes/footer.tpl"}