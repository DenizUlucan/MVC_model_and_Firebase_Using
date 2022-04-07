import 'package:chat_app/model/UserM.dart';

abstract class AuthBase {
  Future<UserM?> currentUser();
  //Future<UserM?> singInAnonymously();
  Future<bool> signOut();
  Future<UserM?> signInWithGoogle();
  Future<UserM?> signInWithEmailandPassword(String email, String password);
  Future<UserM?> createUserWithEmailandPassword(String email, String password);
}
