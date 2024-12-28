import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'mental'; // Track the selected category

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
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: 430,
                height: 932,
                color: const Color.fromARGB(255, 129, 218, 250),
              ),
              Expanded(child: Image.asset("assets/Image/Home/main_photo.png")),
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
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hi, Miss Norman',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'what would you like to do today?',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
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
                                              height:
                                                  ScreenUtil().setHeight(60),
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
                                    _buildCategoryText(
                                        'Mental Health', 'mental'),
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
                                        onTap: () {},
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
      ),
    );
  }
}
