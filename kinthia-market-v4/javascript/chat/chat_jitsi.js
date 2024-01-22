function startJitsi(consultationType) {

const domain = 'meet.jit.si';
//var consultationType = $("#consultationType").val();
const userdata = document.getElementById('userdata').value;
const user = JSON.parse(userdata);

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
    width: 296,
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
 
   //stop custome timer...
   //clearTimeout(t);
   //start.disabled = false;
   //getting Remaining time...
   // var totUsrCreditTime = $("#totalUserTalkTime").val();
   // var talkTime = $("#talkTime").val();

   // var totTime = totUsrCreditTime.split(":");
   // var talkuTime = talkTime.split(":");
   // var remainingTime = (totTime[0]+totTime[1]+totTime[2]) - (talkuTime[0]+talkuTime[1]+talkuTime[2]);
    
    //alert(remainingTime);
});
}
