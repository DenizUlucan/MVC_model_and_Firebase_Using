import 'package:chat_app/model/UserM.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DBbase {
  Future<bool?> saveUser(UserM user);
  Future<UserM?> readUser(String userId);
  Future<bool?> updateUserName(String userId, String yeniUserName);
}
