import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Blog2 extends StatefulWidget {
  const Blog2({super.key});

  @override
  State<Blog2> createState() => _Blog2State();
}

class _Blog2State extends State<Blog2> {
  final List<String> textContent = [
    '''How Nutrition Impacts Mental Health'
   “You are what you eat” isn’t just a saying; it’s backed by science. The food we consume plays a significant role in not only our physical health but also our mental wellbeing. Proper nutrition provides essential nutrients that fuel the brain, regulate mood, and help manage stress. 
Foods rich in omega3 fatty acids—such as salmon, chia seeds, and walnuts—are known to improve brain function and reduce symptoms of depression. Similarly, complex carbohydrates found in whole grains, fruits, and vegetables help stabilize energy levels and prevent mood swings.

Nutrientdense foods like leafy greens, berries, and nuts provide vitamins and antioxidants that protect the brain from oxidative stress.
Gut health also has a profound impact on mental health. Probiotics in yogurt, kefir, and other fermented foods help maintain a healthy gut microbiome, which is closely linked to emotional wellbeing.

A healthy gut produces neurotransmitters like serotonin, often called the “happy chemical,” which plays a key role in regulating mood.
On the flip side, diets high in sugar and processed foods can lead to inflammation, mood swings, fatigue, and even anxiety. Excessive consumption of sugary drinks, fast food, and refined carbs disrupts energy balance and cognitive function, leaving you feeling emotionally drained.

Hydration is another often overlooked factor. Dehydration can negatively impact concentration, cognitive performance, and overall mood. Ensuring you drink enough water throughout the day keeps both your mind and body functioning optimally.

Incorporating a balanced diet full of whole, nutrientdense foods can significantly improve mental clarity, emotional stability, and overall wellbeing. Small changes—like replacing sugary snacks with fruits or adding omega-3-rich foods to your meals—can have a profound impact on your mental health. Remember, nourishing your body is the first step toward nurturing your mind.'
  '''
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setHeight(425),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(171, 147, 175, 1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(ScreenUtil().setWidth(35)),
                      bottomLeft: Radius.circular(ScreenUtil().setWidth(35))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(20)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: ScreenUtil().setWidth(330),
                            child: Text(
                              'How Nutrition Impacts Mental Health',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(25),
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(203, 208, 222, 1),
                                  overflow: TextOverflow.clip),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/Image/Mental_Health/Blog/blog_image2.png',
                        height: ScreenUtil().setHeight(250),
                        width: ScreenUtil().setWidth(250),

                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: textContent.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: Text(
                      textContent[index],
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
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
      ),
    );
  }
}
