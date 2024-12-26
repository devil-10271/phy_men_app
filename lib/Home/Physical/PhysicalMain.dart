//developed by ayush

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Physical/BloodPressure/Blood.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Cadio/Cardiopage.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Yoga/Yogapage.dart';

import 'package:phy_men_app/Home/Physical/WeightLogging/Weight.dart';

import 'HeartRate/HeartRate.dart';

class Physicalmain extends StatefulWidget {
  const Physicalmain({super.key});

  @override
  State<Physicalmain> createState() => _PhysicalmainState();
}

class _PhysicalmainState extends State<Physicalmain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              // decoration: BoxDecoration(border: Border.all()),
              height: ScreenUtil().setHeight(70),
              width: ScreenUtil().setWidth(370),
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(70),
                  left: ScreenUtil().setWidth(33),
                  right: ScreenUtil().setWidth(33)),
              child: RichText(
                text: TextSpan(
                  text: 'What would you like to ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat'),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'check',
                      style: TextStyle(
                          color: Color.fromRGBO(118, 207, 226, 1),
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat'),
                    ),
                    TextSpan(
                      text: ' today?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      buildHealthCard(
                        title: 'Blood Pressure',
                        description: 'Check your blood pressure',
                        buttonColor: Color.fromRGBO(190, 227, 246, 1),
                        assetImagePath: 'assets/Image/Physical_Health/bp.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Blood()),
                          );
                        },
                      ),
                      buildHealthCard(
                        title: 'Heart Rate',
                        description: 'Check your heart rate',
                        buttonColor: Color.fromRGBO(245, 91, 110, 0.75),
                        assetImagePath:
                            'assets/Image/Physical_Health/heart_rate.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HeartRate()),
                          );
                        },
                      ),
                      buildHealthCard(
                        title: 'Weight Logging',
                        description: 'Check your weight',
                        buttonColor: Color.fromRGBO(118, 207, 226, 1),
                        assetImagePath:
                            'assets/Image/Physical_Health/eating.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Weight()),
                          );
                        },
                      ),
                      buildHealthCard(
                        title: 'Exercise',
                        description: 'Track your exercise',
                        buttonColor: Color.fromRGBO(211, 201, 225, 1),
                        assetImagePath:
                            'assets/Image/Physical_Health/exercise.png',
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cardiopage()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHealthCard({
  required String title,
  required String description,
  required Color buttonColor,
  required String assetImagePath,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(33)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(4)),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(4)),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: onPressed, // Pass the callback here
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Check now',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                height: ScreenUtil().setHeight(120),
                child: Image.asset(
                  assetImagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
