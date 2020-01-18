const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.onArticlesChildUpdate = functions.firestore
  .document('articles/{articleId}/{type}/{itemId}')
  .onWrite((change, context) => {
    const db = admin
      .firestore()
      .collection('articles')
      .doc(context.params.articleId);
    db.collection(context.params.type)
      .get()
      .then(snapshot => {
        const count =
          snapshot && snapshot.size && !isNaN(snapshot.size)
            ? snapshot.size
            : 0;
        if(context.params.type == 'comments') {
            db.update({ commentCount: count });
        } else if(context.params.type == 'likes') {
            db.update({ likeCount: count });
        }
      });
  });


exports.onQuestionsChildUpdate = functions.firestore
  .document('questions/{articleId}/{type}/{itemId}')
  .onWrite((change, context) => {
    const db = admin
      .firestore()
      .collection('questions')
      .doc(context.params.articleId);
    db.collection(context.params.type)
      .get()
      .then(snapshot => {
        const count =
          snapshot && snapshot.size && !isNaN(snapshot.size)
            ? snapshot.size
            : 0;
        if(context.params.type == 'comments') {
            db.update({ commentCount: count });
        } else if(context.params.type == 'likes') {
            db.update({ likeCount: count });
        }
      });
  });
