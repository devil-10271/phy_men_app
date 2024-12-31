import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Yoga/Yogapage.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Cadio/Cardiopage.dart';
class Exe extends StatefulWidget {
  const Exe({super.key});

  @override
  State<Exe> createState() => _ExeState();
}

class _ExeState extends State<Exe> {
  void _onYogaButtonPressed() {
    print("Yoga button pressed");
  }

  void _onCardioButtonPressed() {
    print("Cardio button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w),
                child: IconButton(
                  icon: Image.asset(
                    'assets/Image/Physical_Health/Exercise/Frame.png',
                    width: 30.w,
                    height: 30.h,
                    color: const Color(0xFF76CFE2),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Title Section
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(20)),
                child: RichText(
                  text: TextSpan(
                    children:const  [
                      TextSpan(
                        text: 'Find ',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Your \n',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF76CFE2),
                        ),
                      ),
                      TextSpan(
                        text: 'favorite Workout',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Yoga Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Yogapage()));
                    },
                    child: Image.asset(
                      'assets/Image/Physical_Health/Exercise/yoga_button.png',
                      width: 700.w,
                      height: 220.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Cardio Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Cardiopage()));
                    },
                    child: Image.asset(
                      'assets/Image/Physical_Health/Exercise/cardio_button.png',
                      width: 600.w,
                      height: 220.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
