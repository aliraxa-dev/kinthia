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
                  <h3 class="card-title">{'Timezone'|lang}</h3>
                </div>
              </div>
            </div>
            <div class="card-body table-responsive p-0">
              <table class="table text-nowrap">
                <tbody>
                  <tr>
                    <td>
                      Your timezone:
                      {if !empty($voyant.timezone)}
                        {$voyant.timezone}
                      {else}
                        -
                      {/if}
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <a href="{'/voyantPanel/voyantCalendar/edittimezone'|url}" class="btn btn-primary">Edit</a>
                    </td>
                  </tr>
                  </form>
                </tbody>
              </table>
            </div>
          </div>

          <div class="card">
            <div class="card-header">
              <div class="row">
                <div class="col-md-6">
                  <h3 class="card-title">{'Create Calendar'|lang}</h3>
                </div>
                <div class="col-md-6"> <input type="checkbox" id="checkAll1" /> &nbsp &nbsp Select All </div>
              </div>


            </div>
            <div class="card-body table-responsive p-0">
              <table class="table text-nowrap">
                <tbody>
                  <form action="{'/voyantPanel/voyantCalendar/save'|url}" method="post" id="saveConsultation">
                    <tr>
                      <td>Calendar type: </td>
                      <td>
                        <div class="form-group">
                          {foreach from=$consultations item=consultation key=mkey}
                            <div class="form-check">
                              <input class="form-check-input" type="checkbox" name="consultaion_type[]"
                                value="{$consultation.id}">
                              <label class="form-check-label">{$consultation.name}</label>
                            </div>
                          {/foreach}
                        </div>
                      </td>
                    </tr>

                    <tr>
                      <td>

                        <button type="submit" class="btn btn-primary">Create</button>

                      </td>
                      <td></td>
                    </tr>
                  </form>
                </tbody>
              </table>
            </div>
          </div>

          <div class="card">
            <div class="card-header">
              <h3 class="card-title">Calendar management</h3>
            </div>
            <div class="card-body table-responsive p-0">
              <table class="table text-nowrap">
                <thead>
                  <tr>
                    <th> <input type="checkbox" id="checkAll" /> &nbsp &nbsp Select All </th>
                    <th>Calendar type</th>
                    <th>Management</th>

                  </tr>
                </thead>
                <form action="{'/voyantPanel/voyantCalendar/deletAll'|url}" method="post">
                  <tbody>
                    {if !empty($consultations) && !empty($consultationTypes)}
                      {foreach from=$consultations item=consultation key=mkey}
                        {foreach from=$consultationTypes item=consultationType key=kkey}
                          {if $consultationType.consultaion_type==$consultation.id}


                            <tr class="bg-grey-kin">

                              <td> <input style="margin-left:12px;" class="form-check-input" type="checkbox"
                                  name="consultaion_ids[]" value="{$consultationType.id}"></td>
                              <td>{$consultation.name}</td>
                              <td>
                                <ul class="list-inline m-0">
                                  <li class="list-inline-item">
                                    <a href="{"/voyantPanel/voyantCalendar/edit/$consultationType.id"|url}"
                                      class="btn btn-success btn-sm rounded-0" data-toggle="tooltip" data-placement="top"
                                      title="Modifier"><i class="fa fa-edit"></i></a>
                                  </li>
                                  <li class="list-inline-item">
                                    <a onclick="return confirm('Do you really want to delete it?')"
                                      href="{"/voyantPanel/voyantCalendar/delete/$consultationType.id"|url}"
                                      class="btn btn-danger btn-sm rounded-0" data-toggle="tooltip" data-placement="top"
                                      title="Supprimer"><i class="fa fa-trash"></i></a>
                                  </li>

                                </ul>


                              </td>

                            </tr>
                          {/if}
                        {/foreach}
                      {/foreach}

                    {/if}
                    <tr>
                      <td><button class='btn btn-primary'>Delete</button></td>
                    </tr>
                  </tbody>
                </form>
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