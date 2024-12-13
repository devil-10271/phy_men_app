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
    "assets/yoga_pose1.png",
    "assets/yoga_pose2.png",
    "assets/yoga_pose3.png",
    "assets/yoga_pose4.png",
    "assets/yoga_pose5.png",
    "assets/yoga_pose6.png",
    "assets/yoga_pose7.png",

  ];

  final List<String> title_exer = ["Warm Up", "Sun Salutation", "Cool Down","Warm Up","Warm Up","Warm Up","Warm Up"];
  final List<String> type = ["Full Body", "Core", "Relaxation","Full Body","Full Body","Full Body","Full Body"];
  final List<String> duration = [
    "Beginner : 2 min",
    "Intermediate : 3 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
    "Beginner : 2 min",
  ];

  final List<double> widths = [55.w, 55.w, 55.w, 55.w, 55.w, 55.w, 55.w]; // Custom widths
  final List<double> heights = [100.h, 100.h, 100.h,100.h,100.h,100.h,100.h]; // Custom heights

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF76CFE2),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                icon: Image.asset(
                  'assets/Frame.png',
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
                'assets/yoga_title.png',
                height: 159.h,
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
                    "Yoga",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/exercise.png',
                        width: 30.w,
                        height: 30.h,
                      ),
                      const Text("7 exercises "),
                      const SizedBox(width: 13),
                      Image.asset(
                        'assets/clock.png',
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
                        return Container(
                          height: 150.h,
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
                                  width: widths[index], // Responsive width
                                  height: heights[index], // Responsive height
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title_exer[index],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 15),
                                        children: [
                                          TextSpan(
                                            text: type[index] + "\n",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextSpan(
                                            text: duration[index],
                                            style: const TextStyle(
                                                color: Color(0xFF76CFE2),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const ImageIcon(
                                  AssetImage('assets/play.png'),
                                  size: 35,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
