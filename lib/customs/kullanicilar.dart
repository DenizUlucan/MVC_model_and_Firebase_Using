import 'package:chat_app/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KullanicilarPage extends StatelessWidget {
  const KullanicilarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("UserId= " + _userModel.user!.userId),
            Text("Email= " + "${_userModel.user!.userName}"),
            Text("Email= " + _userModel.user!.email),
            Text("Created at= " + "${_userModel.user!.createdAt}"),
            Text("Updated at= " + "${_userModel.user!.updatedAt}"),
          ],
        ),
      ),
    );
  }
}
