import 'dart:io';

import 'package:chat_app/sign_in/landing_page.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/services/auth_base.dart';
import 'package:flutter/material.dart';

enum ViewState { idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.idle;
  UserRepository _userRepository = locator<UserRepository>();
  UserM? _user;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  UserM? get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<UserM?> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current userda hata" + e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki current userda hata" + e.toString());
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

/*   @override
  Future<UserM?> singInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.singInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("Viewmodeldeki current userda hata" + e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  } */

  @override
  Future<UserM?> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      debugPrint("Viewmodeldeki signinwithgoogle hata" + e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserM?> createUserWithEmailandPassword(
      String email, String password) async {
    if (emailPasswordControl(email, password)) {
      try {
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmailandPassword(
            email, password);

        return _user;
      } finally {
        state = ViewState.idle;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserM?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      if (emailPasswordControl(email, password)) {
        state = ViewState.Busy;
        _user =
            await _userRepository.signInWithEmailandPassword(email, password);
        return _user;
      }
    } finally {
      state = ViewState.idle;
    }
  }

  bool emailPasswordControl(String email, String password) {
    var sonuc = true;
    if (password.length < 6) {
      passwordErrorMessage = "En az 6 karakter olmalı";
      sonuc = false;
    } else {
      passwordErrorMessage = null;
    }
    ;
    if (!email.contains("@")) {
      emailErrorMessage = "Geçersiz email adresi";
      sonuc = false;
    } else
      emailErrorMessage = null;
    return sonuc;
  }

  Future<bool?> updateUserName(String userID, String yeniUserName) async {
    return await _userRepository.updateUserName(userID, yeniUserName);
  }
}
