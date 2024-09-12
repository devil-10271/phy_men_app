import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Auth/signup.dart';
import 'package:phy_men_app/main.dart';

dynamic met=methods();

class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
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
                          child: Column(
                            children: [
                              TextFormField(

                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  fillColor: Color(met.hex('76CFE2')),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(
                                          color: Color(met.hex('76CFE2')))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(met.hex('76CFE2')), width: 2),
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

                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(
                                          color: Color(met.hex('76CFE2')))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(met.hex('76CFE2')), width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: 'Enter Password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 60),
                              ElevatedButton(
                                onPressed: () {},
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
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
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
                                onPressed: () {},
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
                                onPressed: () {},
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
    ;
  }
}

