import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Yoga/videoplayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
    "5 min",
    "3 min",
    "2 min",
    "2 min",
    "2 min",
    "2 min",
    "2 min",
  ];

  final url = [
    'https://youtu.be/inpok4MKVLM?si=T96GCx-KyvKgX5BR',
    'https://youtu.be/J93h_072d3M?si=sm0Q54h6ggT72rm2',
    'https://youtu.be/nvFm30ZAZRY?si=sh-xx0gSUj86hqrl',
    'https://youtu.be/VpHz8Mb13_Y?si=-5N0cSsjvZxmz9KW',
    'https://youtu.be/OvICfrfnnxA?si=lsp-WpQUS-ZupvPQ',
    'https://youtu.be/2WE-L8iyu0U?si=klBbIQZjVZ1Bv5-u',
    'https://youtu.be/8IBl8CfRyEA?si=xtvyciWXcO1KxqP1'
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
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
