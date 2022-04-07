import 'package:chat_app/model/UserM.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userid = "12342343234543";
  @override
  Future<UserM> currentUser() async {
    return await Future.value(
        UserM(userId: userid, email: "fakeuser@fake.com"));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  /*  @override
  Future<UserM> singInAnonymously() async {
    return await Future.delayed(Duration(seconds: 2),
        () => UserM(userId: userid, email: "fakeuser@fake.com"));
  } */

  @override
  Future<UserM> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () =>
            UserM(userId: "google_user_id_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserM?> createUserWithEmailandPassword(
      String email, String sifre) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () =>
            UserM(userId: "create_user_id_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserM?> signInWithEmailandPassword(String email, String sifre) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () =>
            UserM(userId: "signin_user_id_123456", email: "fakeuser@fake.com"));
  }
}
