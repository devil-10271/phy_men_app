import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod{
  Future addUser(String userId, Map<String, dynamic> UserInfoMap){
    return FirebaseFirestore.instance.collection("User").doc(userId).set(UserInfoMap);
  }
}