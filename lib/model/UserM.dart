import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserM {
  String userId;
  String email;
  String? userName;
  String? profilURL;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? seviye;

  UserM({
    required this.userId,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "email": email,
      "userName":
          userName ?? email.substring(0, email.indexOf('@')) + randomsayiUret(),
      "profilURL": profilURL ?? '',
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
      "updatedAt": updatedAt ?? FieldValue.serverTimestamp(),
      "seviye": seviye ?? 1,
    };
  }

  UserM.fromMap(Map<dynamic, dynamic> map)
      : userId = map['userId'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        seviye = map['seviye'];

  @override
  String toString() {
    return 'User{userId: $userId, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, seviye: $seviye}';
  }

  String randomsayiUret() {
    int rastgeleSayi = Random().nextInt(999);
    return rastgeleSayi.toString();
  }
}
