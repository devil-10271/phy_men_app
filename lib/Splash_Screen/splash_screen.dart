import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phy_men_app/Auth/login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Log_in())));

    var screen = MediaQuery.of(context);

    return Scaffold(
          body: Stack(
    children: [
      Container(
          height: screen.size.height,
          width: screen.size.width,
          decoration: BoxDecoration(
            color: Color(hex('76CFE2')),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/Logo/logo.png',
                  height: screen.size.height * ht(218),
                ),
              ),
              LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.black, size: screen.size.height * ht(70))
            ],
          )),

    ],

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
