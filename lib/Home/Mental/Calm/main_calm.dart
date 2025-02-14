import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm1.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm2.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm3.dart';
import 'package:phy_men_app/Home/Mental/Calm/calm4.dart';


class main_calm extends StatefulWidget {
  const main_calm({super.key});

  @override
  State<main_calm> createState() => _main_calmState();
}

class _main_calmState extends State<main_calm> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: ScreenUtil().setHeight(220),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(35),
                        bottomLeft: Radius.circular(35),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/Image/Mental_Health/Calm/calm_back.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(10),
                      left: ScreenUtil().setWidth(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: ScreenUtil().setSp(30),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'CALM MUSIC\n',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(35),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '35 MIN : SLEEP MUSIC\n',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(152, 161, 189, 1),
                        ),
                      ),
                      TextSpan(
                        text: 'Ease the mind into a restful night’s sleep with these deep, ambient tones.',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(2),
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width * 0.95,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                child: Wrap(
                  spacing: ScreenUtil().setWidth(25),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
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
                          '15 min : SLEEP MUSIC',
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
              SizedBox(height: ScreenUtil().setHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}