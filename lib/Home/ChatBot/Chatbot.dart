import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Splash_Screen/splash_screen.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(CupertinoIcons.back)),
                  SizedBox(width: ScreenUtil().setWidth(140)),
                  Text('Chat Bot')
                ],
              ),
            ),
            height: ScreenUtil().setHeight(142),
            width: ScreenUtil().setWidth(438),
            decoration: BoxDecoration(
                color: Color(hex('92E3A9')),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(250)),
                  Text('How Can I Help You ?'),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: Text("Start a New Chat")),
                      ),
                      style: ButtonStyle()),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Image.asset('assets/Image/Chat_Bot/bro.png')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
