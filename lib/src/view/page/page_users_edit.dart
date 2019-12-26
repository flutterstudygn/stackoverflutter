import 'package:flutter/cupertino.dart';

import '../global_layout.dart';

class UsersEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/users/edit',
      body: Text('users edit'),
    );
  }
}
