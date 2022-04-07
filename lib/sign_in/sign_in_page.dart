import 'package:chat_app/customs/social_log_in_button.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/services/auth_base.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/sign_in/email_password.dart';
import 'package:chat_app/viewmodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/UserM.dart';

class SignInPage extends StatelessWidget {
  SignInPage({
    Key? key,
  }) : super(key: key);

  /*  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    UserM? _user = await _userModel.singInAnonymously();
    print("Oturum açan user id:" + _user!.userId.toString());
  } */

  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    UserM? _user = await _userModel.signInWithGoogle();
    print("Oturum açan user id:" + _user!.userId.toString());
  }

  void _emailPasswordLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: ((context) => EmailPasswordLogin())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase and packages using"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Oturum Açın",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              SizedBox(
                height: 8,
              ),
              SocialLoginButton(
                buttonText: "Google İle Oturum Aç",
                buttonColor: Colors.red,
                onPressed: () {
                  _googleIleGiris(context);
                },
              ),
              SocialLoginButton(
                buttonText: "Email ve şifre ile giriş yap",
                buttonColor: Colors.purple,
                onPressed: () {
                  _emailPasswordLogin(context);
                },
              ),
              /*  SocialLoginButton(
                onPressed: () => _misafirGirisi(context),
                buttonText: "Misafir girişi",
                buttonColor: Colors.amber,
              ) */
            ]),
      ),
    );
  }
}
