//developed by ayush

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Quiz/QuizScreen.dart';

class Startquiz extends StatefulWidget {
  const Startquiz({super.key});

  @override
  State<Startquiz> createState() => _StartquizState();
}

class _StartquizState extends State<Startquiz> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenUtil().setHeight(233)),
              Container(
                //color: Colors.red,
                child: Text(
                  'Test Your IQ~',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(31)),
              Container(
                height: ScreenUtil().setHeight(52),
                width: ScreenUtil().setWidth(218),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(198, 224, 215, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(3.5)),
                      Container(
                        height: ScreenUtil().setHeight(11.83),
                        width: ScreenUtil().setWidth(13.68),
                        child: Image.asset(
                          'assets/Image/Quiz/Group.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(175)),
              Container(
                height: ScreenUtil().setHeight(422.32),
                width: ScreenUtil().setWidth(440.31),
                //color: Colors.yellow,
                child: Image.asset(
                  'assets/Image/Quiz/bro.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}