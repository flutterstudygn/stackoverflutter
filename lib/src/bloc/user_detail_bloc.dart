import 'dart:async';

import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/model/user/user_detail_item.dart';

class UserDetailBloc {
  final StreamController<UserDetailItem> _activitiesStream = StreamController();

  Stream<UserDetailItem> get activities => _activitiesStream.stream;

  String uid;

  init(String uid) {
    this.uid = uid;
    loadUserActivities();
  }

  dispose() {
    _activitiesStream?.close();
  }

  Future<UserDetailItem> loadUserActivities() {
    return UserApi.instance.readUserActivities(uid).then((v) {
      _activitiesStream.add(v);
      return v;
    });
  }
}
