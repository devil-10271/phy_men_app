import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Blog2 extends StatefulWidget {
  const Blog2({super.key});

  @override
  State<Blog2> createState() => _Blog2State();
}

class _Blog2State extends State<Blog2> {
  final List<String> textContent = [
    '“How Nutrition impacts Mental Health \nYou are what you eat” isn’t just a saying; it’s backed by science...',
    // Add other content here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setHeight(300),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(171, 147, 175, 1),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(80)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'How Nutrition Impacts Mental Health',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(31),
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(203, 208, 222, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(10),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/Frame.png',
                      width: ScreenUtil().setWidth(30),
                      height: ScreenUtil().setHeight(30),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: ScreenUtil().setHeight(150),
                  left: ScreenUtil().setWidth(10),
                  child: Image.asset(
                    'assets/Blog22_image2.png',
                    width: ScreenUtil().setWidth(280),
                    height: ScreenUtil().setHeight(200),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: textContent.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  child: Text(
                    textContent[index],
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}