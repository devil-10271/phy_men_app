import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//developed by ayush

class Physicalhealth extends StatefulWidget {
  const Physicalhealth({super.key});

  @override
  State<Physicalhealth> createState() => _PhysicalhealthState();
}

class _PhysicalhealthState extends State<Physicalhealth> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              //background leaf image
              Container(
                width:  167,
                height: 926,
                child: Image.asset(
                  'assets/Image/Physical_Health/back.png',
                  alignment: Alignment.topCenter,
                ),
              ),
              //text on the top
              Positioned(
                top: 49,
                left: 9,
                child: Container(
                  width: ScreenUtil().setWidth(299),
                  height: ScreenUtil().setHeight(58),
                  child: RichText(
                    text: TextSpan(
                      text: 'What would you like to ',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'check ',
                            style: TextStyle(
                                color: Color.fromRGBO(118, 207, 226, 1),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 24)),
                        TextSpan(
                          text: 'Today?',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(23),
              ),
              //blood pressure
              Positioned(
                top: 126,
                left: 26,
                child: Container(
                  width: ScreenUtil().setWidth(167),
                  height: ScreenUtil().setHeight(145),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border:
                        Border.all(color: Color.fromRGBO(171, 222, 232, 0.5)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(171, 222, 232, 0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 11, left: 37),
                          child: Container(
                            width: ScreenUtil().setWidth(119),
                            height: ScreenUtil().setHeight(18),
                            child: Text(
                              'Blood Pressure',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 39),
                        child: Container(
                          width: ScreenUtil().setWidth(75),
                          height: ScreenUtil().setHeight(75),
                          //color: Colors.amberAccent,
                          child: Center(
                            child: Image.asset(
                              'assets/Image/Physical_Health/Group.png',
                              width: ScreenUtil().setWidth(56.25),
                              height: ScreenUtil().setHeight(56.25),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //heart rate
              Positioned(
                top: 166,
                left: 232,
                child: Container(
                  width: ScreenUtil().setWidth(167),
                  height: ScreenUtil().setHeight(145),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border:
                        Border.all(color: Color.fromRGBO(171, 222, 232, 0.5)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(171, 222, 232, 0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 9, left: 4),
                        child: Container(
                          width: ScreenUtil().setWidth(85),
                          height: ScreenUtil().setHeight(18),
                          child: Text(
                            'Heart Rate',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40, left: 100),
                          child: Container(
                            width: ScreenUtil().setWidth(75),
                            height: ScreenUtil().setHeight(75),
                            //color: Colors.amberAccent,
                            child: Center(
                              child: Image.asset(
                                'assets/Image/Physical_Health/icon-park_heart-rate.png',
                                width: ScreenUtil().setWidth(57),
                                height: ScreenUtil().setHeight(57),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //exercise
              Expanded(
                child: Positioned(
                  top: 305,
                  left: 26,
                  child: Container(
                    width: ScreenUtil().setWidth(167),
                    height: ScreenUtil().setHeight(145),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border:
                          Border.all(color: Color.fromRGBO(171, 222, 232, 0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(171, 222, 232, 0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4, left: 80),
                          child: Container(
                            width: ScreenUtil().setWidth(119),
                            height: ScreenUtil().setHeight(18),
                            child: Text(
                              'Exercise',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 39),
                          child: Container(
                            width: ScreenUtil().setWidth(75),
                            height: ScreenUtil().setHeight(75),
                            //color: Colors.amberAccent,
                            child: Center(
                              child: Image.asset(
                                'assets/Image/Physical_Health/Vector.png',
                                width: ScreenUtil().setWidth(56.25),
                                height: ScreenUtil().setHeight(56.25),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //wright management
              Expanded(
                child: Positioned(
                  top: 345,
                  left: 228,
                  child: Container(
                    width: ScreenUtil().setWidth(167),
                    height: ScreenUtil().setHeight(145),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border:
                          Border.all(color: Color.fromRGBO(171, 222, 232, 0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(171, 222, 232, 0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4, top: 12),
                          child: Container(
                            width:  ScreenUtil().setWidth(107),
                            height: ScreenUtil().setHeight(36),
                            child: Expanded(
                              child: Text(
                                'Weight Management',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                   ),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 35, left: 100),
                            child: Container(
                              width:  ScreenUtil().setWidth(60),
                              height: ScreenUtil().setHeight(60),
                              //color: Colors.amberAccent,
                              child: Center(
                                child: Image.asset(
                                  'assets/Image/Physical_Health/healthicons_weight-outline.png',
                                  width:  ScreenUtil().setWidth(44),
                                  height: ScreenUtil().setHeight(44),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(35),
              ),
              Padding(
                padding: EdgeInsets.only(top: 525),
                child: Container(
                  width:  ScreenUtil().setWidth(430),
                  height: ScreenUtil().setHeight(407),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(73.0),
                      topRight: Radius.circular(73.0),
                    ),
                    color: Color.fromRGBO(171, 222, 232, 0.5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 71),
                    child: Image.asset(
                      'assets/Image/Physical_Health/eating.png',
                      width:  ScreenUtil().setWidth(334),
                      height: ScreenUtil().setHeight(335),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
