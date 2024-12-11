import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: "Forgot Password",
                          style: TextStyle(fontSize: 32, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                        text: "Please enter your email to recover the password",
                        style: TextStyle(color: Colors.black),
                      ),
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
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(350),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Center(child: Text("Send Otp")),
                  style: ButtonStyle(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
