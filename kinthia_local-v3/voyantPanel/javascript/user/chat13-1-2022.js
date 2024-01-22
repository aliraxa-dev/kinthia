
let voyantId = document.getElementById('chat_voyantId').value;

const socket = io('http://localhost:5000?find='+voyantId+'&requestid=0');

let audioplay = '';

socket.on('send-request',requestId=>{
   audioplay = document.getElementById("myAudio");
   audioplay.play();
   getUserConsultationRequest(requestId);
});


function cancelConsultationRequest(requestUrl,requestId,userId,voyantId) {
        pauseAudio();
        fetch(requestUrl)
            .then(response => response.json())
            .then(data => {
              console.log('cancel Request Success', data);
               if(data.count>0) {
                  socket.emit('expert-cancel-request',{requestId,userId,voyantId},(response) => {
                     if(response.status=='Y')
                       $(".ui-dialog-titlebar-close").click();
                     else
                      alert(response.msg); 
                  }); 
               } else {
                 $(".ui-dialog-titlebar-close").click();
               }
              })
              .catch((error) => {
                console.error('Error:', error);
              });
 
}

function getUserConsultationRequest(requestId) {

        var requestUrl = $("input[name$='requestUrl']").val(); 

        /*var progress = $("<div title='" + _t("Loading") + "'>" +
            "<p style='text-align:center;font-size:1.6em'><br/>" +
            "<b>" + _t("Loading...") + "</b><br>" +
            "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
            "</div>")
            .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
        progress.dialog("open");*/
        
        $.popup.open(
            requestUrl+'/'+requestId
        );
        /*setTimeout ( function(){
            progress.dialog("close");
        }, 800);*/

        /*var data = {
            voyantId: voyantId
          };

        fetch(requestUrl+'/'+voyantId)
            .then(response => response.json())
            .then(data => {
              console.log('Success:', data);
              if(data.msg!='') {
              $("#request_notification").addClass('show');
                  let msg=`<span class="dropdown-item dropdown-header">A New Consultation Request &nbsp;&nbsp;&nbsp; <a href"javascript:void(0)" onclick="cancelConsultationRequest('${data.userId}');"><i class="fas fa-times"></i></a></span>
                       <div class="dropdown-divider"></div><a href=${data.redirectUrl} class="dropdown-item">${data.msg}</a>`
                  $("#request_notification").html(msg);
              }
            })
            .catch((error) => {
              console.error('Error:', error);
            });
            */
        setTimeout(function() { pauseAudio(); },10000);  
}
//getUserConsultationRequest(1);
function pauseAudio() {
   audioplay.pause();
}
