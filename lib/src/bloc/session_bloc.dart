import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/manager/signin_manager.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

enum SignInProvider {
  GOOGLE,
  GITHUB,
  FACEBOOK,
}

class SessionBloc extends ChangeNotifier {
  final SignInManager _signInManager = SignInManager();
  UserItem _currentUser;

  UserItem get currentUser => _currentUser;
  set currentUser(UserItem value) {
    _currentUser = value;
    notifyListeners();
  }

  Future<UserItem> signInWithProvider(SignInProvider provider) async {
    User firebaseUser;
    switch (provider) {
      case SignInProvider.GOOGLE:
        firebaseUser = await _signInManager.signInWithGoogle();
        break;
      case SignInProvider.GITHUB:
        firebaseUser = await _signInManager.signInWithFacebook();
        break;
      case SignInProvider.FACEBOOK:
        firebaseUser = await _signInManager.signInWithGithub();
        break;
    }
    if (firebaseUser != null) {
      return UserApi.instance.readUserByUid(firebaseUser.uid).then((v) {
        if (v == null) {
          return _createUser(firebaseUser);
        }
        return v;
      }).catchError((_) {
        return _createUser(firebaseUser);
      });
    }
    return _currentUser;
  }

  Future<UserItem> _createUser(User firebaseUser) async {
    currentUser =
        await UserApi.instance.createUser(UserItem.firebaseUser(firebaseUser));
    return currentUser;
  }

  Future<void> signOut() async {
    await _signInManager.signOut();
    currentUser = null;
  }
}
