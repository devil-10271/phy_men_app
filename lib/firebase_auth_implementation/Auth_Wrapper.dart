import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:phy_men_app/Auth/login.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/Splash_Screen/splash_screen.dart';

class AuthWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return SplashScreen();
            } else if(snapshot.hasData)
              {
                return HomePage();
              } else{
                return Log_in();
              }
        }
    );
  }
}