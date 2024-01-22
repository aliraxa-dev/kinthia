const fs = require("fs");
const httpServer = require("http").createServer({
    //key: fs.readFileSync('/etc/ssl/private/nginx-selfsigned.key'),
    //cert: fs.readFileSync('/etc/ssl/certs/nginx-selfsigned.crt'),
    requestCert: true,
    rejectUnauthorized: false
});
const io = require("socket.io")(httpServer, {
 cors: {
    origin: '*',
  }  
  // ...
});
const formatMessage = require('./utils/messages');
const {
  userConnect,
  userJoin,
  getCurrentUser,
  userLeave,
  getRoomUsers,
  getUserById,
  userConnectionRequest,
  cancelConnectionRequest
} = require('./utils/users');
const path = require('path');
const mysql      = require('mysql');
const connection = mysql.createConnection({
  host     : 'localhost',
  // user     : 'admin',
  // password : 'Alea001!!',
  user     : 'root',
  password : '',
  database : 'aleadev_voyance_server'
});
const moment = require('moment');
const socket_stream = require('socket.io-stream');


connection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }
  //console.log('connected as id ' + connection.threadId);
});



// Run when client connects
io.on('connection',socket=>{
  
  const requestId =  socket.handshake.query.requestid;
  const result = userConnect(socket.id, socket.handshake.query.find,requestId);
  //console.log(result.socket_id+' >>> User >> '+result.id+' >>> request >>'+requestId);

  // If Request Id 
  if(requestId>0) {
    connection.query('SELECT  * from  kinthiavoyance_userconsultations where `userconsultationId`= ? ',[requestId], function (error, results, fields) {
          if (error) throw error;
          if(results[0].status=='A' && results[0].reason=='' && results[0].start_time!=null) {
              console.log(results);
            let voyantrecord = getUserById(results[0].voyantId);
            let userrecord = getUserById(results[0].userId);
            if(voyantrecord.length>0 && userrecord.length>0) {
              console.log("Get connected again.");
              //userConnectionRequest(results[0].userId,results[0].voyantId);
              io.to(voyantrecord[0].socket_id).emit("send-again-request");
              io.to(userrecord[0].socket_id).emit("send-again-request");   
            } else {
              console.log("Get Not connected.");
            }
          } else {
            console.log("Not connected....");
          }         
        });
  } 

  socket_stream(socket).on('file', function(stream, data) {
    
    data.name = data.name.replace(/ /g, "_");  
    const filename = __dirname+'/uploads/chat/'+data.name;
    stream.pipe(fs.createWriteStream(filename));
    stream.on('end', function () {

     const user = getCurrentUser(socket.id);
    let receiver = getRoomUsers(user.room,user.socket_id);
    let userId = voyantId = '';
    let userName = voyantName = '';
    
    if(user.type=='U') {
      userId = user.id;
      userName = user.name;
    }
    else {
      voyantId = user.id;
      voyantName = user.name;
    }

    if(receiver.type=='U'){
      userId = receiver.id;
      userName = receiver.name;
    }
    else {
      voyantId = receiver.id;
      voyantName = receiver.name;
    }

    connection.query('INSERT INTO kinthiavoyance_voyantchats SET ?', {voyantId: voyantId,userId: userId,voyantname:voyantName,username:userName,image: data.name,sendby:user.type,room_name: user.room,userconsultationId:user.requestId}, (error, results, fields) => {
     if (error) throw error;
      io.to(user.room).emit('image',formatMessage(user.name,user.type,user.image,data.name));
    }); 
    
    
    });

  });

  // Expert Request...
  socket.on('expert-request',(requestdata,callback)=>{
    
    console.log("expert-request send");
    let expertdetail = getUserById(requestdata.voyantId);
    //console.log("expert data",expertdetail);
    
    if (expertdetail.length==0) {

        connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=? WHERE userconsultationId = ?', ['C','O','Expert is not online',requestdata.requestId], function (error, results, fields) {
          if (error) throw error;
          callback({
              status: "N",
              msg: "Expert is not online."
            });
        }); 
    } else if(expertdetail.length>0) {

      for(let i = 0; i < expertdetail.length; i++) {
        io.to(expertdetail[i].socket_id).emit("send-request",requestdata.requestId);
      }
      callback({
        status: "Y",
        msg:"Request sent to expert, please wait for response."
      });  
    }
  });

  // Expert Accept Request and start consultaion...
  socket.on('expert-accept-request',(requestdata, callback) => {
    console.log("expert-accept-request");
    console.log("requestdata>>>",requestdata);
    let userdetail = getUserById(requestdata.userrequestId);
    if (userdetail.length==0) {
        callback({
          status: "N",
          msg: "User is not online."
        });
    } else if(userdetail.length>0) {
        connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, room = ? WHERE userconsultationId = ?', ['A', requestdata.room, requestdata.requestId], function (error, results, fields) {
          if (error) throw error;
          requestdata.socket_id = socket.id;
          const user = userJoin(requestdata);
          socket.join(user.room);
          for (let i = 0; i < userdetail.length; i++) {
            io.to(userdetail[i].socket_id).emit("send-information",{msg:"Expert Accept Request and join room",status:true});
          }
        });  
    }
  });

  // Expert Cancel Request...
  socket.on('expert-cancel-request',(requestdata, callback) => {
    console.log("expert-cancel-request");
    console.log("requestdata>>>",requestdata);

    let userdetail = getUserById(requestdata.userId);

      connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=? WHERE userconsultationId = ?', ['C','V',requestdata.requestId], function (error, results, fields) {
          if (error) throw error;
        connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ? WHERE voyantId = ?', ['ON',requestdata.voyantId], function (error, results, fields) {
            if (error) throw error;
        });  
      });

    if (userdetail.length==0) {
        callback({
          status: 'N',
          msg: "User is not online."
        });
    } else if(userdetail.length>0) {
          for (let i = 0; i < userdetail.length; i++) {
            io.to(userdetail[i].socket_id).emit("send-information",{msg:"Expert Cancel Request",status:false});
          }
          // let expertdetail = getCurrentUser(socket.id);
          //cancelConnectionRequest(requestdata.userId,expertdetail.id);
          callback({
            status: 'Y'
          });
    }
  });
   
  // Join Room Again.... 
  socket.on('joinRoomAgain', (userdata) => {
    console.log("join room again");
    userdata.socket_id = socket.id;
    const user = userJoin(userdata);
    socket.join(user.room);
  });

  // Join Room....
  socket.on('joinRoom', (userdata) => {
    console.log("join room");
    userdata.socket_id = socket.id;
    const user = userJoin(userdata);
    socket.join(user.room);
    
    // Imp Code... 
    connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ?, consultationTime=? WHERE voyantId = ?', ['B',moment().format('YYYY-MM-DD h:mm:ss'),user.voyantId], function (error, results, fields) {
     if (error) throw error;
        connection.query('UPDATE kinthiavoyance_userconsultations SET start_time = ? WHERE userconsultationId = ?', [moment().format('YYYY-MM-DD h:mm:ss'),user.requestId], function (error, results, fields) {
            if (error) throw error;
            console.log("update start time",results);
            io.to(user.room).emit('chat-start',{msg:'Start Chat',consultationType:user.consultationType});
        }); 
    });
      // connection.query('UPDATE kinthiavoyance_userconsultations SET start_time = ? WHERE userconsultationId = ?', [moment().format('YYYY-MM-DD h:mm:ss'),user.requestId], function (error, results, fields) {
      //     if (error) throw error;
      //     console.log("update start time",results);
      //     io.to(user.room).emit('chat-start',{msg:'Start Chat',consultationType:user.consultationType});
      // });

  });

  // Listen for chatMessage
  socket.on('chatMessage', msg => {
    const user = getCurrentUser(socket.id);
    let receiver = getRoomUsers(user.room,user.socket_id);
    let userId = voyantId = '';
    let userName = voyantName = '';

    if(user.type=='U') {
      userId = user.id;
      userName = user.name;
    }
    else {
      voyantId = user.id;
      voyantName = user.name;
    }

    if(receiver.type=='U'){
      userId = receiver.id;
      userName = receiver.name;
    }
    else {
      voyantId = receiver.id;
      voyantName = receiver.name;
    }

    connection.query('INSERT INTO kinthiavoyance_voyantchats SET ?', {voyantId: voyantId,userId: userId,voyantname:voyantName,username:userName,text: msg,sendby:user.type,room_name: user.room,userconsultationId:user.requestId}, (error, results, fields) => {
     if (error) throw error;
      io.to(user.room).emit('chat-message', formatMessage(user.name,user.type,user.image,msg));
    });

  });

  // Runs when client disconnects
  socket.on('disconnect', (reason) => {
      console.log("disconnect");
      console.log(reason);
      const user = userLeave(socket.id,reason);
      console.log("user disconnect >>",user);
      if((reason=='ping timeout' || reason=='transport close') && (typeof user.requestId !== "undefined")) {
        
        if(user.requestId>0) {
        let receiver = getRoomUsers(user.room,user.socket_id);
        console.log(receiver);
        if (typeof receiver !== "undefined") {
         reason = user.name+' disconnected';
         connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=?, end_time = ? WHERE userconsultationId = ?', ['E',user.type,reason,moment().format('YYYY-MM-DD h:mm:ss'),user.requestId], function (error, results, fields) {
          if (error) throw error;
            io.to(receiver.socket_id).emit('disconnect-another',{msg:reason});
         }); 
         let voyantId = 0;  
         if(user.type=='U')
           voyantId =user.voyantId;
          else if(user.type=='V') 
            voyantId =user.id; 
          // Neer applied here... 
          connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ?, consultationTime=? WHERE voyantId = ?', ['ON',null,voyantId], function (error, results, fields) {
            if (error) throw error;
          }); 

        }
       } 

      }
  });

  socket.on('stopchat',(requestdata) => {
    console.log('stop chat');    
    connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, duration=?, reason=?, end_time = ? WHERE userconsultationId = ?', ['E',requestdata.type,requestdata.talkTime,requestdata.reason,moment().format('YYYY-MM-DD h:mm:ss'),requestdata.requestid], function (error, results, fields) {
          if (error) throw error;
          let user = getCurrentUser(socket.id);
          let receiver = getRoomUsers(user.room,user.socket_id);
          
          let voyantId = 0;  
          if(user.type=='U')
           voyantId =user.voyantId;
          else if(user.type=='V') 
            voyantId =user.id; 
        
          // Neer applied here... 
          connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ?, consultationTime=? WHERE voyantId = ?', ['ON',null,voyantId], function (error, results, fields) {
            if (error) throw error;
          }); 

          io.to(requestdata.room).emit('leave-message','closed connection');
        });
  });

  socket.on('image', async image => {
    const buffer = Buffer.from(image.base64, 'base64');
    image.imageName = image.imageName.replace(/ /g, "_");  
    const filename = __dirname+'/uploads/chat/'+image.imageName;
    await fs.writeFile(filename, buffer,(err) => { 
                if (err) { 
                  console.log(err); 
                } 
              }); // fs.promises
    const user = getCurrentUser(socket.id);
    let receiver = getRoomUsers(user.room,user.socket_id);
    let userId = voyantId = '';
    let userName = voyantName = '';
    
    if(user.type=='U') {
      userId = user.id;
      userName = user.name;
    }
    else {
      voyantId = user.id;
      voyantName = user.name;
    }

    if(receiver.type=='U'){
      userId = receiver.id;
      userName = receiver.name;
    }
    else {
      voyantId = receiver.id;
      voyantName = receiver.name;
    }

    connection.query('INSERT INTO kinthiavoyance_voyantchats SET ?', {voyantId: voyantId,userId: userId,voyantname:voyantName,username:userName,image: image.imageName,sendby:user.type,room_name: user.room,userconsultationId:user.requestId}, (error, results, fields) => {
     if (error) throw error;
      io.to(user.room).emit('image',formatMessage(user.name,user.type,user.image,image.imageName));
    });
  });

});
const PORT = 5000 || process.env.PORT;
httpServer.listen(PORT, ()=> console.log(`Server running on port ${PORT}`));
