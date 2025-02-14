//developed by ayush

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Physical/WeightLogging/AddWeight.dart';
import 'package:phy_men_app/Home/Physical/WeightLogging/WeightGraph.dart';


class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: InkWell(
          borderRadius: BorderRadius.circular(90),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        backgroundColor: Color.fromRGBO(171, 222, 232, 1),
        foregroundColor: Colors.white,
        title: Text(
          "Weight Logging",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        //color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenUtil().setHeight(147)),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(321),
                      width: ScreenUtil().setWidth(353),
                      child: Image.asset(
                        'assets/Image/Physical_Health/rafiki.png',
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(60)),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: Container(
                        height: ScreenUtil().setHeight(54),
                        width: ScreenUtil().setWidth(388),
                        child: ElevatedButton(
                          onPressed: () {
                            showCenteredDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(171, 222, 232, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100), // Adjust the radius as needed
                            ),
                          ),
                          child: Text(
                            'ADD NEW',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(60)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: Container(
                        height: ScreenUtil().setHeight(54),
                        width: ScreenUtil().setWidth(388),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (content) => WeightGraph()));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromRGBO(171, 222, 232, 1),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100), // Adjust the radius as needed
                            ),
                          ),
                          child: Text(
                            'View Weight Graph',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
