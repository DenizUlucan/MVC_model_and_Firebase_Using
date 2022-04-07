import 'dart:io';

import 'package:chat_app/locator.dart';
import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/services/auth_base.dart';
import 'package:chat_app/services/fake_auth_service.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_storage_service.dart';
import 'package:chat_app/services/firestore_db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _FakeAuthenticationService =
      locator<FakeAuthenticationService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  AppMode appMode = AppMode.RELEASE;

  @override
  Future<UserM?> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _FakeAuthenticationService.currentUser();
    } else {
      UserM? _user = await _firebaseAuthService.currentUser();
      return await _firestoreDBService.readUser(_user!.userId);
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _FakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  /* @override
  Future<UserM?> singInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _FakeAuthenticationService.singInAnonymously();
    } else {
      return await _firebaseAuthService.singInAnonymously();
    }
  } */

  @override
  Future<UserM?> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _FakeAuthenticationService.signInWithGoogle();
    } else {
      UserM? _user = await _firebaseAuthService.signInWithGoogle();
      if (_user != null) {
        bool? _sonuc = await _firestoreDBService.saveUser(_user);
        if (_sonuc!) {
          return await _firestoreDBService.readUser(_user.userId);
        } else {
          await _firebaseAuthService.signOut();
          return null;
        }
      } else
        return null;
    }
  }

  @override
  Future<UserM?> createUserWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _FakeAuthenticationService.createUserWithEmailandPassword(
          email, password);
    } else {
      UserM? _user = await _firebaseAuthService.createUserWithEmailandPassword(
          email, password);
      bool? _sonuc = await _firestoreDBService.saveUser(_user!);
      if (_sonuc!) {
        return await _firestoreDBService.readUser(_user.userId);
      } else {
        return null;
      }
    }
  }

  @override
  Future<UserM?> signInWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _FakeAuthenticationService.signInWithEmailandPassword(
          email, password);
    } else {
      UserM? _user = await _firebaseAuthService.signInWithEmailandPassword(
          email, password);
      return await _firestoreDBService.readUser(_user!.userId);
    }
  }

  Future<bool?> updateUserName(String userID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBService.updateUserName(userID, yeniUserName);
    }
  }
}
