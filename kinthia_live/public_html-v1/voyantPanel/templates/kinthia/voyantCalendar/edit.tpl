{capture assign="headData"}
{/capture}
{capture assign="footerData"}
  <script type="text/javascript" src="{'/voyantPanel/javascript/consultation/calanderConsultation.js'|resurl}"></script>

  <link href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" rel="stylesheet" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
    integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
              <h3 class="card-title">{'Manage Calendar'|lang} : {$consulType} - Week : $weekNumber - Date : $startDate
                to $endDate (example: Week : 9 - Date :27/02/2023 to 05/03/2023 )</h3>
            </div>


            <div class="card-body">

              {if $dates}
                {foreach from=$dates item=day key=mkey}

                  {assign var="asdf" value=$dates[0]}
                  {assign var="prevWDate" value=$dates[0]}
                  {assign var="nextWDate" value=$dates[6]}
                {/foreach}
              {/if}

              {if $type=='prev'}
                {assign var="prevWDate" value=$nextWDate}
                {assign var="nextWDate" value=$asdf}
              {/if}

              <div class="row mb-5">
                <div class="col-md-6 text-left">
                  {assign var="prev" value="prev"}
                  {assign var="pUrl" value="?type=$prev&sdate=".$prevWDate}
                  <a href="{$pUrl}">Pre Week</a>
                  <!--Previous week-->
                </div>

                <div class="col-md-6 text-right">
                  {assign var="next" value="next"}
                  {assign var="nUrl" value="?type=$next&sdate=".$nextWDate}
                  <a href="{$nUrl}">Next Week</a>
                  <!--Previous week-->
                </div>
              </div>



              <form action="{'/voyantPanel/voyantCalendar/saveCalanderData'|url}" method="post" id="saveCalanderForm">

                <textarea hidden name="timeslots" id="timeslots"></textarea>
                <input type="hidden" name="schedule_date" id="schedule_date" />
                <input type="hidden" name="consultationtypeId" id="consultationtypeId" value="{$consultationtypeId}" />
                <input type="hidden" name="type" id="type">
              </form>

              <div class="plannings mb-2">
                <div class="legends">
                  <span class="sector fright selected pre" onclick="getSelect('present');"
                    data-boxtype="present"></span>
                  <div class="legend fright">ADD Présent(e)</div>

                  <span class="sector fright abs" onclick="getSelect('absent');" data-boxtype="absent"></span>
                  <div class="legend fright">ADD Absent(e)</div>
                </div>
              </div>
              <p id="status"></p>
              {* START PLANNING *}
              <div id="expert-planning">
                <div class="container" data-type="phone">
                  <div class="plannings">
                    <div class="wrapper box" id="voyantTimeSlot">
                      <div class="hours">
                        {for start=00 stop=24 step=1 value=time}
                          <div class="hour fleft">{if $time < 10}0{$time}h {else}{$time}h {/if}</div>
                        {/for}
                      </div>

                      {if $dates}
                        {foreach from=$dates item=wdate key=mkey}
                          <div class="days">
                            <div class="day fleft"> <span class="date">{$wdate|date_format:"%e/%m"}</span></div>

                            {foreach from=$minutes item=minute key=min}
                              <div class="sectors slot" id="A{$min}">
                                {foreach from=$minute item=time key=min2}

                                  {if isset($result[schedule_date][$wdate])}
                                    <div
                                      class="sector {if $time[$min2]} right {else} left {/if} {if in_array($time,$result[schedule_date][$wdate])} selected {/if} item tips fleft"
                                      data-sector="{$time}" data-type="{$consulType}" data-date="{$wdate}"
                                      data-id="{$min}{$min2}{$mkey}" {if in_array($time,$result[schedule_date][$wdate])}
                                      data-timeslot="booked" {else} data-timeslot="empty" 
                                      {/if} data-toggle="tooltip"
                                      data-html="true"></div>
                                  {else}
                                    <div class="sector {if $time[$min2]} right {else} left {/if} item tips fleft"
                                      data-sector="{$time}" data-type="{$consulType}" data-date="{$wdate}"
                                      data-id="{$min}{$min2}{$mkey}" data-timeslot="empty" data-toggle="tooltip" data-html="true">
                                    </div>
                                  {/if}
                                {/foreach}
                              </div>
                            {/foreach}

                          </div>
                          {assign var="asdf" value=$dates[0]}
                          {assign var="prevWDate" value=$dates[0]}
                          {assign var="nextWDate" value=$dates[6]}
                        {/foreach}
                      {/if}



                    </div>

                    <div class="timezone fleft">
                      <p>Fuseau horaire : <strong>Paris</strong></p>
                    </div>

                    <div class="legends">
                      <div class="sector {if $consultationtypeStatus==1} selected {/if} fright"
                        onclick="getSelect('present');"></div>
                      <div class="legend fright">Présent(e)</div>

                      <div class="sector fright" onclick="getSelect('absent');"></div>
                      <div class="legend fright">Absent(e)</div>
                    </div>
                    <form action="{'/voyantPanel/voyantCalendar/updateConsultStatus'|url}" method="post"
                      id="updateStatus">
                      <input type="hidden" name="consulTypeId" id="consulTypeId" value="{$consultationtypeId}" />
                      <input type="hidden" name="consultType" id="consultType">
                    </form>

                  </div>
                </div>
              </div>
              {* END PLANNING *}


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