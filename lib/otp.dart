import 'package:phy_men_app/create_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// this code is develop by ayush
class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  @override
  Widget build(BuildContext context) {

    var _mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: double.infinity,
          // width: _mediaQuery.size.width * wt(428),
          height: _mediaQuery.size.height * ht(436),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: _mediaQuery.size.height * ht(30)),
                child: Center(
                  child: Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: _mediaQuery.size.height * ht(20)),
              Container(
                //margin: EdgeInsets.only(top: 20),
                width: _mediaQuery.size.width * wt(358),
                //height: 40,
                child: Text(
                  'Please enter four digit code sent to your mobile number (480) 555-0121',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              SizedBox(height: _mediaQuery.size.height * ht(40),),
              Container(
                //margin: EdgeInsets.only(top: 40),
                child: OtpTextField(
                  numberOfFields: 4,
                  borderColor: Color.fromRGBO(204, 204, 204, 1),
                  fieldWidth: _mediaQuery.size.width * wt(54),
                  fieldHeight: _mediaQuery.size.height * ht(54),
                  borderRadius: BorderRadius.circular(10),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _mediaQuery.size.height * ht(20),
                    right: _mediaQuery.size.width * wt(20),
                    left: _mediaQuery.size.width * wt(20)),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Didn’t receive code? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Resend',
                              style: TextStyle(
                                color: Color.fromRGBO(112, 43, 146, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),

                      ),

                      Container(
                        child: Text(
                          '00:45',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _mediaQuery.size.height * ht(73),
                    right: _mediaQuery.size.width * wt(20),
                    left: _mediaQuery.size.width * wt(20)),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => create()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(112, 43, 146, 1)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(17),
                        child: Text(
                          'Next',
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
