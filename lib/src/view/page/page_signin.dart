import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

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
          SignInButton(Buttons.Google, onPressed: () async {
            UserItem result =
                await sessionBloc.signInWithProvider(SignInProvider.GOOGLE);
            if (result != null) {
              Navigator.of(context).pushNamed('/');
            }
          }),
          SizedBox(height: 10.0),
          SignInButton(Buttons.GitHub, onPressed: () async {
            UserItem result =
                await sessionBloc.signInWithProvider(SignInProvider.GITHUB);
            if (result != null) {
              Navigator.of(context).pushNamed('/');
            }
          }),
          SizedBox(height: 10.0),
          SignInButton(Buttons.Facebook, onPressed: () async {
            UserItem result =
                await sessionBloc.signInWithProvider(SignInProvider.FACEBOOK);
            if (result != null) {
              Navigator.of(context).pushNamed('/');
            }
          }),
        ],
      ),
    );
  }
}
