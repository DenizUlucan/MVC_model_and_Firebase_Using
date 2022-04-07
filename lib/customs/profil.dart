import 'dart:io';

import 'package:chat_app/customs/social_log_in_button.dart';
import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/viewmodel/user_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController? _controllerUserName;
  File? _profilFoto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    _controllerUserName!.text = _userModel.user!.userName as String;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
          actions: [
            ElevatedButton(
                onPressed: () => _cikisYap(context), child: Text("Çıkış"))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _userModel.user!.email,
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: "Emailiniz",
                      hintText: "Email",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerUserName,
                  decoration: InputDecoration(
                      labelText: "User Name",
                      hintText: "Username",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SocialLoginButton(
                  buttonText: "Değişiklikleri Kaydet",
                  buttonColor: Colors.purple,
                  onPressed: () {
                    _userNameGuncelle(context);
                  },
                ),
              )
            ],
          )),
        ));
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }

  void _userNameGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_userModel.user!.userName != _controllerUserName!.text) {
      var updateResult = await _userModel.updateUserName(
          _userModel.user!.userId, _controllerUserName!.text);
      if (updateResult == true) {
        print("Username güncelle hata");
      } else {
        _userModel.user!.userId = _controllerUserName!.text;
        print("Username Kullanımda");
      }
    } else {}
  }
}
