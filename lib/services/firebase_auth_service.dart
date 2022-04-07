import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/services/auth_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//todo facebook giriş

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserM?> currentUser() async {
    try {
      User? user = await _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      print("Hata Current User" + e.toString());
      return null;
    }
  }

  UserM? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return UserM(userId: user.uid, email: user.email!);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out hata:" + e.toString());
      return false;
    }
  }

/*   @override
  Future<UserM?> singInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("Anonim giriş hata" + e.toString());
      return null;
    }
  } */

  @override
  Future<UserM?> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        ));
        User? _user = sonuc.user;
        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserM?> createUserWithEmailandPassword(
      String email, String password) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(sonuc.user);
  }

  @override
  Future<UserM?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("Firebase oturum açma hata" + e.toString());
      return null;
    }
  }
}
