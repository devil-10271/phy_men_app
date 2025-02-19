import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:phy_men_app/Auth/login.dart';
import 'package:phy_men_app/Home/Home_page.dart';
import 'package:phy_men_app/Profile/edit_profile.dart';
import 'package:phy_men_app/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:provider/provider.dart';
import 'package:phy_men_app/Profile/Notification.dart';
import 'Data_retrive.dart'; // For CupertinoSwitch

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
  String? profilePictureUrl;
  final user = FirebaseAuth.instance.currentUser;
  String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
  final ref = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(
        "users/$currentUserId");
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      String url = snapshot
          .child("profile")
          .value
          .toString();
      String name = snapshot
          .child("uname")
          .value
          .toString();
      String email = snapshot
          .child("email")
          .value
          .toString();

      Provider.of<ProfileProvider>(context, listen: false).setProfileData(
          url, name, email);
    } else {
      print("Profile picture not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    var hei = screen.size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: screen.size.height * ht(context, 180),
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
                          top: screen.size.height * ht(context, 33),
                          right: screen.size.width * wt(context, 170),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(90),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage()));
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
                          top: screen.size.height * ht(context, 75),
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
                            top: hei * ht(context, 100), left: 20),
                        child: ClipOval(
                            child: Consumer<ProfileProvider>(
                                builder: (context, profileProvider, child) {
                                  return CachedNetworkImage(
                                    imageUrl: profileProvider.profilePictureUrl ??
                                        "",
                                    // Guaranteed to be non-null & non-empty
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'assets/Image/Edit_Profile/unknown.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                  );
                                }
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screen.size.height * ht(context, 115),
                            left: 145),
                        child: Consumer<ProfileProvider>(
                            builder: (context, profileProvider, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profileProvider.name ?? "No name Available",
                                    style: TextStyle(
                                      color: Color.fromRGBO(245, 245, 245, 1),
                                      fontSize: screen.size.width *
                                          wt(context, 16),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Text(
                                    profileProvider.email ?? "No Email Available",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screen.size.width *
                                          wt(context, 16),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              );
                            }
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 30,),
      
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Edit_Profile()));
      
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
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
                        ElevatedButton(
                          onPressed: () async {
                            await _logout(context);
                            // Navigate to Register
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout,
                                  color: Colors.redAccent
                              ),
                              SizedBox(width: screen.size.width * wt(context, 10)),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: screen.size.width * wt(context, 16),
                                ),
                              ),
                            ],
                          ),
                        ),
      
                      ],
                    ),
                    // Padding between buttons
                  ],
                ),
              ),
            ),
          ],
        ),
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
            _buildSwitchRow('Email Notification  ', _laa, (value) {
              setState(() => _laa = value);
            }),


          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value,
      ValueChanged<bool> onChanged) {
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
Future<void> _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut(); // Sign out the usery
    print("User signed out successfully"); // Debugging
    // Force navigation to the LoginScreen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Log_in()),
          (route) => false, // Remove all routes from the stack
    );
    print("Navigated to LoginScreen"); // Debugging
  } catch (e) {
    print("Logout failed: $e"); // Debugging
  }
}
