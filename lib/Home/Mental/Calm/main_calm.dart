import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm1.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm2.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm3.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm4.dart';

class Main_calm extends StatefulWidget {
  const Main_calm({super.key});

  @override
  State<Main_calm> createState() => _Main_calmState();
}

class _Main_calmState extends State<Main_calm> {
  final List<Map<String, dynamic>> calmButtons = [
    {
      'image': 'assets/Image/Mental_Health/Calm/calm_button1.png',
      'text': 'Cloudycloud',
      'page': Calm1(),
    },
    {
      'image': 'assets/Image/Mental_Health/Calm/calm_button2.png',
      'text': 'Landscapes',
      'page': Calm2(),
    },
    {
      'image': 'assets/Image/Mental_Health/Calm/calm_button3.png',
      'text': 'Sparkles',
      'page': Calm3(),
    },
    {
      'image': 'assets/Image/Mental_Health/Calm/calm_button4.png',
      'text': 'Oceanwaves',
      'page': Calm4(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setHeight(0.35 * MediaQuery.of(context).size.height),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(35))),
                    image: DecorationImage(
                      image: AssetImage('assets/Image/Mental_Health/Calm/calm_back.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: ScreenUtil().setHeight(30),
                  right: ScreenUtil().setWidth(15),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Like");
                        },
                        child: Image.asset(
                          'assets/Image/Mental_Health/Calm/like.png',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setHeight(40),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      GestureDetector(
                        onTap: () {
                          print("Save");
                        },
                        child: Image.asset(
                          'assets/Image/Mental_Health/Calm/save.png',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setHeight(40),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'CALM MUSIC\n',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' 45 MIN : SLEEP MUSIC\n',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(152, 161, 189, 1),
                      ),
                    ),
                    TextSpan(
                      text: ' Ease the mind into a restful night’s sleep with these deep, ambient tones.',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(17),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/Image/Mental_Health/Calm/love.png',
                    height: ScreenUtil().setHeight(20),
                    width: ScreenUtil().setWidth(20),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(20)),
                  Image.asset(
                    'assets/Image/Mental_Health/Calm/headphone.png',
                    width: ScreenUtil().setWidth(20),
                    height: ScreenUtil().setHeight(40),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text(
                    'Listening',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(20)),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Center(
              child: Container(
                height: ScreenUtil().setHeight(5),
                color: Colors.grey,
                width: MediaQuery.of(context).size.width * 0.95,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16.0)),
              child: Wrap(
                spacing: ScreenUtil().setWidth(25.0),
                children: List.generate(calmButtons.length, (index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => calmButtons[index]['page'],
                            ),
                          );
                        },
                        child: Container(
                          height: ScreenUtil().setHeight(150),
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
                            child: Image.asset(
                              calmButtons[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(5)),
                      Text(
                        calmButtons[index]['text'],
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(5)),
                      Text(
                        '45 MIN : SLEEP MUSIC',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: Color.fromRGBO(152, 161, 189, 1),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ],
        ),
      ),
    );
  }
}