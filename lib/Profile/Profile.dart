import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Profile/edit_profile.dart'; // For CupertinoSwitch

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _ga = true;
  bool _laa = true;
  bool _lbn = true;
  bool _ls = false;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    var hei = screen.size.height;
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screen.size.height * ht(context, 210),
                      width: screen.size.width * wt(context, 432),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Color.fromRGBO(171, 222, 232, 1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screen.size.width * wt(context, 20),
                        top: screen.size.height * ht(context, 66),
                        right: screen.size.width * wt(context, 170),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(90),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios,
                                size: 23, color: Colors.white),
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: screen.size.width * wt(context, 23),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screen.size.height * ht(context, 105),
                        left: screen.size.width * wt(context, 20),
                      ),
                      child: Container(
                        height: 0.3,
                        width: screen.size.width * wt(context, 388),
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: hei * ht(context, 130), left: 20),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/Image/Edit_Profile/girl.png',
                          height: 110,
                          width: 110,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screen.size.height * ht(context, 145),
                          left: 145),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Elena Norman',
                            style: TextStyle(
                              color: Color.fromRGBO(245, 245, 245, 1),
                              fontSize: screen.size.width * wt(context, 16),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            'Elenanorman22@gamil.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screen.size.width * wt(context, 16),
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screen.size.width * wt(context, 20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                _buildNotificationSettings(screen),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: screen.size.width * wt(context, 20),
                right: screen.size.width * wt(context, 20),
                bottom: screen.size.height * ht(context, 20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ElevatedButton(
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Profile()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(175, 175, 175, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit,
                            color: const Color.fromRGBO(0, 0, 0, 1)),
                        SizedBox(width: screen.size.width * wt(context, 10)),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontSize: screen.size.width * wt(context, 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding between buttons
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Register
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 121, 121, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout,
                            color: const Color.fromRGBO(244, 69, 69, 1)),
                        SizedBox(width: screen.size.width * wt(context, 10)),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: const Color.fromRGBO(244, 69, 69, 1),
                            fontSize: screen.size.width * wt(context, 16),
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
    );
  }

  Widget _buildNotificationSettings(MediaQueryData screen) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screen.size.width * wt(context, 20)),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(245, 245, 245, 1),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            _buildSwitchRow('App Notifications ', _ga, (value) {
              setState(() => _ga = value);
            }),
            const Divider(),
            _buildSwitchRow('Local Area Announcements', _lbn, (value) {
              setState(() => _lbn = value);
            }),
            const Divider(),
            _buildSwitchRow('Email Notification  ', _laa, (value) {
              setState(() => _laa = value);
            }),
            const Divider(),
            _buildSwitchRow('Location Services   ', _ls, (value) {
              setState(() => _ls = value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(
      String label, bool value, ValueChanged<bool> onChanged) {
    var screen = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize:
                screen.size.width * wt(context, 16), // Responsive font size
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          trackColor: Colors.red,
        ),
      ],
    );
  }

  double ht(BuildContext context, int a) {
    return a / 926;
  }

  double wt(BuildContext context, int a) {
    return a / 428;
  }
}
