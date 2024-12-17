// Develop by SaHil

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:phy_men_app/Splash_Screen/splash_screen.dart';

class Otp_send extends StatefulWidget {
  const Otp_send({super.key});

  @override
  State<Otp_send> createState() => _Otp_sendState();
}

class _Otp_sendState extends State<Otp_send> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                SizedBox(height: ScreenUtil().setHeight(30),),
                Center(
                  child: RichText(
                      text: TextSpan(
                    text: "Please Enter the OTP sent to your Email",
                        style: TextStyle(color: Colors.black),
                  )),
                ),
                SizedBox(height: ScreenUtil().setHeight(30),),
                OtpTextField(
                  numberOfFields: 4,
                  fillColor: Color(hex('ABDEE8')),
                  cursorColor: Colors.black,
                  fieldWidth: ScreenUtil().setWidth(70),
                  fieldHeight: ScreenUtil().setHeight(70),
                  borderRadius: BorderRadius.circular(10),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                ),              ],
            ),
          ),
        ),
      ),
    );
  }
}
