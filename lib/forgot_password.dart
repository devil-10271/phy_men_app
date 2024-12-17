import 'package:phy_men_app/create_password.dart';
import 'package:phy_men_app/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

// this code is develop by ayush
class forgot extends StatefulWidget {
  const forgot({super.key});

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(112, 43, 146, 1),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              //padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/Train,_eat,_sleep,_poster_for_gym_with_fitness_icons,_vector-ai 1.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.only(top: _mediaQuery.size.height * ht(86)),
                      width: _mediaQuery.size.width * wt(127),
                      height: _mediaQuery.size.height * ht(80),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/MWM Logo - Colour-Hi-Res 2.png'),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * ht(45),
                    ),
                    Container(
                      width: _mediaQuery.size.width * wt(190),
                      height: _mediaQuery.size.height * ht(30),
                      child: Center(
                        child: Text(
                          'Forgot Password',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(top: _mediaQuery.size.height * ht(55)),
                      width: _mediaQuery.size.width * wt(428),
                      height: _mediaQuery.size.height * ht(633),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(45),
                            topLeft: Radius.circular(45)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: _mediaQuery.size.height * ht(45),
                          ),
                          Container(
                            width: _mediaQuery.size.width * wt(170),
                            height: _mediaQuery.size.height * ht(160),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/lock.png'),
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          SizedBox(height: _mediaQuery.size.height * ht(50)),
                          Container(
                            //margin: EdgeInsets.only(top: 50),
                            width: _mediaQuery.size.width * wt(358),
                            //height: _mediaQuery.size.height * ht(60),
                            child: Text(
                              'Enter the email associated with your account and we’ll send an email with instructions to reset your password.',
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: _mediaQuery.size.height * ht(30),
                                right: _mediaQuery.size.width * wt(20),
                                left: _mediaQuery.size.width * wt(20)),
                            child: TextField(
                              //style: TextStyle(color: Colors.green),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Enter Email*'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: _mediaQuery.size.height * ht(110),
                                right: _mediaQuery.size.width * wt(20),
                                left: _mediaQuery.size.width * wt(20)),
                            child: Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => otp(),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(112, 43, 146, 1)),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(17),
                                    child: Text(
                                      'GET OTP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double ht(int a) {
  return a / 926;
}

double wt(int a) {
  return a / 428;
}
