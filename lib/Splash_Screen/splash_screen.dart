import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phy_men_app/Auth/login.dart';
// import 'package:phy_men_app/Auth/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Log_in()
            )
        )
    );

    var screen = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
            height: screen.size.height,
            width: screen.size.width,
            decoration: BoxDecoration(
              color: Color(hex('76CFE2')),
            ),
            child: Center(
              child: Image.asset(
                'Assets/Logo/logo.png',
                height: screen.size.height * ht(218),
              ),
            )),
      ),
    );
  }
}

double ht(int a) {
  return a / 926;
}

double wt(int a) {
  return a / 428;
}

int hex(String apple) {
  String c = "0xff" + apple;
  c = c.replaceAll('#', '');
  int complete = int.parse(c);
  return complete;
}
