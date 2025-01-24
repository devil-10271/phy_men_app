//developed by ayush

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Mental/GkTest/GKData.dart';
import 'package:phy_men_app/Home/Mental/GkTest/GkScreen.dart';

class StartGk extends StatefulWidget {
  const StartGk({super.key});

  @override
  State<StartGk> createState() => _StartGkState();
}


class _StartGkState extends State<StartGk> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 20,top: 20),
                child: InkWell(
                onTap: ()=>Navigator.pop(context)

                ,child: Icon(Icons.arrow_back_ios)),
              ),
              SizedBox(height: ScreenUtil().setHeight(190)),
              Center(
                child: Container(
                  //color: Colors.red,
                  child: Text(
                    'Test Your GK',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(31)),
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(52),
                  width: ScreenUtil().setWidth(218),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(184, 218, 226, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GkScreen(),
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
                            'assets/Image/Mental_Health/Quiz/Group.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20),),
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(52),
                  width: ScreenUtil().setWidth(218),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(184, 218, 226, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GKData(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View GK Score',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(3.5)),
                        // Container(
                        //   height: ScreenUtil().setHeight(11.83),
                        //   width: ScreenUtil().setWidth(13.68),
                        //   child: Image.asset(
                        //     'assets/Image/Quiz/Group.png',
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(50)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:10.0),
                child: Flexible(
                  child: Image.asset(
                    'assets/Image/Mental_Health/GK/bro.png',

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
