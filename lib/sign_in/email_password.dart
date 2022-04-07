import 'package:chat_app/customs/social_log_in_button.dart';
import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/sign_in/sign_in_page.dart';
import 'package:chat_app/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

enum FormType { Register, Login }

class EmailPasswordLogin extends StatefulWidget {
  EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  State<EmailPasswordLogin> createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  String? _email, _password;
  String? _buttonText, _linkText;
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();

  _formSubmit(BuildContext context) async {
    _formKey.currentState?.save();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_formType == FormType.Login) {
      try {
        UserM? _loginUser =
            await _userModel.signInWithEmailandPassword(_email!, _password!);
        if (_loginUser != null) {
          print("Oturum Açan User id:" + _loginUser.userId.toString());
        }
      } catch (e) {
        debugPrint("Widget oturum açma hata yakalandı" + e.toString());
      }
    } else {
      try {
        UserM? _createdUser = await _userModel.createUserWithEmailandPassword(
            _email!, _password!);
        if (_createdUser != null) {
          print("Oturum Açan user id" + _createdUser.userId.toString());
        }
      } catch (e) {
        debugPrint("Widget kullanıcı oluşturma hata yakalandı" + e.toString());
      }
    }
  }

  void _change() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt ol";
    _linkText = _formType == FormType.Login
        ? "Hesabınız Yok Mu? Kayıt Olun"
        : "Hesabınız var mı? Giriş Yapın";

    final _userModel = Provider.of<UserModel>(context);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (_userModel.user != null) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Giriş / Kayıt"),
          actions: [],
        ),
        body: _userModel.state == ViewState.idle
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText: _userModel.emailErrorMessage != null
                                  ? _userModel.emailErrorMessage
                                  : null,
                              prefixIcon: Icon(Icons.mail),
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (inputEmail) {
                              _email = inputEmail;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: _userModel.passwordErrorMessage != null
                                  ? _userModel.passwordErrorMessage
                                  : null,
                              prefixIcon: Icon(Icons.mail),
                              labelText: "Password",
                              hintText: "Password",
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (inputPassword) {
                              _password = inputPassword;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SocialLoginButton(
                            buttonText: _buttonText,
                            buttonColor: Theme.of(context).primaryColor,
                            onPressed: () => _formSubmit(context),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: Text(_linkText!),
                            onTap: () => _change(),
                          )
                        ],
                      )),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
