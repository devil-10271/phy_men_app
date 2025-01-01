import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phy_men_app/Auth/Forgot%20Password.dart';
import 'package:phy_men_app/Auth/signup.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:phy_men_app/main.dart';

class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  String email = "", password = "";
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "User Not Found",
              style: TextStyle(fontSize: 20.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Enter Correct password",
              style: TextStyle(fontSize: 20.0),
            )));
      }
    }
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
                    top: -230,
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
                            text: 'WELCOME\n',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'BACK',
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
                    padding: EdgeInsets.only(top: 300, left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
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
                                    fillColor: Color(methods.hex('76CFE2')),
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
                                      return "Enter password ";
                                    }
                                    return null;
                                  },
                                  controller: _password,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Color(methods.hex('76CFE2')),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: BorderSide(
                                            color:
                                            Color(methods.hex('76CFE2')))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF76CFE2),
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
                                SizedBox(height: 60),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = _email.text;
                                        password = _password.text;
                                      });
                                    }
                                    userLogin();
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
                                      'Log In',
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
                                onPressed: () async{

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
                                          builder: (context) => Sign_Up()));
                                },
                                child: Text(
                                  'Sign-up',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Forgot_Password()));
                                },
                                child: Text(
                                  'Forgot Password?',
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
