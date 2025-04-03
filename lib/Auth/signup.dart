
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:phy_men_app/main.dart';
import 'package:phy_men_app/Auth/login.dart';

dynamic met = methods();

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class FirestoreServices{
  static saveUser(String name, email,uid) async{
    await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .set({'Email':email, 'Username':name, 'id':uid});
  }
}
class _Sign_UpState extends State<Sign_Up> {
  bool isChecked = false;
  String email = "", password = "", username = "";
  TextEditingController _username = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
        'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();

  Future<void> registration() async {
    if (_formkey.currentState!.validate() &&
        _password.text.isNotEmpty &&
        _username.text.isNotEmpty &&
        _email.text.isNotEmpty) {
      try {
        // Create user with Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim()
        );
        await FirestoreServices.saveUser(username, email, userCredential.user!.uid);
        // Add user details to the database
        await _addUserToDatabase(
          uid: userCredential.user!.uid,
          uname: _username.text.trim(),
          email: _email.text.trim()
        );

        // Display success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Registration Successful",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );

        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase Auth exceptions
        if (e.code == 'weak-password') {
          _showError("The password provided is too weak.");
        } else if (e.code == "email-already-in-use") {
          _showError("The email is already in use.");
        } else {
          _showError("An error occurred. Please try again.");
        }
      } catch (e) {
        // Handle general exceptions
       _showError("An unexpected error occurred. Please try again.");
      }
    } else {
      // Handle form validation failure
      _showError("Please fill in all the required fields.");
    }
  }
  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');

  Future<void> _addUserToDatabase({
    required String uid,
    required String uname,
    required String email,
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
            "15-02-2025": {
              "time": {
                "08:00": {
                  "reading_gkscore": 0
                },
                "12:00": {
                  "reading_gkscore": 0
                },
                "18:00": {
                  "reading_gkscore": 0
                }
              }
            }
          },
          "iq_score": {
            "15-02-2025": {
              "time": {
                "08:00": {
                  "reading_iqscore": 0
                },
                "12:00": {
                  "reading_iqscore": 0
                },
                "18:00": {
                  "reading_iqscore": 0
                }
              }
            }
          }
        },
        "physical_health": {
          "blood_pressure": {
            "13-02-2025": {
              "time": {
                "08:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                },
                "12:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                },
                "18:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                }
              }
            },
            "14-02-2025": {
              "time": {
                "08:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                },
                "12:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                },
                "18:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                }
              }
            },
            "15-02-2025": {
              "time": {
                "08:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                },
                "12:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                },
                "18:00": {
                  "reading_systole": 0,
                  "reading_diastole": 0
                }
              }
            }
          },
          "height": {
            "09-02-2025": {
              "reading_height": "5.1",
              "time": "08:00"
            },
            "10-02-2025": {
              "reading_height": "5.1",
              "time": "08:00"
            },
            "11-02-2025": {
              "reading_height": "5.1",
              "time": "08:00"
            },
            "12-02-2025": {
              "reading_height": "5.1",
              "time": "08:00"
            },
            "13-02-2025": {
              "reading_height": "5.1",
              "time": "08:00"
            },
            "14-02-2025": {
              "reading_height": "5.1",
              "time": "08:00"
            },
            "15-02-2025": {
              "reading_height": "5.1",
              "time": "08:00"
            }
          },
          "pulse": {
            "13-02-2025": {
              "time": {
                "08:00": {
                  "reading_pulse": 0
                },
                "12:00": {
                  "reading_pulse": 0
                },
                "18:00": {
                  "reading_pulse": 0
                }
              }
            },
            "14-02-2025": {
              "time": {
                "08:00": {
                  "reading_pulse": 0
                },
                "12:00": {
                  "reading_pulse": 0
                },
                "18:00": {
                  "reading_pulse": 0
                }
              }
            },
            "15-02-2025": {
              "time": {
                "08:00": {
                  "reading_pulse": 0
                },
                "12:00": {
                  "reading_pulse": 0
                },
                "18:00": {
                  "reading_pulse": 0
                }
              }
            }
          },
          "weight": {
            "11-02-2025": {
              "time": {
                "08:00": {
                  "reading_weight": 0
                },
                "12:00": {
                  "reading_weight": 0
                },
                "18:00": {
                  "reading_weight": 0
                }
              }
            },
            "12-02-2025": {
              "time": {
                "09:00": {
                  "reading_weight": 73.2
                },
                "15:00": {
                  "reading_weight": 73.5
                },
                "21:00": {
                  "reading_weight": 73.0
                }
              }
            },
            "13-02-2025": {
              "time": {
                "07:30": {
                  "reading_weight": 72.9
                },
                "14:00": {
                  "reading_weight": 73.3
                }
              }
            },
            "14-02-2025": {
              "time": {
                "10:00": {
                  "reading_weight": 73.1
                },
                "16:00": {
                  "reading_weight": 72.7
                }
              }
            },
            "15-02-2025": {
              "time": {
                "11:00": {
                  "reading_weight": 73.4
                },
                "19:00": {
                  "reading_weight": 73.0
                }
              }
            }
          }
        },
        "uname": _username.text,
        "email": _email.text,
        "profile": ""
      });
    } catch (e) {
      _showError("Failed to add user to the database.");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: -270,
                    left: MediaQuery.of(context).size.width / 2 - 250,
                    child: Container(
                      width: 500,
                      height: 500,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 121, 212, 248),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(1, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 21,
                    left: 29,
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'CREATE\n',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'ACCOUNT\n',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 250, left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter username";
                                        }
                                        return null;
                                      },
                                      controller: _username,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: BorderSide(
                                                color: Color(
                                                    methods.hex('76CFE2')))),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Color(methods.hex('76CFE2')),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        hintText: 'Enter Username',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        // suffixIcon: Icon(Icons.email),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter a Email Id';
                                    }
                                    if (!emailRegExp.hasMatch(value)) {
                                      return 'Please Enter valid Email Address';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _email,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: BorderSide(
                                            color:
                                                Color(methods.hex('76CFE2')))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(methods.hex('76CFE2')),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    hintText: 'Enter Email',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    // suffixIcon: Icon(Icons.email),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter password";
                                    }
                                    return null;
                                  },
                                  controller: _password,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: BorderSide(
                                            color:
                                                Color(methods.hex('76CFE2')))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(methods.hex('76CFE2')),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    // suffixIcon: Icon(Icons.email),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // TextFormField(
                                //   controller: _confpassword,
                                //   style: TextStyle(color: Colors.black),
                                //   decoration: InputDecoration(
                                //     enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(40),
                                //         borderSide: BorderSide(
                                //             color: Color(methods.hex('76CFE2')))),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: Color(methods.hex('76CFE2')), width: 2),
                                //       borderRadius: BorderRadius.circular(20),
                                //     ),
                                //     hintText: 'Enter Confirm Password',
                                //     hintStyle: TextStyle(
                                //       color: Colors.grey,
                                //     ),
                                //   ),
                                // ),
                                // Row(
                                //   children: [
                                //     Checkbox(
                                //         value: isChecked,
                                //         checkColor: Colors.white,
                                //         onChanged: (bool? value) {
                                //           setState(() {
                                //             isChecked = value!;
                                //           });
                                //         }),
                                //     Text('I accept Terms and Conditions..')
                                //   ],
                                // ),

                                SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = _email.text;
                                        username = _username.text;
                                        password = _password.text;
                                      });
                                    }
                                    registration();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 129, 218, 250),
                                    padding: EdgeInsets.symmetric(vertical: 9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    shadowColor: Colors.grey.withOpacity(0.9),
                                    elevation: 5,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text(
                                  'Or Sign in with',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).height * 0.80,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              AuthMethods().signInWithGoogle(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(40),
                              ),


                              elevation: 5,
                            ),
                            icon: Image.asset(
                              'assets/Company_icon/google.png',
                              height: 30,
                              width: 30,
                            ),
                            label: Text(
                              'Google',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // Sign-up and Forgot Password Buttons
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Log_in()));
                                },

                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
