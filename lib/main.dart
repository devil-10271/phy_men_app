import 'package:flutter/material.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/Home/Physical/PhysicalHealth.dart';
import 'package:phy_men_app/Home/Physical/Yoga/yoga.dart';
import 'package:phy_men_app/Profile/edit_profile.dart';
import 'Splash_Screen/splash_screen.dart';
import 'Auth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
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
              home: SplashScreen());
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
    String c = "0xff" + apple;
    c = c.replaceAll('#', '');
    int complete = int.parse(c);
    return complete;
  }
}
