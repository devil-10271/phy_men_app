// Develop by SaHil

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Auth/Otp_send.dart';
import "package:phy_men_app/main.dart";

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: List.empty()),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: RichText(
                      text: TextSpan(
                        text: "Forgot Password",
                        style: TextStyle(fontSize: 32, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Please enter your email to recover the password",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(120),
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
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
                        borderSide:
                            BorderSide(color: Color(methods.hex('76CFE2')))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(methods.hex('76CFE2')), width: 2),
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
                SizedBox(
                  height: ScreenUtil().setHeight(300),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Otp_send()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 129, 218, 250),
                    padding: EdgeInsets.symmetric(vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    shadowColor: Colors.grey.withOpacity(0.9),
                    elevation: 5,
                  ),
                  child: Center(
                    child: Text(
                      'Send Otp',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
