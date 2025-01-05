import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Mental/Blog/blog1.dart';
import 'package:phy_men_app/Home/Mental/Blog/blog2.dart';
import 'package:phy_men_app/Home/Mental/Blog/blog3.dart';

class Main_blog extends StatefulWidget {
  const Main_blog({super.key});

  @override
  State<Main_blog> createState() => _Main_blogState();
}

class _Main_blogState extends State<Main_blog> {
  final List<Map<String, dynamic>> blogs = [
    {
      'title': 'Breaking Mental health Stigmas',
      'date': '2 days ago',
      'image': 'assets/Image/Mental_Health/Blog/blog_image1.png',
      'page': Blog1(),
    },
    {
      'title': 'How Nutrition Impacts Mental Health',
      'date': '2 days ago',
      'image': 'assets/Image/Mental_Health/Blog/blog_image2.png',
      'page': Blog2(),
    },
    {
      'title': 'Daily self-care Routines to boost Mental health',
      'date': '10 days ago',
      'image': 'assets/Image/Mental_Health/Blog/blog_image3.png',
      'page': Blog3(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // Title Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Blogs \n',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(60),
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(171, 147, 175, 1),
                            ),
                          ),
                          TextSpan(
                            text: '3 Blogs',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(203, 208, 222, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
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
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20)),
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
                                  fontSize: ScreenUtil().setSp(20),
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
                  // Blog List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(10)),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>blogs[index]['page']));
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(360),
                            height: ScreenUtil().setHeight(250),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color.fromRGBO(203, 208, 222, 1),
                                width: 5,
                              ),
                              color: index % 2 == 0
                                  ? Color.fromRGBO(225, 225, 225, 2)
                                  : Color.fromRGBO(171, 147, 175, 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        blogs[index]['title'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        blogs[index]['date'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      blogs[index]['image'],
                                      width: ScreenUtil().setWidth(150),
                                      height: ScreenUtil().setHeight(150),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(80)),
                ],
              ),
            ),
            Positioned(
              right: ScreenUtil().setWidth(20),
              child: IconButton(
                icon: Image.asset(
                  'assets/Image/Mental_Health/Blog/add.png',
                  width: ScreenUtil().setWidth(70),
                  height: ScreenUtil().setHeight(70),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: blogs.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Center(
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           blogs[index]['page']),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: index % 2 == 0
//                                     ? Color.fromRGBO(225, 225, 225, 2)
//                                     : Color.fromRGBO(171, 147, 175, 1),
//                                 padding: EdgeInsets.all(0),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                               ),
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     width: ScreenUtil().setWidth(360),
//                                     height: ScreenUtil().setHeight(250),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       border: Border.all(
//                                         color: Color.fromRGBO(203, 208, 222, 1),
//                                         width: 5,
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: ScreenUtil().setHeight(8),
//                                     left: ScreenUtil().setWidth(8),
//                                     child: Wrap(
//                                       children: [
//                                         Text(
//                                           blogs[index]['title'],
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: ScreenUtil().setSp(18),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//
//                                     ),
//                                   ),
//                                   Text(
//                                     blogs[index]['date'],
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                   Positioned(
//                                     top: ScreenUtil().setHeight(8),
//                                     right: ScreenUtil().setWidth(8),
//                                     child: IconButton(
//                                       iconSize: ScreenUtil().setSp(30),
//                                       icon: Icon(Icons.more_horiz,
//                                           color: Colors.black),
//                                       onPressed: () {},
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: ScreenUtil().setHeight(-35),
//                                     right: ScreenUtil().setWidth(-30),
//                                     child: Image.asset(
//                                       blogs[index]['image'],
//                                       width: ScreenUtil().setWidth(200),
//                                       height: ScreenUtil().setHeight(200),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                               height: ScreenUtil().setHeight(
//                                   40)), // Add spacing between buttons
//                         ],
//                       );
//                     },
//                   ),
