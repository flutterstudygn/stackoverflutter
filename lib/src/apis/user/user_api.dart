import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:stackoverflutter/src/model/user/user_detail_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

class UserApi {
  UserApi._() : super();
  static UserApi _instance;

  static UserApi get instance => _instance ??= UserApi._();

  Future<UserItem> readUserByUid(String uid) async {
    DocumentSnapshot snapshot;

    try {
      snapshot = await firestore().collection('users').doc(uid).get();
    } catch (_) {
      rethrow;
    }

    if (snapshot.exists) {
      return UserItem.fromJson(snapshot.data())..userId = snapshot.id;
    } else {
      throw Exception('Firestore snapshot for user id = $uid doesn\'t exists.');
    }
  }

  Future<UserItem> createUser(UserItem userItem) {
    return firestore()
        .collection('users')
        .doc(userItem.userId)
        .set(userItem.toJson())
        .then((_) {
      return userItem;
    });
  }

  Future<UserDetailItem> readUserActivities(String uid) {
    return Future.delayed(Duration(milliseconds: 750), () {
      return UserDetailItem(
        articleCount: 12,
        questionCount: 12,
        answerCount: 12,
        startCount: 12,
      );
    });
  }
}
