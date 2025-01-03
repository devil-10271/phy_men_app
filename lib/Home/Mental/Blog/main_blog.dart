import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'blog1.dart';
import 'blog2.dart';
import 'blog3.dart';

class Main_blog extends StatefulWidget {
  const Main_blog({super.key});

  @override
  State<Main_blog> createState() => _Main_blogState();
}

class _Main_blogState extends State<Main_blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // Title Section
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Blogs \n',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(171, 147, 175, 1),
                          ),
                        ),
                        TextSpan(
                          text: '3 Blogs',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(203, 208, 222, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Buttons
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'Published',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(171, 147, 175, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Drafts',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(203, 208, 222, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                // Blog 1
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Blog1()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(225, 225, 225, 2),
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 310.w,
                          height: 250.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color.fromRGBO(203, 208, 222, 1),
                              width: 5,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: Text(
                            'Breaking Mental\nhealth\nStigmas',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100.h,
                          left: 40.w,
                          child: Text(
                            '2 days ago',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.more_horiz, color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                        Positioned(
                          bottom: -35.h,
                          right: -30.w,
                          child: Image.asset(
                            'assets/Image/Mental_Health/Blog/blog_image1.png',
                            width: 230.w,
                            height: 230.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                // Blog 2
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => blog2()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(171, 147, 175, 1),
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 310.w,
                          height: 250.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color.fromRGBO(203, 208, 222, 1),
                              width: 5,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 35.h,
                          left: 25.w,
                          child: Text(
                            'How Nutrition Impacts\n Mental Health',
                            style: TextStyle(
                              color: Color.fromRGBO(74, 74, 74, 1),
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100.h,
                          left: 150.w,
                          child: Text(
                            '2 days ago',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.more_horiz, color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                        Positioned(
                          bottom: -55.h,
                          right: -20.w,
                          child: Image.asset(
                            'assets/Image/Mental_Health/Blog/blog_image2.png',
                            width: 240.w,
                            height: 240.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Blog 3
                SizedBox(height: 40.h),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Blog3()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(225, 225, 225, 2),
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 310.w,
                          height: 250.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color.fromRGBO(203, 208, 222, 1),
                              width: 5,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: Text(
                            'Daily self-care\nRoutines\nto boost\nMental health',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 120.h,
                          right: 25.w,
                          child: Text(
                            '10 days ago',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.more_horiz, color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                        Positioned(
                          bottom: -80.h,
                          left: -20.w,
                          child: Image.asset(
                            'assets/Image/Mental_Health/Blog/blog_image3.png',
                            width: 230.w,
                            height: 200.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
          Positioned(
            right: 20.w,
            top: 20.h,
            child: IconButton(
              icon: Image.asset(
                'assets/Image/Mental_Health/Blog/add.png',
                width: 70.w,
                height: 70.h,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
