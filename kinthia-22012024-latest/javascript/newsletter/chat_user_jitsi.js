function startJitsi(consultationType) {

const domain = 'meet.jit.si';
//var consultationType = $("#consultationType").val();
const userdataval = document.getElementById('userdata').value;
const userrecord = JSON.parse(userdataval);


var startWithAudioMuted;
var startWithVideoMuted;
if(consultationType=='phone'){
   startWithAudioMuted = false;
   startWithVideoMuted = true;
}

if(consultationType=='webcam'){
   startWithAudioMuted = false;
   startWithVideoMuted = false;
}

$("#webcam-container").css("display","block"); 
$("#stopConsult").css("display","block");    
 
const options = {
    roomName: user.room,
    //width: 226.5,
    width: 265.5,
    height: 350,
    configOverwrite : {startWithAudioMuted, startWithVideoMuted, prejoinPageEnabled: false},
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
