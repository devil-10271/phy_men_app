import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/firebase_auth_implementation/database.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async{
    return await _auth.currentUser;
  }

  signInWithGoogle(BuildContext context)async{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

    final AuthCredential credential= GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    if(result!=null)
      {
        Map<String, dynamic> userInfoMap={
          "email":userDetails!.email,
          "name": userDetails.displayName,
          "id":userDetails.uid
        };
        await DatabaseMethod().addUser(userDetails.uid, userInfoMap).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        });
      }
  }
}