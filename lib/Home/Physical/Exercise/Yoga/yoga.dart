import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/main.dart';

class Yogapage extends StatefulWidget {
  const Yogapage({super.key});

  @override
  State<Yogapage> createState() => _YogapageState();
}

class _YogapageState extends State<Yogapage> {
  void _onPlayTapped() {
    print('Play button tapped');
  }

  var ass_pos = [
    "assets/Image/Yoga/yoga_pose1.png",
    "assets/Image/Yoga/yoga_pose2.png",
    "assets/Image/Yoga/yoga_pose3.png"
  ];
  var title_exer = ["Warm Up", "Sun Salutation", "Cool Down"];
  var type = ["Full Body", "Core", "Relaxation"];
  var dueration = [
    "Beginner : 2 min",
    "Intermediate : 3 min",
    "Beginner : 2 min"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(methods.hex("76CFE2")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: Image.asset(
                  'assets/Image/Yoga/Frame.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/Image/Yoga/title_image.png',
                height: ScreenUtil().setHeight(159.08),
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),

            const SizedBox(height: 20),

            // Exercises section with title
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 20, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Yoga",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/Image/Yoga/healthicons_exercise.png',
                        width: 30,
                        height: 30,
                      ),
                      const Text("7 exercises "),
                      const SizedBox(width: 13),
                      Image.asset(
                        'assets/Image/Yoga/ph_clock.png',
                        width: 30,
                        height: 30,
                      ),
                      const Text("5 minutes"),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Exercise

                  Container(
                    height: 135,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/Image/Yoga/yoga_pose1.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Warm Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 15),
                                  children: [
                                    TextSpan(
                                      text: "Full body\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: "Beginner · 2 min ",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              118, 207, 226, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: ImageIcon(
                            AssetImage('assets/Image/Yoga/ph_play.png'),
                            size: 30,
                            color: Color(methods.hex("76CFE2")),
                          ),
                          onPressed: _onPlayTapped,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Exercise 2
                  Container(
                    height: 135,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/Image/Yoga/yoga_pose2.png',
                              width: 50,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sun Salutation",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 15),
                                  children: [
                                    TextSpan(
                                      text: "Core\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: "Intermediate · 3 min",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              118, 207, 226, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: ImageIcon(
                            AssetImage('assets/Image/Yoga/ph_play.png'),
                            size: 30,
                            color: Color(methods.hex("76CFE2")),
                          ),
                          onPressed: _onPlayTapped,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Exercise 3
                  Container(
                    height: 135,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/Image/Yoga/yoga_pose3.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cool Down",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 15),
                                  children: [
                                    TextSpan(
                                      text: "Relaxation\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: "Beginner · 2 min",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              118, 207, 226, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: ImageIcon(
                            AssetImage('assets/Image/Yoga/ph_play.png'),
                            size: 30,
                            color: Color(methods.hex("76CFE2")),
                          ),
                          onPressed: _onPlayTapped,
                        ),
                      ],
                    ),
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


