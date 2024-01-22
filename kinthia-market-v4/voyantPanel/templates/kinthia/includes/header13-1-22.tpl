<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{$title}</title>
  <meta name="description" content="{$title}" />
  <meta name="robots" content="noindex, nofollow" />

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/plugins/fontawesome-free/css/all.min.css'|resurl}">
  <!-- IonIcons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/dist/css/adminlte.min.css'|resurl}">
  {if isset($headData)}
  {$headData}{/if}
  <link rel="stylesheet" href="{'/voyantPanel/templates/kinthia/css/custom.css'|resurl}">
</head>
<!--
`body` tag options:

  Apply one or more of the following classes to to the body tag
  to get the desired effect

  * sidebar-collapse
  * sidebar-mini
-->
<body class="hold-transition sidebar-mini">
<div class="wrapper">
{include file='menu/menuheader/menuheader.tpl'}
{include file='menu/menuleft/menuleft.tpl'}


<!--
   Set get requestData and voyantId
-->

<input type="hidden" name="requestUrl" value="{'/voyantPanel/consultation/incomingCall'|url}" />
<input type="hidden" id="chat_voyantId" value={$session.userId} />

<audio id="myAudio">
 <source src="{'/uploads/audio/The-Inspiration-mp3.mp3'|url}" type="audio/mpeg" muted="muted">
</audio>




{* <input type="text" id="ajxUrl" value="{'/voyantPanel/consultation/userConsultationRequest'|url}">
{literal}
  <script>
  //Call the yourAjaxCall() function every 1000 millisecond
  //setInterval("yourAjaxCall()",1000);
  function yourAjaxCall(){
    var ajxUrl = $("#ajxUrl").val();
    $.ajax({    
        type: "GET",
        url: ajxUrl,             
        dataType: 'json',                  
        success: function(data){ 

           //$("#table-container").html(data); 
           //console.warn(data.userId);

           var progress = $("<div title='" + _t("Loading") + "'>" +
                    "<p style='text-align:center;font-size:1.6em'><br/>" +
                    "<b>" + _t("Loading...") + "</b><br>" +
                    "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
                    "</div>")
                    .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
                progress.dialog("open");

                $.popup.open(
                    // this.href,
                    // this.title,
                );
                setTimeout ( function(){
                    progress.dialog("close");
                }, 800 );

                return false;
        }
    });
  }
  </script>
{/literal} *}