const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.helloWorld = functions.https.onRequest((request, response) => {
    response.set("Access-Control-Allow-Origin", "http://localhost:8686");
    response.send("Hello from Firebase!");
});
