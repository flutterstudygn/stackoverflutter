import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';

import '../global_layout.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SessionBloc sessionBloc = Provider.of<SessionBloc>(context);
    return GlobalLayout(
      path: '/users/signin',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SignInButton(
            Buttons.Google,
            onPressed: () =>
                sessionBloc.signInWithProvider(SignInProvider.GOOGLE),
          ),
          SizedBox(height: 10.0),
          SignInButton(
            Buttons.GitHub,
            onPressed: () =>
                sessionBloc.signInWithProvider(SignInProvider.GITHUB),
          ),
          SizedBox(height: 10.0),
          SignInButton(
            Buttons.Facebook,
            onPressed: () =>
                sessionBloc.signInWithProvider(SignInProvider.FACEBOOK),
          ),
        ],
      ),
    );
  }
}
