import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Yoga/videoplayer.dart';

class Cardiopage extends StatefulWidget {
  const Cardiopage({super.key});

  @override
  State<Cardiopage> createState() => _CardioState();
}

class _CardioState extends State<Cardiopage> {
  void _onPlayTapped() {
    print('Play button tapped');
  }

  final List<String> ass_pos = [
    "assets/Image/Physical_Health/Exercise/Cadio/cardio_pose1.png",
    "assets/Image/Physical_Health/Exercise/Cadio/cardio_pose1.png",
    "assets/Image/Physical_Health/Exercise/Cadio/cardio_pose3.png",
    "assets/Image/Physical_Health/Exercise/Cadio/cardio_pose4.png",
    "assets/Image/Physical_Health/Exercise/Cadio/cardio_pose5.png",
    "assets/Image/Physical_Health/Exercise/Cadio/cardio_pose6.png",
    "assets/Image/Physical_Health/Exercise/Cadio/cardio_pose7.png",
  ];

  final List<String> title_exer = [
    "Warm Up",
    "Warm Up",
    "Warm Up",
    "Warm Up",
    "Warm Up",
    "Warm Up",
    "Warm Up"
  ];
  final List<String> type = [
    "Full Body",
    "Full Body",
    "Full Body",
    "Full Body",
    "Full Body",
    "Full Body",
    "Full Body",
  ];
  final List<String> duration = [
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
  ];

  final List<String> url = [
    "https://youtu.be/pH5bl36t-ik?si=uhej5YF24feAB9bN",
    "htt://youtu.be/0LaoF369azs?si=nHfd2L2FYY47loNj",
    "https://youtu.be/xcomIo8MWyc?si=0kMetqi5T78OCDys",
    "https://youtu.be/l5ij5MJpVP0?si=O2xjtCQCjmjgJ2uV",
    "https://youtu.be/FI51zRzgIe4?si=et3KNSONBlgJSuPh",
    "https://youtu.be/u-e0ZO5L0s0?si=qhnOlKJhk6LbA2KB",
    "https://youtu.be/TIEjZggRC_w?si=sNXT8cwJKW9b6hD-"
  ];
  // Custom heights

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF76CFE2),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: Image.asset(
                    'assets/Image/Physical_Health/Exercise/Cadio/Frame.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/Image/Physical_Health/Exercise/Cadio/cardio_title.png',
                  height: 150.h,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
              const SizedBox(height: 20),
              Container(

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
                      "Cardio",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/Image/Physical_Health/Exercise/Cadio/exercise.png',
                          width: 30.w,
                          height: 30.h,
                        ),
                        const Text("7 exercises "),
                        const SizedBox(width: 13),
                        Image.asset(
                          'assets/Image/Physical_Health/Exercise/Cadio/clock.png',
                          width: 30.w,
                          height: 30.h,
                        ),
                        const Text("5 minutes"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 400.h,
                        child: ListView.builder(
                          itemCount: title_exer.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                final id=YoutubePlayer.convertUrlToId(url[index]);

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Videoplayer(videoid: id!)));
                              },
                              child: Container(
                                height: ScreenUtil().setHeight(130),
                                padding: const EdgeInsets.all(20.0),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black)
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
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
