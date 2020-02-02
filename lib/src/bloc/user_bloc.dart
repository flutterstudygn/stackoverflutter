import 'dart:async';

import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

class UserBloc {
  final StreamController<UserItem> _streamController = StreamController();
  Stream<UserItem> get stream => _streamController.stream;

  dispose() {
    _streamController.close();
  }

  Future<UserItem> readUserByUid(String uid) {
    UserApi.instance.readUserByUid(uid).then((result) {
      _streamController.add(result);
    });
  }
}