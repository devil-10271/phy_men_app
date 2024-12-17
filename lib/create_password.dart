
import 'package:flutter/material.dart';
// this code is develop by ayush
class create extends StatefulWidget {
  const create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  @override
  Widget build(BuildContext context) {

    var _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(112, 43, 146, 1),
      body: SingleChildScrollView(


        child: Container(
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
                height: _mediaQuery.size.height * ht(47),
              ),
              Container(
                width: 233,
                height: 50,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Create New Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
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
                    SizedBox(height: _mediaQuery.size.height * ht(38)),
                    Container(
                      //margin: EdgeInsets.only(top: 38),

                      width: _mediaQuery.size.width * wt(140),
                      height: _mediaQuery.size.height * ht(140),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/create_password.png'),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox(height: _mediaQuery.size.height * ht(38)),
                    Container(
                      //margin: EdgeInsets.only(top: 38),
                      width: _mediaQuery.size.width * wt(358),
                      //height: 40,
                      child: Text(
                        'Your new password must be different from that of previously used passwords.',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(height: _mediaQuery.size.height * ht(30)),
                    Container(
                      width: _mediaQuery.size.width * wt(388),
                      child: Column(
                        children: [
                          TextField(
                            //style: TextStyle(color: Colors.green),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Enter Password*'),
                              suffixIcon: Image(
                                image: AssetImage(
                                    'assets/icon/eye-off 1.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _mediaQuery.size.height * ht(15),
                          ),
                          TextField(
                            //style: TextStyle(color: Colors.green),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Confirm Password*'),
                              suffixIcon: Image(
                                image: AssetImage(
                                    'assets/icon/green_tick.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: _mediaQuery.size.height * ht(97),
                          right: _mediaQuery.size.width * wt(20),
                          left: _mediaQuery.size.width * wt(20),
                     ),

                      child: Container(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => null,
                            //     )
                            // );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(112, 43, 146, 1)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(17),
                              child: Text(
                                'SUBMIT',
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
    );
  }
}

double ht(int a) {
  return a / 926;
}

double wt(int a) {
  return a / 428;
}
