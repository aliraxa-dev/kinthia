const fs = require("fs");
const httpServer = require("https").createServer({
    //key: fs.readFileSync('/etc/ssl/private/nginx-selfsigned.key'),
    //cert: fs.readFileSync('/etc/ssl/certs/nginx-selfsigned.crt'),
    key: fs.readFileSync('/etc/ssl/private/ssl-cert-snakeoil.key'),
    cert: fs.readFileSync('/etc/ssl/certs/ca-certificates.crt'),
    requestCert: true,
    rejectUnauthorized: false
});
const io = require("socket.io")(httpServer, {
 cors: {
    origin: '*',
  }  
  // ...
});
const formatMessage = require('../var/www/preprod/public_html/utils/messages');
const {
  userConnect,
  userJoin,
  getCurrentUser,
  userLeave,
  getRoomUsers,
  getUserById,
  userConnectionRequest,
  cancelConnectionRequest,
  getUserByRequestId,
  cancelUserByRequestId,
  totalUser,
  updateUserByRequestId
} = require('../var/www/preprod/public_html/utils/users');
const path = require('path');
const mysql      = require('mysql');
// const connection = mysql.createConnection({
//   host     : 'localhost',
//   user     : 'admin',
//   password : 'Alea001!!',
//   // user     : 'root',
//   // password : '',
//   database : 'aleadev_voyance_server'
// });
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'admin',
  password : 'CRTemporal2k20CR',
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
  
  //const requestId =  socket.handshake.query.requestid;
  // console.log("Rahul >>>");
  // console.log(socket.handshake.query);
  const {requestId,status,type,find} = socket.handshake.query;
  const result = userConnect(socket.id,find,requestId,status,type);
  //const result = userConnect(socket.id, socket.handshake.query.find,requestId);
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
   
  // User and Expert register for chat ..
  socket.on('register_in_chat', data=>{
      console.log('register_in_chat>>',data.id);
      data.socket_id = socket.id;
      data.socket = socket;
      const expert_user = userJoin(data);
    }); 



  socket_stream(socket).on('file', function(stream, data) {
    
    data.name = data.name.replace(/ /g, "_");  
    const filename = __dirname+'./var/www/preprod/public_html/uploads/chat/'+data.name;
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
        setVoyantOffLine(requestdata.voyantId,'OF');    
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

      connection.query('SELECT  * from  kinthiavoyance_settings where `key`= ? limit 0,1',['consultation_waiting_time'], function (error, results, fields) {
        if (error) throw error;{
          checkVoyantResponse(requestdata.requestId,results[0].value);
        }
      });
    }
  });

  // Expert Accept Request and start consultaion...
  socket.on('expert-accept-request',(requestdata, callback) => {
    let userdetail = getUserById(requestdata.userrequestId);
    if (userdetail.length==0) {
        callback({
          status: "N",
          msg: "User is not online."
        });
    } else if(userdetail.length>0) {
       for (let i = 0; i < userdetail.length; i++) {
            io.to(userdetail[i].socket_id).emit("send-user-for-accept",{msg:"Expert Accept Request and join room",status:true});
            /*io.to(userdetail[i].socket_id).emit("send-information",{msg:"Expert Accept Request and join room",status:true});*/
          }  
        callback({
          status: "Y",
          msg: "Please wait for response from user"
        });  
        // connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, room = ? WHERE userconsultationId = ?', ['A', requestdata.room, requestdata.requestId], function (error, results, fields) {
        //   if (error) throw error;
        //   requestdata.socket_id = socket.id;
        //   const user = userJoin(requestdata);
        //   socket.join(user.room);
        //   for (let i = 0; i < userdetail.length; i++) {
        //     io.to(userdetail[i].socket_id).emit("send-information",{msg:"Expert Accept Request and join room",status:true});
        //   }
        // });

    }
  });


  // Expert Cancel Request...
  socket.on('cancel-request',(requestdata, callback) => {
    
    let reason = msg = '';
    let userdetail ='';
    if(requestdata.usertype=='U') {
     userdetail = getUserById(requestdata.voyantId);  
     reason = 'User cancel request';
     msg = 'User is not online';
    } else {
     userdetail = getUserById(requestdata.userId); 
     reason = 'Expert cancel request';
     msg = 'Expert is not online';
    }
    
    //console.log(" cancel-request userdetail >>>",userdetail);

    connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=? WHERE userconsultationId = ?', ['C',requestdata.usertype,reason,requestdata.requestId], function (error, results, fields) {
          if (error) throw error;
      connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ? WHERE voyantId = ?', ['ON',requestdata.voyantId], function (error, results, fields) {
          if (error) throw error;
      });  
    });

    cancelUserByRequestId(requestdata.requestId);

    if (userdetail.length==0) {
        callback({
          status: 'N',
          msg: msg
        });
    } else if(userdetail.length>0) {
          for (let i = 0; i < userdetail.length; i++) {
            io.to(userdetail[i].socket_id).emit("send-information",{msg:reason,status:false});
          }
          // let expertdetail = getCurrentUser(socket.id);
          callback({
            status: 'Y'
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
    //console.log("join room again");
    userdata.socket_id = socket.id;
    const user = userJoin(userdata);
    socket.join(user.room);
    updateUserByRequestId(userdata.requestId);
  });

  // Join Room....
  socket.on('joinRoom', (requestId) => {
    
    let requestuserdetail = getUserByRequestId(requestId);    
    let voyantId = 0;
    let consultationtype = '';
    if(requestuserdetail.length>0 && requestuserdetail.length==2) {

      for(let i = 0; i < requestuserdetail.length; i++) {
        let socket_var = requestuserdetail[i].socket;
        socket_var.join(requestuserdetail[i].room); 
        if(requestuserdetail[i].type=='V')
        {
           voyantId = requestuserdetail[i].id;
        }
        consultationtype = requestuserdetail[i].consultationType;
      }
     // Imp Code... 
    connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ?, consultationTime=? WHERE voyantId = ?', ['B',moment().format('YYYY-MM-DD h:mm:ss'),voyantId], function (error, results, fields) {
     if (error) throw error;
        connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?,start_time = ? WHERE userconsultationId = ?', ['A',moment().format('YYYY-MM-DD h:mm:ss'),requestId], function (error, results, fields) {
            if (error) throw error;
            //console.log("update start time",results);
            updateUserByRequestId(requestId);
            io.to(requestuserdetail[0].room).emit('chat-start',{msg:'Start Chat',consultationType:consultationtype});
        }); 
    });

    }

  });

  // Join Room....
  // socket.on('joinRoom', (userdata) => {
  //   console.log("join room");
  //   userdata.socket_id = socket.id;
  //   const user = userJoin(userdata);
  //   socket.join(user.room);
    
  //   // Imp Code... 
  //   connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ?, consultationTime=? WHERE voyantId = ?', ['B',moment().format('YYYY-MM-DD h:mm:ss'),user.voyantId], function (error, results, fields) {
  //    if (error) throw error;
  //       connection.query('UPDATE kinthiavoyance_userconsultations SET start_time = ? WHERE userconsultationId = ?', [moment().format('YYYY-MM-DD h:mm:ss'),user.requestId], function (error, results, fields) {
  //           if (error) throw error;
  //           console.log("update start time",results);
  //           io.to(user.room).emit('chat-start',{msg:'Start Chat',consultationType:user.consultationType});
  //       }); 
  //   });
  //     // connection.query('UPDATE kinthiavoyance_userconsultations SET start_time = ? WHERE userconsultationId = ?', [moment().format('YYYY-MM-DD h:mm:ss'),user.requestId], function (error, results, fields) {
  //     //     if (error) throw error;
  //     //     console.log("update start time",results);
  //     //     io.to(user.room).emit('chat-start',{msg:'Start Chat',consultationType:user.consultationType});
  //     // });

  // });

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
      const user = userLeave(socket.id,reason);
      if((reason=='ping timeout' || reason=='transport close') && (typeof user.requestId !== "undefined")) {
        
        if(user.requestId>0) {
        let receiver = getRoomUsers(user.room,user.socket_id);
        if (typeof receiver !== "undefined") {
         reason = user.name+' disconnected';
         if(user.status=='A') {
            connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=?, end_time = ? WHERE userconsultationId = ?', ['E',user.type,reason,moment().format('YYYY-MM-DD h:mm:ss'),user.requestId], function (error, results, fields) {
              if (error) throw error;
                io.to(receiver.socket_id).emit('disconnect-another',{msg:reason});
            });
         } else  {
           connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=? WHERE userconsultationId = ?', ['C',user.type,reason,user.requestId], function (error, results, fields) {
              if (error) throw error;
                io.to(receiver.socket_id).emit('disconnect-another',{msg:reason});
            });
         }
         // connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=?, end_time = ? WHERE userconsultationId = ?', ['E',user.type,reason,moment().format('YYYY-MM-DD h:mm:ss'),user.requestId], function (error, results, fields) {
         //  if (error) throw error;
         //    io.to(receiver.socket_id).emit('disconnect-another',{msg:reason});
         // }); 
         let voyantId = 0;  
         if(user.type=='U')
           voyantId =user.voyantId;
          else if(user.type=='V') 
            voyantId =user.id; 
          // Neer applied here... 
          connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ?, consultationTime=? WHERE voyantId = ?', ['ON',null,voyantId], function (error, results, fields) {
            if (error) throw error;
          }); 

        } else if(user.type=='U' && user.requestId>0) {
            reason = user.name+' disconnected';
            connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=? WHERE userconsultationId = ?', ['C',user.type,reason,user.requestId], function (error, results, fields) {
                if (error) throw error;
            });
            setVoyantOffLine(user.voyantId,'ON');
            let expertdetail = getUserById(user.voyantId);
            if(expertdetail.length>0) {
              for(let i = 0; i < expertdetail.length; i++) {
                io.to(expertdetail[i].socket_id).emit("user-cancel-request",reason);
              }  
            }
            
         }
       } 
         totalUser();
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
    const filename = __dirname+'./var/www/preprod/public_html/uploads/chat/'+image.imageName;
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

  function checkVoyantResponse(requestId,timeout) {
    let timeout_set = timeout*1000;
    
    setTimeout(function() {
     connection.query('SELECT  * from  kinthiavoyance_userconsultations where `userconsultationId`= ? ',[requestId], function (error, results, fields) {
        if (error) throw error;
        if(results[0].status=='P') {
          let reason='Sorry, the expert you wish to consult could not answer. You can try again later or choose another expert.';
            connection.query('UPDATE kinthiavoyance_userconsultations SET status = ?, ended_by=?, reason=? WHERE userconsultationId = ?', ['C','O',reason,requestId], function (error, results, fields) 
            {
              if (error) throw error;
            });
          let userrecord = getUserById(results[0].userId);
          let expertdetail = getUserById(results[0].voyantId);
          if(userrecord.length>0) {
            io.to(userrecord[0].socket_id).emit('user-cancel-request',{msg:reason});  
          }
          if(expertdetail.length>0) {
            for(let i = 0; i < expertdetail.length; i++) {
              io.to(expertdetail[i].socket_id).emit("user-cancel-request","Request has cancel");
            }  
            setVoyantOffLine(results[0].voyantId,'ON');
          }
          else {
            setVoyantOffLine(results[0].voyantId,'OF');
          }  
        } 
      });  
    }, timeout_set,requestId);
  }

});

function setVoyantOffLine(voyantId,status) {
  connection.query('UPDATE kinthiavoyance_voyants SET consultationStatus = ?, consultationTime=? WHERE voyantId = ?', [status,null,voyantId], function (error, results, fields) {
      if (error) throw error;
    }); 
}

const PORT = 5000 || process.env.PORT;
httpServer.listen(PORT, ()=> console.log(`Server running on port ${PORT}`));
