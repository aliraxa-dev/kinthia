function userFav(voyantId,userId){
     
         
    if(voyantId != ""){
        $("#voyantId").val(voyantId);
        $("#userId").val(userId);
             
            var form = document.getElementById('voyantFrm');
           
                       
            $.ajax({
                url:form.action,
                type: form.method,
                data: $(form).serialize(),
                dataType: 'html',
                success: function(data) {
                   
                    if(data == "added"){
                        $("#infav_"+voyantId).css('color','red'); 
                    }else
                    $("#infav_"+voyantId).css('color','#333');
					$("#infav1_"+voyantId).css('display','none'); 

                  
                }
            });
          
        }
    
}

jQuery(document).ready(function(){
    
    $("a.dialog").each(function(){
        $this = $(this);
        $this.click(function(){
            var link = this;
            $.popup.open(link.href, $(link).attr("title"));
            
            return false;
        });
    });


    if (setting.expertRecds) {
    	//console.warn("hello", setting.expertRecds);
    	var availableTags = setting.expertRecds;
		    $( "#searchExprtEmailId" ).autocomplete({
		      source: availableTags,
		        select: function( event, ui ) {
		           event.preventDefault();
		           
		           //assign value back to the form element
			        if(ui.item){
			            //$(event.target).val(ui.item.value);
			            var voyantEmailId = ui.item.value;
		           		$("#voyantEmailId").val(voyantEmailId);

			            var form = document.getElementById('getPrivateMsg');
				    	if(voyantEmailId != ""){
				    		$.ajax({
				                url: form.action,
				                type: form.method,
				                data: $(form).serialize(),
				                dataType: 'json',
				                success: function(response) { 			            
				                   if(response.voyantTblRecords.name != ''){
				                   		$("#voyDetails1").css("display","block");
				                   		$("#appnd").hide();

				                   		$("#voyantName1").html(response.voyantTblRecords.name);
				                   		var imgs = response.voyantTblRecords.imageSrc;
				                   		var folderName = imgs.substring(0, 2);			              
				                   		var url=window.location.href;
				                   		var baseUrl = url.replace('user/privateMessage', '');
				                   		var fullbaseUrl = baseUrl+'uploads/photos/';
				                   		$("#voyantDescription1").html('<a href="'+baseUrl+response.voyantTblRecords.urlName+'"><img src="' + fullbaseUrl +folderName+'/'+response.voyantTblRecords.imageSrc+'" alt="'+response.voyantTblRecords.headerDescription+'" class="imagevoyant" style="width:100px" /></a>');
				                   		$("#msgDetail1").html('<a href="'+baseUrl+'user/privateMessage/details/'+response.voyantTblRecords.voyantId+'" class="btn btn-danger">Voir / envoyer</a>');
				                   		$("#pendingMsgCount1").html('Nombre de message en attente : '+response.voyantTblRecords.pendingMsg);
				                   	}
				                }
				            });
				    	}
			        }
		        }
		    });
    }


var pendingVoyantEmailId = pendingMsg.pendingVoyantEmailsIds;
//console.warn(pendingMsg.pendingVoyantEmailsIds);

var i;var sum=0;
if(pendingMsg.pendingVoyantEmailsIds){
	
	for (i = 0; i < pendingMsg.pendingVoyantEmailsIds.length; i++) {
	  $("#voyantEmailId").val(pendingMsg.pendingVoyantEmailsIds[i]);
		var form = document.getElementById('getPrivateMsg');
		if(voyantEmailId != ""){
			$.ajax({
		        url: form.action,
		        type: form.method,
		        data: $(form).serialize(),
		        dataType: 'json',
		        success: function(response) {

		        		sum+= response.voyantTblRecords.pendingMsg;		           		 
		           		$("#pMess").html(sum);
		           if(response.voyantTblRecords.name != ''){
		                $("#voyDetails").css("display","block");	           		
		           		
		           		var imgs = response.voyantTblRecords.imageSrc;
		           		var folderName = imgs.substring(0, 2);			              
		           		var url=window.location.href;
		           		var baseUrl = url.replace('user/privateMessage', '');
		           		var fullbaseUrl = baseUrl+'uploads/photos/';
		           	
			        	var voyantDescription = '<a href="'+baseUrl+response.voyantTblRecords.urlName+'"><img src="' + fullbaseUrl +folderName+'/'+response.voyantTblRecords.imageSrc+'" alt="'+response.voyantTblRecords.headerDescription+'" class="imagevoyant" style="width:100px" /></a>';
			     		var msgDetail = '<a href="'+baseUrl+'user/privateMessage/details/'+response.voyantTblRecords.voyantId+'" class="btn btn-danger">Voir / envoyer</a>';
			     		var pendingMsgCount = 'Nombre de message en attente : '+response.voyantTblRecords.pendingMsg
			     		var timeDiv='<div class="voyantcontainer pas" id="voyDetails"><div class="grid-3-small-1 man pan" id="detil"><div class="voyantimageindex"><a href="" id="voyantName">'+response.voyantTblRecords.name+'</a><br><p id="voyantDescription">'+voyantDescription+'</p></div><div><span id="pendingMsgCount">'+pendingMsgCount+'</span><br><div id="msgDetail">'+msgDetail+'</div></div></div></div>';
			     			
	    				$("#appnd").append(timeDiv);

		           	}
		        }
		    });
		}
	}
}

});

 $(document).keypress(function(event){
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if(keycode == '13'){
        var form = document.getElementById('getPrivateMsg');
		var voyantEmailId = $("#searchExprtEmailId").val();
		$("#voyantEmailId").val(voyantEmailId);
		if(voyantEmailId != ""){
			$.ajax({
		        url: form.action,
		        type: form.method,
		        data: $(form).serialize(),
		        dataType: 'json',
		        success: function(response) { 			            
		           if(response.voyantTblRecords.name != ''){
		           		$("#voyDetails1").css("display","block");
		           		$("#appnd").hide();

		           		$("#voyantName1").html(response.voyantTblRecords.name);
		           		var imgs = response.voyantTblRecords.imageSrc;
		           		var folderName = imgs.substring(0, 2);			              
		           		var url=window.location.href;
		           		var baseUrl = url.replace('user/privateMessage', '');
		           		var fullbaseUrl = baseUrl+'uploads/photos/';
		           		$("#voyantDescription1").html('<a href="'+baseUrl+response.voyantTblRecords.urlName+'"><img src="' + fullbaseUrl +folderName+'/'+response.voyantTblRecords.imageSrc+'" alt="'+response.voyantTblRecords.headerDescription+'" class="imagevoyant" style="width:100px" /></a>');
		           		$("#msgDetail1").html('<a href="'+baseUrl+'user/privateMessage/details/'+response.voyantTblRecords.voyantId+'" class="btn btn-danger">Voir / envoyer</a>');
		           		$("#pendingMsgCount1").html('Nombre de message en attente : '+response.voyantTblRecords.pendingMsg);
		           	}
		        }
		    });
		}
	    return false;  
    }
});

function getSearch(){

	var form = document.getElementById('getPrivateMsg');
	var voyantEmailId = $("#searchExprtEmailId").val();
	$("#voyantEmailId").val(voyantEmailId);
	if(voyantEmailId != ""){
		$.ajax({
	        url: form.action,
	        type: form.method,
	        data: $(form).serialize(),
	        dataType: 'json',
	        success: function(response) { 			            
	           if(response.voyantTblRecords.name != ''){
	           		$("#voyDetails1").css("display","block");
	           		$("#appnd").hide();

	           		$("#voyantName1").html(response.voyantTblRecords.name);
	           		var imgs = response.voyantTblRecords.imageSrc;
	           		var folderName = imgs.substring(0, 2);			              
	           		var url=window.location.href;
	           		var baseUrl = url.replace('user/privateMessage', '');
	           		var fullbaseUrl = baseUrl+'uploads/photos/';
	           		$("#voyantDescription1").html('<a href="'+baseUrl+response.voyantTblRecords.urlName+'"><img src="' + fullbaseUrl +folderName+'/'+response.voyantTblRecords.imageSrc+'" alt="'+response.voyantTblRecords.headerDescription+'" class="imagevoyant" style="width:100px" /></a>');
	           		$("#msgDetail1").html('<a href="'+baseUrl+'user/privateMessage/details/'+response.voyantTblRecords.voyantId+'" class="btn btn-danger">Voir / envoyer</a>');
	           		$("#pendingMsgCount1").html('Nombre de message en attente : '+response.voyantTblRecords.pendingMsg);
	           	}
	        }
	    });
	}
}

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
