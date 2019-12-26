import 'package:firebase/firebase.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

class UserApi {
  UserApi._() : super();
  static UserApi _instance;

  static UserApi get instance {
    if (_instance == null) {
      _instance = UserApi._();
    }
    return _instance;
  }

  Future<UserItem> readUserByUid(String uid) {
    return firestore().collection('users').doc('uid').get().then((v) {
      if (v.data() != null) {
        return UserItem.fromJson(v.data())..id = v.id;
      }
      return null;
    }).catchError((_) {
      return null;
    });
  }

  Future<UserItem> createUser(UserItem userItem) {
    return firestore()
        .collection('users')
        .doc(userItem.id)
        .set(userItem.toJson())
        .then((_) {
      return userItem;
    });
  }
}
