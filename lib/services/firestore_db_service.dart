import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/services/db_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDBService implements DBbase {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool?> saveUser(UserM user) async {
    await _firebaseDB.collection("users").doc(user.userId).set(user.toMap());
    return true;
  }

  @override
  Future<UserM?> readUser(String userId) async {
    DocumentSnapshot<Object> _okunanUser =
        await _firebaseDB.collection("users").doc(userId).get();
    Map<String, dynamic> _okunanUserBilgileriMap =
        _okunanUser.data() as Map<String, dynamic>;

    UserM _okunanUserNesnesi = UserM.fromMap(_okunanUserBilgileriMap);
    print("okunan user nesnesi:" + _okunanUserNesnesi.toString());
    return _okunanUserNesnesi;
  }

  @override
  Future<bool?> updateUserName(String userId, String yeniUserName) async {
    var users = await _firebaseDB
        .collection("users")
        .where("userName", isEqualTo: yeniUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .doc(userId)
          .update({"userName": yeniUserName});
    }
  }
}
