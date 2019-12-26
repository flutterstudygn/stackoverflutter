import 'package:firebase/firebase.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

class SignInManager {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final fb.Auth _auth = fb.auth(); //FirebaseAuth.instance;

  Future<fb.User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    final fb.OAuthCredential credential = fb.GoogleAuthProvider.credential(
      googleAuth.idToken,
      googleAuth.accessToken,
    );
    return signInFirebase(credential);
  }

  Future<fb.User> signInWithGithub() async {
    return null;
  }

  Future<fb.User> signInWithFacebook() async {
    return null;
  }

  Future<fb.User> signInFirebase(fb.OAuthCredential credential) async {
    final fb.UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential?.user;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
