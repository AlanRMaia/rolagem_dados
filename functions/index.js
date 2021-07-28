const functions = require("firebase-functions");

const admin = require('firebase-admin');

admin.initializeApp();

exports.createMsg = functions.firestore
    .document('rooms/{roomId}/messages/{msgId}')    
    .onCreate((snap, context) => {
      admin.messaging().sendToTopic('sala', {
          notification: {  
              title: 'sala: ' + snap.data().roomName + ' - ' + snap.data().senderName,
              body: snap.data().text,
              clickAction: 'FLUTTER_NOTIFICATION_CLICK',              
          }
      })
    });

