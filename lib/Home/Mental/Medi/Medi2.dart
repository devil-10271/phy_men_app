import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'Medi.dart';
import 'audio1.dart';
import 'audio2.dart';
import 'audio3.dart';
import 'audio4.dart';

class Medi2 extends StatefulWidget {
  const Medi2({super.key});

  @override
  State<Medi2> createState() => _Medi2State();
}

class _Medi2State extends State<Medi2> {
  final List<Map<String, dynamic>> audioItems = [
    {
      'image': 'assets/Image/Mental_Health/Medi/audio_image1.png',
      'page': Audio1(),
    },
    {
      'image': 'assets/Image/Mental_Health/Medi/audio_image2.png',
      'page': Audio2(),
    },
    {
      'image': 'assets/Image/Mental_Health/Medi/audio_image3.png',
      'page': Audio3(),
    },
    {
      'image': 'assets/Image/Mental_Health/Medi/audio_image4.png',
      'page': Audio4(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                    left: ScreenUtil().setWidth(20)),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: ScreenUtil().setSp(30),
                    )),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Meditate",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(45),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    Text(
                      "Take some time to make your \n soul happy^^",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(15)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(33),
                    vertical: ScreenUtil().setHeight(25)),
                child: Stack(
                  children: [
                    // Background image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/Image/Mental_Health/Medi/Maskgroup.png",
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(370),
                        height: ScreenUtil().setHeight(120),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 215, 215, 0.6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(25),
                            vertical: ScreenUtil().setHeight(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Daily Calm",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(25))),
                                Text(
                                    "${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().day}: PAUSE PRACTICE",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(17))),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Medi()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(63, 65, 78, 1),
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(14),
                                  child: Icon(Icons.play_arrow,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(1.5),
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width * 0.95,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Recommended for you",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(25),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: audioItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => audioItems[index]['page']),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(audioItems[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
