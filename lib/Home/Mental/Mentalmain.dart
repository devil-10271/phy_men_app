import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Mental/Blog/main_blog.dart';
import 'package:phy_men_app/Home/Mental/Calm/main_calm.dart';
import 'package:phy_men_app/Home/Mental/GkTest/StrartGk.dart';
import 'package:phy_men_app/Home/Mental/Medi/Medi2.dart';
import 'package:phy_men_app/Quiz/Startquiz.dart';

class MentalMain extends StatefulWidget {
  const MentalMain({super.key});

  @override
  State<MentalMain> createState() => _MentalMainState();
}

class _MentalMainState extends State<MentalMain> {
  final ScrollController _scrollController =
      ScrollController(); // Step 1: Add ScrollController

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return SafeArea(
      child: Scaffold(
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
          //backgroundColor: Color.fromRGBO(171, 222, 232, 1),
          //foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting text
            Container(
              margin: EdgeInsets.only(
                top: 77.h,
                left: 15.w,
                right: 33.w,
              ),
              child: RichText(
                text: const TextSpan(
                  text: 'Hello, Miss Norman\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                  children: [
                    TextSpan(
                      text: 'How are you feeling today?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Emotion buttons
            SizedBox(height: 20.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: _buildEmotionImageButton(
                        'assets/Image/Mental_Health/face1.png',
                        const Color.fromRGBO(255, 194, 188, 1)),
                  ),
                  InkWell(
                    child: _buildEmotionImageButton('assets/Image/Mental_Health/face2.png',
                        const Color.fromRGBO(198, 224, 215, 1)),
                  ),
                  InkWell(
                    child: _buildEmotionImageButton(
                        'assets/Image/Mental_Health/face3.png',
                        const Color.fromRGBO(240, 188, 103, 1)),
                  ),
                  InkWell(
                    child: _buildEmotionImageButton(
                        'assets/Image/Mental_Health/face4.png',
                        const Color.fromRGBO(184, 218, 226, 1),
                        isLast: true),
                  ),
                ],
              ),
            ),

            // Categories List
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories List',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Step 3: Scroll to the bottom when "See all" is tapped
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Grey divider line
            Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),

            // Expanded ListView Section
            Expanded(
              child: Padding(
                padding:  EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                child: ListView(
                  controller:
                      _scrollController, // Step 2: Attach the controller
                  children: [
                    buildHealthCard(
                      title: 'Meditation',
                      description:
                          'Meditation is a perfect break from the chaos of life',
                      buttonColor: Color.fromRGBO(240, 188, 103, 1),
                      assetImagePath:
                          'assets/Image/Mental_Health/s1.png',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Medi2()));
                      },
                    ),
                    buildHealthCard(
                      title: 'Calm music',
                      description: 'Calm your soul',
                      buttonColor: Color.fromRGBO(255, 194, 188, 1),
                      assetImagePath:
                          'assets/Image/Mental_Health/s2.png',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>main_calm()));
                      },
                    ),
                    buildHealthCard(
                      title: 'IQ Test',
                      description: 'Test your IQ',
                      buttonColor: Color.fromRGBO(198, 224, 215, 1),
                      assetImagePath: 'assets/Image/Mental_Health/s3.png',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Startquiz(),
                          ),
                        );
                      },
                    ),
                    buildHealthCard(
                      title: 'Blog',
                      description: 'Publish your passion in your way!!',
                      buttonColor: Color.fromRGBO(156, 128, 161, 1),
                      assetImagePath: 'assets/Image/Mental_Health/s4.png',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Main_blog()));
                      },
                    ),
                    buildHealthCard(
                      title: 'Gk test',
                      description: 'Test your general knowledge',
                      buttonColor: Color.fromRGBO(184, 218, 226, 1),
                      assetImagePath: 'assets/Image/Mental_Health/s5.png',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartGk(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionImageButton(String imagePath, Color backgroundColor,
      {bool isLast = false}) {
    return GestureDetector(
      onTap: () {
        print('Tapped on $imagePath');
      },
      child: Container(
        height: isLast ? 70.h : 70.h,
        width: isLast ? 70.w : 70.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor.withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.all(isLast ? 12.0 : 15.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: onPressed,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Start now',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.play_circle,
                              color: Colors.white, size: 16),
                        ],
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
              SizedBox(height: ScreenUtil().setHeight(20),)
            ],
          ),
        ),
      ),
    );
  }
}
