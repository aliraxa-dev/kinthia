const userdata = document.getElementById('userdata').value;
const image = document.getElementById('userimage').value;
const chatForm = document.getElementById('chat-form');
let  usertimepack = stream = filedata = '';
const user = JSON.parse(userdata);

const socket = io('http://localhost:5000?find='+user.id+'&requestid='+user.requestId,{secure: true,'sync disconnect on unload':true});

if(user.type=='V' && user.hasOwnProperty('requestId'))
{
  user.image = image;
  socket.emit('expert-accept-request',user, (response) => {
     
  });
}

if(user.type=='U' && user.hasOwnProperty('requestId')) {
  socket.emit('expert-request', user, (response) => {
       console.log(response.status); // ok
       console.log(response.msg);
      if(response.status=='N') {
        alert(response.msg);
        window.location.href="http://localhost"
      } else{
        $("#request_accept").html(`<strong>${response.msg}</strong>`);
      }
  });   
}


socket.on('send-information',data=>{
  console.error("send-information");
  console.error(data);
  if(Boolean(data.status)) {
     console.error("send information");
     console.error(user);
     let timepack = $('#myTime').html();
     usertimepack = timepack.replace("h ",":").replace("m ",":").replace("s","");
     $("#request_accept").html('');
     socket.emit('joinRoom',user);
  }
  else {
    $("#request_accept").html(`<strong>${data.msg}</strong>`);
    //alert(data.msg);
  }

});

socket.on('send-again-request',data=>{
   socket.emit('joinRoomAgain',user);
});


//socket.emit('joinRoom', {userdata, image});

socket.on('chat-start', message=>{
   console.error("chat-start");
   console.error(usertimepack);
   console.error(user);
   console.error(message.consultationType);
   startJitsi(message.consultationType);
   $("#chat-form").css("display","block");
   start();
});

socket.on('chat-message', message=>{
  console.warn("Get message from voyance >");
  console.warn(message);
  showMessage(message);
});

socket.on('leave-message', message=>{
  console.warn("Get leave-message >");
  console.warn(message);
  pause();
  $("#chat-form").css("display","none");
  $( "#webcam-container" ). load(window. location. href + " #webcam-container" );
  socket.disconnect('user');
  lastcallajax();
});

socket.on('disconnect-another', data=> {
   console.warn('disconect-antther');
   console.warn(data);
   pause();
   $("#chat-form").css("display","none");
   $( "#webcam-container" ). load(window. location. href + " #webcam-container" );
   socket.disconnect('user');
   let talkTime = $("#talkTime").val();
   let show_msg = "Duration of consultation : "+talkTime;
   alert(data.msg+', '+show_msg);
});

socket.on('image', image => {
   console.warn("image get");
   console.warn(image);
   showImage(image);
});

document.getElementById('file').addEventListener('change', function(e) {
  var file = e.target.files[0];
  var bytes  = file.size;
  var sizeInMB = (bytes / (1024*1024)).toFixed(2);
  console.warn('image uploads file stream',file);
  console.warn('sizeInMB >>>',sizeInMB);
  if(sizeInMB<=5) {
  stream = ss.createStream();
  filedata = e.target.files[0];
  const todoList = document.querySelector('.show_preview');
  const imagediv = document.createElement('img')
  imagediv.width = "150";
  imagediv.height = "150";
  imagediv.src  = URL.createObjectURL(file);
  todoList.innerHTML = '';
  todoList.appendChild(imagediv);
  } else {
    $("#request_accept").html(`<strong>The file size limit is 5MB</strong>`);
  }

 }, false); 
/*
document.getElementById('file').addEventListener('change', function() {

  const reader = new FileReader();
  var bytes  = this.files[0].size;
  var sizeInMB = (bytes / (1024*1024)).toFixed(2);
  //console.error("sizeInMB >>",sizeInMB);
  if(sizeInMB<=0.69) {
  reader.onload = function() {
    base64 = this.result.replace(/.*base64,/, '');
    const todoList = document.querySelector('.show_preview');
    const imagediv = document.createElement('img')
  imagediv.width = "150";
  imagediv.height = "150";
  imagediv.src  = reader.result;
  todoList.innerHTML = '';
  todoList.appendChild(imagediv);
  };
  imageName = this.files[0].name;
  reader.readAsDataURL(this.files[0]);
  } else {
    $("#request_accept").html(`<strong>The file size limit is 700kb</strong>`);
  }

}, false);
*/

chatForm.addEventListener('submit', (e) => {
  e.preventDefault();

  // Get message text
  let msg = e.target.elements.msg.value;
  console.error("show msg >> ",msg);
  msg = msg.trim();

  if (msg) {
     // Emit message to server
   socket.emit('chatMessage', msg);

   // Clear input
   e.target.elements.msg.value = '';
   e.target.elements.msg.focus();
  }
  
  /*if(base64) {
     socket.emit('image',{base64,imageName});
     document.querySelector('.show_preview').innerHTML='';
     base64 = '';
     imageName = '';
     $("#file").val('');
  }*/
  if(stream) {
    $("#overlay").fadeIn(300);
    ss(socket).emit('file', stream, {size: filedata.size,name: filedata.name});
    var blobStream = ss.createBlobReadStream(filedata);
    var size = 0;
    blobStream.on('data', function(chunk) {
      size += chunk.length;
      console.warn(Math.floor(size / filedata.size * 100) + '%');
      // -> e.g. '42%'
    });
    blobStream.pipe(stream);
    blobStream.on('end', function() {
      console.warn("blobStream end >>");
      $("#overlay").fadeOut(300);
      document.querySelector('.show_preview').innerHTML='';
      stream = '';
      $("#file").val('');
    });
  }
});


function showImage(image) {
   let content = '';
   let imagefile='/uploads/chat/'+image.text;
   if(image.type=='V') {
        content = `<div class="float-right chat-box-wrapper chat-box-wrapper-right">
              <div>
              <div class=""><a href=${imagefile} target="_blank" download><img src=${imagefile} width="200" height="200"></a>
              </div>
              <small>
              ${image.name}<br>
              <span class="opacity-6"><i class="fa fa-calendar-alt mr-1"></i>
              ${image.time} | ${image.date}</span>
              </small>
              </div>
              <div style="width: 10%">
              <div class="avatar-icon-wrapper ml-1">
              <div class="badge badge-bottom btn-shine badge-success badge-dot badge-dot-lg"></div>
              <div class="avatar-icon avatar-icon-lg rounded image-circle"><img src=${image.image} alt="" class="img-fluid"></div>
              </div>
              </div>
              </div>`;
    } else if(image.type=='U') {
      content = `<div class="chat-box-wrapper">
              <div>
              <small>
              <!--$user.name -->${image.name}<br>
              <span class="opacity-6"><i class="fa fa-calendar-alt mr-1"></i>
              ${image.time} | ${image.date}</span>
              </small>
              <div class="bg-chat-left"><a href=${imagefile} target="_blank" download><img src=${imagefile} width="200" height="200"></a>
              </div>
              </div>
              </div>`;
    }
  document.querySelector('.chat-wrapper').innerHTML +=content;
}

function showMessage(message) {
    let content = '';
    message.text = message.text.replace(/\n/g, "<br> ");
    console.warn("show message in",message);
    if(message.type=='V') {
       content = `<div class="float-right chat-box-wrapper chat-box-wrapper-right">
              <div>
              <div class="chat-box"><p>${message.text}</p>
              </div>
              <small>
              ${message.name}<br>
              <span class="opacity-6"><i class="fa fa-calendar-alt mr-1"></i>
              ${message.time} | ${message.date}</span>
              </small>
              </div>
              <div>
              <div class="avatar-icon-wrapper ml-1">
              <div class="badge badge-bottom btn-shine badge-success badge-dot badge-dot-lg"></div>
              <div class="avatar-icon avatar-icon-lg rounded image-circle"><img src=${message.image} alt="" class="img-fluid"></div>
              </div>
              </div>
              </div>`;
    } else if(message.type=='U') {
      content = `<div class="chat-box-wrapper">
              <div>
              <small>
              <!--$user.name -->${message.name}<br>
              <span class="opacity-6"><i class="fa fa-calendar-alt mr-1"></i>
              ${message.time} | ${message.date}</span>
              </small>
              <div class="chat-box bg-chat-left"><p>${message.text}</p>
              </div>
              </div>
              </div>`;
    }
    document.querySelector('.chat-wrapper').innerHTML +=content;
}

$("#dispose").click(function(){
   //alert("call in chat scoket");
    /*console.error("talkTime>> ");
    console.error($("#talkTime").val());
    pause();
    $("#chat-form").css("display","none");
    lastcallajax();*/
    let reason = 'Consultation ended by the '+user.name;
    stopchat(reason);
    /*pause();
    let talkTime = $("#talkTime").val();
    let obj = {talkTime,type:user.type,reason:reason,room:user.room,requestid:user.requestId}; 
    socket.emit('stopchat',obj);*/
});

function stopchat(reason) {
  console.warn("reason",reason);
  pause();
  let talkTime = $("#talkTime").val();
  let obj = {talkTime,type:user.type,reason:reason,room:user.room,requestid:user.requestId}; 
  socket.emit('stopchat',obj);
}
// Timer code here...
 var h5 = document.getElementsByTagName('h5')[0],
 seconds = 0, minutes = 0, hours = 0, cron= '',
 t
 function timer() {
    seconds++;
    if (seconds >= 60) {
        seconds = 0;
        minutes++;
        }
        if (minutes >= 60) {
            minutes = 0;
            hours++;
        }
    let talkTimeVal = (hours ? (hours > 9 ? hours : "0" + hours) : "00") + ":" + (minutes ? (minutes > 9 ? minutes : "0" + minutes) : "00") + ":" + (seconds > 9 ? seconds : "0" + seconds);
    if(usertimepack!='' &&  talkTimeVal>usertimepack) {
      console.error("usertimepack>>",usertimepack);
      let reason = user.name+' has consultation time pack finished.';
      stopchat(reason);
    } 
    h5.textContent = "In consultation since " + (hours ? (hours > 9 ? hours : "0" + hours) : "00") + ":" + (minutes ? (minutes > 9 ? minutes : "0" + minutes) : "00") + ":" + (seconds > 9 ? seconds : "0" + seconds);
    $("#talkTime").val(talkTimeVal);
}

function start() {
  pause();
  cron = setInterval(() => { timer(); }, 1000);
}

function pause() {
  clearInterval(cron);
}

function lastcallajax() {
   
  var requestUrl = $("input[name$='endedCall']").val(); 

  var progress = $("<div title='" + _t("Loading") + "'>" +
      "<p style='text-align:center;font-size:1.6em'><br/>" +
      "<b>" + _t("Loading...") + "</b><br>" +
      "<img style=\"margin-top:10px;\" src=\"" + setting.siteRootUrl + "/templates/kinthia/images/loader.gif\"></p>" +
      "</div>")
      .dialog({ autoOpen: false, resizable: false, modal: false, draggable :false });
  progress.dialog("open");
  
  $.popup.open(
      requestUrl+'/'+user.requestId
  );
  setTimeout ( function(){
      progress.dialog("close");
  }, 800);  
}

window.addEventListener("offline", (event) => {
  pause();
  let talkTime = $("#talkTime").val();
  $("#chat-form").css("display","none");
  $( "#webcam-container" ). load(window. location. href + " #webcam-container" );  
  alert("Internet is disconnected, so request cannot be sent.");
});
