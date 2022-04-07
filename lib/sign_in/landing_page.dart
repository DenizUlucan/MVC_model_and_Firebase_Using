import 'package:chat_app/sign_in/home_page.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/services/auth_base.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/sign_in/sign_in_page.dart';
import 'package:chat_app/viewmodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.state == ViewState.idle) {
      if (_userModel.user == null) {
        return SignInPage();
      } else {
        return HomePage(user: _userModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
