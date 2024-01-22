const users = [];
const requestusers = [];

// Connect User to server
function userConnect(socket_id,id,requestId) {

  let cont_user = '';
  const index = users.findIndex(user => user.id === id && (user.requestId===requestId && requestId>0));
  if (index !== -1) {
   users[index].socket_id=socket_id;
   cont_user = users[index];
  } else {
   cont_user = {socket_id,id,requestId};
   users.push(cont_user);  
  }
  console.log("userConnect",users);
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
  }
  /*console.log("users");
  console.log(users);*/
  return userdata;
}

// Get user by id
function getUserById(id) {
  return users.filter(user => user.id == id);
}

// Get current user
function getCurrentUser(socket_id) {
  return users.find(user => user.socket_id === socket_id);
}

// User leaves chat
function userLeave(socket_id,reason) {
  /*console.log(reason);
  console.log(users);
  console.log(socket_id);*/
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

module.exports = {
  userConnect,
  userJoin,
  getCurrentUser,
  userLeave,
  getRoomUsers,
  getUserById,
  userConnectionRequest,
  cancelConnectionRequest
};