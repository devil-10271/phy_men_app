import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Yogapage extends StatefulWidget {
  const Yogapage({super.key});

  @override
  State<Yogapage> createState() => _YogapageState();
}

class _YogapageState extends State<Yogapage> {
  void _onPlayTapped() {
    print('Play button tapped');
  }

  final List<String> ass_pos = [
    "assets/Image/Physical_Health/Exercise/Yoga/yoga_pose1.png",
    "assets/Image/Physical_Health/Exercise/Yoga/yoga_pose2.png",
    "assets/Image/Physical_Health/Exercise/Yoga/yoga_pose3.png",
    "assets/Image/Physical_Health/Exercise/Yoga/yoga_pose4.png",
    "assets/Image/Physical_Health/Exercise/Yoga/yoga_pose5.png",
    "assets/Image/Physical_Health/Exercise/Yoga/yoga_pose6.png",
    "assets/Image/Physical_Health/Exercise/Yoga/yoga_pose7.png",
  ];

  final List<String> title_exer = [
    "Warm Up",
    "Sun Salutation",
    "Cool Down",
    "Warm Up",
    "Warm Up",
    "Warm Up",
    "Warm Up"
  ];
  final List<String> type = [
    "Full Body",
    "Core",
    "Relaxation",
    "Full Body",
    "Full Body",
    "Full Body",
    "Full Body"
  ];
  final List<String> duration = [
    "Beginner : 2 min",
    "Intermediate : 3 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF76CFE2),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: IconButton(
                icon: Image.asset(
                  'assets/Image/Physical_Health/Exercise/Yoga/Frame.png',
                  width: ScreenUtil().setWidth(30),
                  height: ScreenUtil().setHeight(30),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Center(
              child: Image.asset(
                'assets/Image/Physical_Health/Exercise/Yoga/yoga_title.png',
                height: ScreenUtil().setHeight(159),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Yoga",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/Image/Physical_Health/Exercise/Yoga/exercise.png',
                          width: 30.w,
                          height: 30.h,
                        ),
                        const Text("7 exercises "),
                        const SizedBox(width: 13),
                        Image.asset(
                          'assets/Image/Physical_Health/Exercise/Yoga/clock.png',
                          width: 30.w,
                          height: 30.h,
                        ),
                        const Text("5 minutes"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          itemCount: title_exer.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: ScreenUtil().setHeight(130),
                              padding: const EdgeInsets.all(20.0),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      ass_pos[index],
                                      height: ScreenUtil().setHeight(100),
                                      width: ScreenUtil().setWidth(100),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            title_exer[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 15),
                                              children: [
                                                TextSpan(
                                                  text: type[index] + "\n",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                TextSpan(
                                                  text: duration[index],
                                                  style: const TextStyle(
                                                      color: Color(0xFF76CFE2),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const ImageIcon(
                                      AssetImage(
                                          'assets/Image/Physical_Health/Exercise/Yoga/play.png'),
                                      color: Color(0xFF76CFE2),
                                    ),
                                    onPressed: _onPlayTapped,
                                  ),
                                ],
                              ),
                            );
                          },
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
    );
  }
}
