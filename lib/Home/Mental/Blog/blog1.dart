import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Blog1 extends StatefulWidget {
  const Blog1({super.key});

  @override
  State<Blog1> createState() => _Blog1State();
}

class _Blog1State extends State<Blog1> {
  final List<String> textContent = [
    'Mental health issues are becoming increasingly common, yet stigma remains a major obstacle to seeking help. Misconceptions, societal judgment, and cultural norms often cause individuals to feel ashamed or fearful of admitting they are struggling.',
    'This prevents many from accessing the support they need, leading to prolonged suffering. Breaking these stigmas begins with education and awareness. Mental health challenges are not a sign of weakness, they are a part of the human experience.',
    'Just as physical health requires care, mental health needs equal attention. By encouraging open and honest conversations, we can normalize seeking help and make mental well-being a shared priority',
    'Sharing personal experiences is a powerful way to challenge stereotypes. When people talk about their struggles and triumphs, it inspires others to seek support without fear of judgment. Listening with empathy, offering support, and fostering inclusive environments  in schools, workplaces, and communities can create safe spaces where mental health is taken seriously.',
    'Moreover, media, education systems, and leaders play critical role in addressing stigma. Campaigns, workshops, and mental health resources should be widely promoted to raise awareness and debunk myths. By providing education from a young age, we can cultivate a generation that prioritizes mental well-being and treats it with the same respect as physical health. ',
    'Remember, asking for help is not a weakness but a courageous step toward healing. Together, through understanding and compassion, we can create a society where everyone feels safe to talk about their mental well-being and seek the support they deserve.',
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
                  width: 360.w,
                  height: 300.h,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(171, 147, 175, 1),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '  Breaking Mental Health Stigmas',
                          style: TextStyle(
                            fontSize: 31.sp,
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
                  top: 20.h,
                  left: 10.w,
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
                Positioned(
                  top: 160.h,
                  left: 20.w,
                  child: Image.asset(
                    'assets/blog_image1.png',
                    width: 250.w,
                    height: 210.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.h),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: textContent.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    textContent[index],
                    style: TextStyle(
                      fontSize: 16.sp,
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
