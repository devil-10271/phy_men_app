import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

class _Sign_UpState extends State<Sign_Up> {
  bool isChecked = false;
  String email = "", password = "", username = "";
  TextEditingController _username = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confpassword = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

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
          password: _password.text.trim(),
        );

        // Add user details to the database
        await _addUserToDatabase(
          uid: userCredential.user!.uid,
          uname: _username.text.trim(),
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
                                    if (value == null || value.isEmpty) {
                                      return "Enter Email";
                                    }
                                    return null;
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
                          height: 20,
                        ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  signInWithFacebook();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  shadowColor: Colors.grey.withOpacity(0.9),
                                  elevation: 5,
                                ),
                                icon: Image.asset(
                                  'assets/Company_icon/facebook.png',
                                  height: 30,
                                  width: 30,
                                ),
                                label: Text(
                                  'Facebook',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
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
                                  shadowColor: Colors.grey.withOpacity(0.9),
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
                            ],
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
