// Develop by SaHil

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phy_men_app/Home/Mental/Blog/main_blog.dart';
import 'package:phy_men_app/Home/Mental/Calm/main_calm.dart';
import 'package:phy_men_app/Home/Mental/GkTest/StrartGk.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Exercise.dart';
import 'package:phy_men_app/Auth/signup.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Cadio/Cardiopage.dart';
import 'package:phy_men_app/Home/Physical/BloodPressure/Blood.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Cadio/Cardiopage.dart';
import 'package:phy_men_app/Home/Physical/Exercise/Yoga/Yogapage.dart';
import 'package:phy_men_app/Home/Physical/HeartRate/HeartRate.dart';
import 'package:phy_men_app/Home/Physical/HeartRate/PulseData.dart';
import 'package:phy_men_app/Home/Physical/HeartRate/PulseGraph.dart';
import 'package:phy_men_app/Home/Physical/WeightLogging/Weight.dart';
import 'package:phy_men_app/Home/Physical/WeightLogging/WeightData.dart';
import 'package:phy_men_app/Profile/Profile.dart';
import 'package:phy_men_app/Home/Mental/Mentalmain.dart';
import 'package:phy_men_app/Home/Physical/PhysicalMain.dart';
import 'package:phy_men_app/Splash_Screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),

              home: Main_blog()
          );

        });
  }
}

class methods {
  static double ht(int a) {
    return a / 926;
  }

  static double wt(int a) {
    return a / 428;
  }

  static int hex(String apple) {
    String c = "0xff$apple";
    c = c.replaceAll('#', '');
    int complete = int.parse(c);
    return complete;
  }
}
