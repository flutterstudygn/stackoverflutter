import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';
import 'package:stackoverflutter/src/view/global_layout.dart';

class UserDetailPage extends StatelessWidget {
  final UserItem userItem;
  const UserDetailPage(this.userItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/users?id=',
      body: Text(userItem?.name ?? ''),
    );
  }
}
