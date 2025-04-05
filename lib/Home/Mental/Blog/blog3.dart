import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Blog3 extends StatefulWidget {
  const Blog3({super.key});

  @override
  State<Blog3> createState() => _Blog3State();
}

class _Blog3State extends State<Blog3> {
  final List<String> textContent = [
    '''Daily Self-Care Routines to Boost Mental Health
In our fast-paced lives, self-care often takes a back seat, yet it is crucial for maintaining mental well-being. Incorporating small, consistent habits into your daily routine can significantly improve your mood, focus, and overall health.
Start your day with mindfulness. 

Spend 5-10 minutes meditating, practicing deep breathing, or journaling your thoughts to set a calm and positive tone for the day. These simple practices help clear your mind, reduce stress, and enhance self-awareness.

Engage in physical activities like walking, yoga, or stretching exercises. Movement releases endorphins—natural mood boosters—that combat anxiety and stress. Even a short 15-minute walk can refresh your body and mind.
Prioritize hobbies and creativity. 

Set aside time for activities that bring you joy, such as reading, painting, gardening, or cooking. These moments of creativity and relaxation allow you to recharge and express yourself.

Nourish your body. Stay hydrated, eat nutritious meals rich in vitamins, and avoid skipping meals. Proper nutrition provides the energy and balance your brain needs to function effectively. Equally important is sleep—aim for 7-8 hours of restful sleep to restore both your body and mind.

Finally, disconnect from digital distractions. Taking regular breaks from screens allows you to focus on yourself, reflect, and unwind. Spend this time enjoying nature, engaging in deep conversations, or simply being present in the moment.

Self-care is not a luxury but a necessity for a healthy mind and body. By incorporating these routines into your day, you can build resilience, reduce stress, and create a life that feels balanced and fulfilling.
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
                height: ScreenUtil().setHeight(380),
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
                              'Daily Self-Care Routines to Boost Mental Health',
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
                        'assets/Image/Mental_Health/Blog/blog_image3.png',
                        height: ScreenUtil().setHeight(250),
                        width: ScreenUtil().setWidth(250),
                        fit: BoxFit.fill,
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
