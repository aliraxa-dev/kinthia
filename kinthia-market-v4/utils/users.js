const users = [];
const requestusers = [];

// Connect User to server
function userConnect(socket_id,id,requestId,status,type) {
  let cont_user = '';
  const index = users.findIndex(user => user.id === id && (user.requestId===requestId && requestId>0));
  if (index !== -1) {
   users[index].socket_id=socket_id;
   cont_user = users[index];
  } else {
   cont_user = {socket_id,id,requestId,status,type};
   users.push(cont_user);  
  }
 // console.log("userConnect",users);
  return cont_user;
}

// Save Connection request data
function userConnectionRequest(senderId,receiverId){
  let result = requestusers.find(user => user.receiverId === receiverId);
   // console.log(result);
  if (typeof result === "undefined") {
    const cont_user = {senderId,receiverId};
    requestusers.push(cont_user);
    return 0;
  } else {
    return 1;
  }
}

// Cancel Connection data
function cancelConnectionRequest(senderId,receiverId) {
  const index = requestusers.findIndex(user => user.receiverId === receiverId && user.senderId === senderId);
  if (index !== -1) {
    requestusers.splice(index, 1);
    return 1; 
  }
  return 0;
}

// Join user to chat
function userJoin(userdata) {
  const index = users.findIndex(user => user.socket_id === userdata.socket_id);
// console.log(index);
  if (index !== -1) {
    users.splice(index, 1,userdata);
  } else {
    users.push(userdata);
  }
  /*console.log("users");
  console.log(users);*/
  return userdata;
}

// Get user by id
function getUserById(id) {
  return users.filter(user => user.id == id);
}

// Get user by requestid
function getUserByRequestId(requestid) {
  return users.filter(user => user.requestId == requestid);
}

function cancelUserByRequestId(requestid) {
  let cancelUserDetail = getUserByRequestId(requestid);
    if(cancelUserDetail.length>0) {
      for(let i = 0; i < cancelUserDetail.length; i++) {
        const index = users.findIndex(user => user.id === cancelUserDetail[i].id && (user.requestId===cancelUserDetail[i].requestId && cancelUserDetail[i].requestId>0));
        users[index].requestId=0;
      }
    }
}

function updateUserByRequestId(requestid) {
  let updateUserDetail = getUserByRequestId(requestid);
    if(updateUserDetail.length>0) {
      for(let i = 0; i < updateUserDetail.length; i++) {
        const index = users.findIndex(user => user.id === updateUserDetail[i].id && (user.requestId===updateUserDetail[i].requestId && updateUserDetail[i].requestId>0));
        users[index].status='A';
      }
    }
}

// Get current user
function getCurrentUser(socket_id) {
  //console.log("getCurrentUser",users);
  return users.find(user => user.socket_id === socket_id);
}

// User leaves chat
function userLeave(socket_id,reason) {
   /*console.log(socket_id);*/
  /*console.log(reason);
  console.log(users); */
  /*console.log("userLeave");
  console.log(users);*/
  const index = users.findIndex(user => user.socket_id === socket_id);
  //console.log(index);
  if(reason=='client namespace disconnect' || reason=='ping timeout' || reason=='transport close') {
    if (index !== -1) {
      return users.splice(index, 1)[0];
     }
  }
}

// Get room users
function getRoomUsers(room,socket_id) {
  return users.find(user => user.room === room && user.socket_id != socket_id);
}

function totalUser() {
  console.log("Total_User >>",users.length);
}

module.exports = {
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
};