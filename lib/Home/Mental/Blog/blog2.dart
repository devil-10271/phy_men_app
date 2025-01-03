import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class blog2 extends StatefulWidget {
  const blog2({super.key});

  @override
  State<blog2> createState() => _blog2State();
}

class _blog2State extends State<blog2> {
  final List<String> textContent = [
    '“How Nutrition imapacts Mental Health \nYou are what you eat” isn’t just a saying; it’s backed by science. The food we consume plays a significant role in not only our physical health but also our mental well-being. Proper nutrition provides essential nutrients that fuel the brain, regulate mood, and help manage stress',
    'Foods rich in omega-3 fatty acids—such as salmon, chia seeds, and walnuts—are known to improve brain function and reduce symptoms of depression. Similarly, complex carbohydrates found in whole grains, fruits, and vegetables help stabilize energy levels and prevent mood swings.',
    'Nutrient-dense foods like leafy greens, berries, and nuts provide vitamins and antioxidants that protect the brain from oxidative stress.Gut health also has a profound impact on mental health. Probiotics in yogurt, kefir, and other fermented foods help maintain a healthy gut microbiome, which is closely linked to emotional well-being. ',
    'A healthy gut produces neurotransmitters like serotonin, often called the “happy chemical,” which plays a key role in regulating mood. On the flip side, diets high in sugar and processed foods can lead to inflammation, mood swings, fatigue, and even anxiety. Excessive consumption of sugary drinks, fast food, and refined carbs disrupts energy balance and cognitive function, leaving you feeling emotionally drained.',
    'Hydration is another often overlooked factor. Dehydration can negatively impact concentration, cognitive performance, and overall mood. Ensuring you drink enough water throughout the day keeps both your mind and body functioning optimally.',
    'Incorporating a balanced diet full of whole, nutrient-dense foods can significantly improve mental clarity, emotional stability, and overall well-being. Small changes—like replacing sugary snacks with fruits or adding omega-3-rich foods to your meals—can have a profound impact on your mental health. Remember, nourishing your ',
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
                          ' How Nutrition Impacts Mental Health',
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
                  top: 150.h,
                  left: 10.w,
                  child: Image.asset(
                    'assets/blog_image2.png',
                    width: 280.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
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
