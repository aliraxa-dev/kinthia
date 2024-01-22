{capture assign="headData"}
<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{'/javascript/config'|url}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
<script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
 

<script type="text/javascript">
    var pendingMsg = new Array();
    pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};
</script>
{/capture}

{include file="includes/header.tpl" title="{'orderIndex_title_html'|lang}" metaDescription="{'orderIndex_meta_description'|lang}"}

<section id="user-message-detail" class="mb-3">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div id="breadcrumb">
                    <a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
                    <a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
                    <a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
                    <a href="{'/user/privateMessage'|url}">{'Messages privés'|lang}</a>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                {include file="includes/profileMenu.tpl"}
            </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
        			Expert: <a href="">{$voyant.name}</a><br>
        			<a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="imagevoyant" /></a>
          </div>
      		<div class="col-md-6">
      		</div>
        </div>



      <div class="card">
        <div class="card-header bg-kinthia">
          <h3 class="card-title">Communication avec l'expert</h3>
        </div>
        <!-- /.card-header -->
        <div class="card-body p-0 chat-box-container">
          <div class="chat-wrapper">
            <!-- empty message -->
        {if $voyantmessage}
        {foreach from=$voyantmessage value=message}
            {if $message.userId==$userId && $message.sendby=='U'}
            <!-- left user -->
            <div class="chat-box-wrapper">
              <div>
                <small>
                  {$session.user.name}<br>
                  <span class="opacity-8">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-fill" viewBox="0 0 16 16">
                      <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V5h16V4H0V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5z"/>
                    </svg>
                  {$message.date}</span>
                </small>
                  <div class="chat-box bg-chat-left">
                 
                    
{$message.text|nl2br}
                  </div>
              </div>
            </div>
            {/if}
            <!-- right voyant -->
              {if $message.voyantId==$voyant.voyantId && $message.sendby=='V'}
              <div class="float-right chat-box-wrapper chat-box-wrapper-right">
                  <div>
                      <div class="chat-box">
                        {$message.text}
                      </div>
                      <small>
                        {$voyant.name}<br>
                        <span class="opacity-8">
                          <span class="opacity-8">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-fill" viewBox="0 0 16 16">
                              <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V5h16V4H0V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5z"/>
                            </svg>
                        {$message.date}</span>
                      </small>
                  </div>
                  <div>
                      <div class="avatar-icon-wrapper ml-1">
                          <div class="badge badge-bottom btn-shine badge-success badge-dot badge-dot-lg"></div>
                          <div class="avatar-icon avatar-icon-lg rounded"><img src="assets/images/avatars/2.jpg" alt=""></div>
                      </div>
                  </div>
              </div>
              {/if}
           {/foreach}
           {else}
            <div class="chat-box-wrapper">
              no message
            </div>
          {/if}
          </div>
        </div>
        
        <form action="{'/user/privateMessage/saveUserMessage'|url}" method="post" id="savePrivateMsg">  
        <input type="hidden" name="voyantId" value="{$voyant.voyantId}"> 
        <input type="hidden" name="userId" value="{$userId}">
        <div class="card-footer clearfix">
          <div class="form-group">
            {* <input type="text" name="text" class="form-control" placeholder="Taper un message"> *}
            <textarea name="text" placeholder="Taper un message" class="form-control"></textarea>
          </div>
          <button type="submit" class="btn btn-primary btn-kin">Envoyer</button>
        </div>
      </form>
      </div>

  </div>
</section>
{include file="includes/footer.tpl"}