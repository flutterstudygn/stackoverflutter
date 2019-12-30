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

  SessionBloc() {
    Future.delayed(Duration.zero, () {
      User firebaseUser = _signInManager.currentFirebaseUser();
      if (firebaseUser?.uid?.isNotEmpty == true) {
        _readOrCreateUser(firebaseUser);
      }
    });
  }

  UserItem _currentUser;
  bool get isSignedIn => _currentUser != null;
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
    return await _readOrCreateUser(firebaseUser);
  }

  Future<UserItem> _readOrCreateUser(User firebaseUser) async {
    UserItem signInResult;
    try {
      signInResult = await UserApi.instance.readUserByUid(firebaseUser.uid);
    } catch (_) {}

    if (signInResult == null) {
      signInResult = await _createUser(firebaseUser);
    }
    currentUser = signInResult;
    return _currentUser;
  }

  Future<UserItem> _createUser(User firebaseUser) async {
    return await UserApi.instance
        .createUser(UserItem.firebaseUser(firebaseUser));
  }

  Future<void> signOut() async {
    await _signInManager.signOut();
    currentUser = null;
  }
}
