
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
	
  $("#startConsultation").click(function()
    {
        var progress = $("<div title='" + _t("Loading") + "'>" +
            "<p style='text-align:center;font-size:1.6em'><br/>" +
            "<b>" + _t("Loading...") + "</b><br>" +
            "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
            "</div>")
            .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
        progress.dialog("open");
        
        $.popup.open(
            this.href,
            this.title,
        );
        setTimeout ( function(){
            progress.dialog("close");
        }, 800 );

        return false;
    });
  
	
	
   $(".typ").click(function()
    {
       /*var progress = $("<div title='" + _t("Loading") + "'>" +
            "<p style='text-align:center;font-size:1.6em'><br/>" +
            "<b>" + _t("Loading...") + "</b><br>" +
            "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
            "</div>")
            .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false }); 
        progress.dialog("open");*/
        $.popup.open(
            this.href,
            this.title,
        );
        /*setTimeout ( function(){
            progress.dialog("close");
        }, 800 );*/

        return false;
    });
});

 