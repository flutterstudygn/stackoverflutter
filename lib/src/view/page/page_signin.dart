import 'package:flutter/material.dart';

import '../global_layout.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/users/signin',
      body: Center(
        child: Text('Sign In'),
      ),
    );
  }
}
