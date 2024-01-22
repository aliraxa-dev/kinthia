function startJitsi(consultationType) {

    let domain = 'meet.jit.si';
    // domain = consultationType==='chat' ? '' : 'meet.jit.si';

    if(consultationType=='chat'){
        $("#stopConsult").css("display","block");
        $("#refreshConsult").css("display","block");
        return;
    }
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

    api.executeCommand('overwriteConfig',
        {
            toolbarButtons: ['microphone','camera']
        }
    );

    api.executeCommand('displayName', user.name);

    $("#dispose").click(function(){
        api.dispose();
    });
}