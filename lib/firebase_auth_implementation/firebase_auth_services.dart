import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/firebase_auth_implementation/database.dart';




class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async{
    return await _auth.currentUser;
  }
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL: 'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();



  Future<void> _addUserToDatabase({
    required String uid,
    required String uname,
  }) async {
    try {
      await _database.child('users/$uid').set({
        "details": {
          "address": "",
          "contact_no": "",
          "dob": "",
          "f_name": "",
          "l_name": ""
        },
        "mental_health": {
          "gk_score": {
            "18-12-2024": {"reading_gkscore": "1", "time": "08:00"},
            "19-12-2024": {"reading_gkscore": "2", "time": "08:00"},
            "20-12-2024": {"reading_gkscore": "3", "time": "08:00"},
            "21-12-2024": {"reading_gkscore": "5", "time": "08:00"},
            "22-12-2024": {"reading_gkscore": "4", "time": "08:00"},
            "23-12-2024": {"reading_gkscore": "2", "time": "08:00"},
            "24-12-2024": {"reading_gkscore": "3", "time": "08:00"}
          },
          "iq_score": {
            "18-12-2024": {"reading_iqscore": "1", "time": "08:00"},
            "19-12-2024": {"reading_iqscore": "2", "time": "08:00"},
            "20-12-2024": {"reading_iqscore": "3", "time": "08:00"},
            "21-12-2024": {"reading_iqscore": "5", "time": "08:00"},
            "22-12-2024": {"reading_iqscore": "4", "time": "08:00"},
            "23-12-2024": {"reading_iqscore": "2", "time": "08:00"},
            "24-12-2024": {"reading_iqscore": "3", "time": "08:00"}
          }
        },
        "physical_health": {
          "blood_pressure": {
            "24-12-2024": {
              "time": {
                "08:00": {"reading_systole": 0, "reading_diastole": 0},
                "12:00": {"reading_systole": 0, "reading_diastole": 0},
                "18:00": {"reading_systole": 0, "reading_diastole": 0}
              }
            },
            "25-12-2024": {
              "time": {
                "08:00": {"reading_systole": 0, "reading_diastole": 0},
                "12:00": {"reading_systole": 0, "reading_diastole": 0},
                "18:00": {"reading_systole": 0, "reading_diastole": 0}
              }
            },
            "26-12-2024": {
              "time": {
                "08:00": {"reading_systole": 0, "reading_diastole": 0},
                "12:00": {"reading_systole": 0, "reading_diastole": 0},
                "18:00": {"reading_systole": 0, "reading_diastole": 0}
              }
            }
          },
          "height": {
            "18-12-2024": {"reading_height": "5.1", "time": "08:00"},
            "19-12-2024": {"reading_height": "5.1", "time": "08:00"},
            "20-12-2024": {"reading_height": "5.1", "time": "08:00"},
            "21-12-2024": {"reading_height": "5.1", "time": "08:00"},
            "22-12-2024": {"reading_height": "5.1", "time": "08:00"},
            "23-12-2024": {"reading_height": "5.1", "time": "08:00"},
            "24-12-2024": {"reading_height": "5.1", "time": "08:00"}
          },
          "pulse": {
            "24-12-2024": {
              "time": {
                "08:00": {"reading_pulse": 0},
                "12:00": {"reading_pulse": 0},
                "18:00": {"reading_pulse": 0}
              }
            },
            "25-12-2024": {
              "time": {
                "08:00": {"reading_pulse": 0},
                "12:00": {"reading_pulse": 0},
                "18:00": {"reading_pulse": 0}
              }
            },
            "26-12-2024": {
              "time": {
                "08:00": {"reading_pulse": 0},
                "12:00": {"reading_pulse": 0},
                "18:00": {"reading_pulse": 0}
              }
            }
          },
          "weight": {
            "24-12-2024": {
              "time": {
                "08:00": {"reading_weight": 0},
                "12:00": {"reading_weight": 0},
                "18:00": {"reading_weight": 0}
              }
            },
            "25-12-2024": {
              "time": {
                "09:00": {"reading_weight": 73.2},
                "15:00": {"reading_weight": 73.5},
                "21:00": {"reading_weight": 73.0}
              }
            },
            "26-12-2024": {
              "time": {
                "07:30": {"reading_weight": 72.9},
                "14:00": {"reading_weight": 73.3}
              }
            },
            "27-12-2024": {
              "time": {
                "10:00": {"reading_weight": 73.1},
                "16:00": {"reading_weight": 72.7}
              }
            },
            "28-12-2024": {
              "time": {
                "11:00": {"reading_weight": 73.4},
                "19:00": {"reading_weight": 73.0}
              }
            }
          }
        },
        "uname": ""
      });
    } catch (e) {
      print("Error");
    }
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
          "Email":userDetails!.email,
          "Username": userDetails.displayName,
          "id":userDetails.uid
        };
        await DatabaseMethod().addUser(userDetails.uid, userInfoMap).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        });
      }try{
      await _addUserToDatabase(
          uid: userDetails!.uid,
          uname: userDetails.displayName.toString()
      );
    }catch(e){
      print("Error occurred");
    }
  }
}

