import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Home/Mental/Mentalmain.dart';
import 'package:phy_men_app/Home/Physical/PhysicalMain.dart';
import 'package:phy_men_app/Profile/Profile.dart';

import 'ChatBot/Chatbot.dart';
//developed by ayush

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _curre_ = 0;
  List CALL = [Hom_p(), MentalMain(), Physicalmain(), ChatBot(), Profile()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SafeArea(
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.grey.shade200,
            items: const [
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.home_outlined,
                  color: Color.fromARGB(255, 129, 218, 250),
                ),
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.health_and_safety,
                  color: Colors.blue,
                ),
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.directions_run,
                  color: Colors.red,
                ),
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.newspaper,
                  color: Colors.green,
                ),
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.perm_identity,
                  color: Colors.blue,
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _curre_ = index;
              });
            },
          ),
          body: CALL[_curre_],
        ),
      ),

    );
  }
}

class Hom_p extends StatefulWidget {
  const Hom_p({super.key});

  @override
  State<Hom_p> createState() => _Hom_pState();
}

class _Hom_pState extends State<Hom_p> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'mental'; // Track the selected category
  final user = FirebaseAuth.instance.currentUser;

  final Map<String, double> _containerOffsets = {
    'mental': 0.0,
    'physical': 174.0,
    'ai': 348.0,
  };

  void scrollToContainer(String type) {
    setState(() {
      _selectedCategory = type;
    });

    final double offset = _containerOffsets[type] ?? 0.0;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Color _getDotColor(String type) {
    switch (type) {
      case 'physical':
        return Color.fromRGBO(242, 143, 143, 0.3);
      case 'ai':
        return Color.fromRGBO(146, 227, 169, 0.4);
      default:
        return Color.fromRGBO(118, 207, 226, 0.3);
    }
  }

  Widget _buildCategoryText(String text, String type) {
    final bool isSelected = _selectedCategory == type;
    return GestureDetector(
      onTap: () => scrollToContainer(type),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            if (isSelected)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _getDotColor(type),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: 430,
              height: 932,
              color: const Color.fromARGB(255, 129, 218, 250),
            ),
            Image.asset("assets/Image/Home/main_photo.png"),
            Positioned(
              top: ScreenUtil().setHeight(266),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user!.displayName.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: ScreenUtil().setSp(18),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'what would you like to do today?',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: ScreenUtil().setSp(15),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Flexible(
                                        child: SizedBox(
                                      width: 40,
                                    )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile()));
                                        },
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/Image/Edit_Profile/unknown.png',
                                            height: ScreenUtil().setHeight(60),
                                            width: ScreenUtil().setWidth(60),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(50)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildCategoryText('Mental Health', 'mental'),
                                  _buildCategoryText(
                                      'Physical Health', 'physical'),
                                  _buildCategoryText('Chat Bot', 'ai'),
                                ],
                              ),
                              const SizedBox(height: 30),
                              SingleChildScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MentalMain()));
                                      },
                                      child: Container(
                                        width: 157,
                                        height: 239,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              118, 207, 226, 0.3),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Expanded(
                                          child: Image.asset(
                                            'assets/Image/Home/mental_health.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 17),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Physicalmain()));
                                      },
                                      child: Container(
                                        width: 157,
                                        height: 239,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              242, 143, 143, 0.3),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 80),
                                          child: Expanded(
                                            child: Image.asset(
                                              'assets/Image/Home/physical_health.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 17),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatBot()));
                                      },
                                      child: Container(
                                        width: 157,
                                        height: 239,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              146, 227, 169, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 70),
                                          child: Expanded(
                                            child: Image.asset(
                                              'assets/Image/Home/ai.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 17,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35),
                              const Text(
                                'Trending',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    width: 74,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          186, 104, 200, 0.22),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                          'assets/Image/Home/t1.png'),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Keep Your body healthy',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Weight loss is not just about losing pounds.\n it’s about gaining confidence, self-love, and a healthier, happier life.',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
