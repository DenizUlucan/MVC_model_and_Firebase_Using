import 'package:chat_app/sign_in/landing_page.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/services/fake_auth_service.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/sign_in/sign_in_page.dart';
import 'package:chat_app/viewmodel/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  setuoLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        home: LandingPage(),
      ),
    );
  }
}
