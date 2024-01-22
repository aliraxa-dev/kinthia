function startJitsi(consultationType) {

const domain = 'meet.jit.si';
// const domain = 'meet.voyantcloud.com';

if(consultationType=='chat'){
    $("#stopConsult").css("display","block");
    $("#refreshConsult").css("display","block");
    return;
}
//var consultationType = $("#consultationType").val();
const userdataval = document.getElementById('userdata').value;
const userrecord = JSON.parse(userdataval);

var startWithAudioMuted;
var startWithVideoMuted;
if(consultationType=='phone'){
   startWithAudioMuted = false;
   startWithVideoMuted = true;
   $("#webcam-container").css("display","block"); 
}

if(consultationType=='webcam'){
   startWithAudioMuted = false;
   startWithVideoMuted = false;
   $("#webcam-container").css("display","block"); 
}

if(consultationType=='chat'){
  startWithAudioMuted = true;
  startWithVideoMuted = true;
  $("#webcam-container").css("display","none"); 
}

$("#stopConsult").css("display","block"); 
$("#refreshConsult").css("display","block");   
 
const options = {
    roomName: user.room,
    //width: 226.5,
    //width: 100,
    //height: 350,
    configOverwrite : {
      startWithAudioMuted, 
      startWithVideoMuted, 
      prejoinPageEnabled: false,
      //disableDeepLinking: true
    },
    //interfaceConfigOverwrite: {
    //        MOBILE_APP_PROMO: false,
    //      },
    parentNode: document.querySelector('#webcam-container')
  
};
const api = new JitsiMeetExternalAPI(domain, options);
api.executeCommand('subject', ' ');

//Removed all buttons
api.executeCommand('overwriteConfig',
    {
      toolbarButtons: ['microphone','camera']
    }
);

//Display Voyant Name in Meeting....
api.executeCommand('displayName', user.name);

//Stop Consultation Meeting...
$("#dispose").click(function(){
    api.dispose();
});
}
