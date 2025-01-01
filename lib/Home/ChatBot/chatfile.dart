  import 'package:flutter/material.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_chat_bubble/chat_bubble.dart';
  class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
  }

  class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      children: [
        // Header Section
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(CupertinoIcons.back),
                ),
                Center(child: Text('Motivational Quotes')),
              ],
            ),
          ),
          height: ScreenUtil().setHeight(142),
          width: ScreenUtil().setWidth(438),
          decoration: BoxDecoration(
            color: Color.fromRGBO(148, 227, 169, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        // Chat Bubble Section
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              // Sender Bubble
              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                backGroundColor: Color.fromRGBO(146, 227, 169, 1),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: Text(
                    "Hey, send me motivational quotes",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              // Time Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    "03:30 PM",
                    style: TextStyle(
                      color: Color.fromRGBO(74, 74, 74, 1),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // Receiver Bubble
              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                backGroundColor: Color.fromRGBO(245, 245, 245, 1),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "If your dreams don’t scare you, they are too small.",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                backGroundColor: Color.fromRGBO(245, 245, 245, 1),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "Change is painful, but nothing is as painful as staying stuck somewhere you don’t belong.",
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "03:31 PM",
                    style: TextStyle(
                      color: Color.fromRGBO(74, 74, 74, 1),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                backGroundColor: Color.fromRGBO(146, 227, 169, 1),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "Thanks",
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                ),
              ),
              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                backGroundColor: Color.fromRGBO(146, 227, 169, 1),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "Send me few more",
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    "03:34 PM",
                    style: TextStyle(
                      color: Color.fromRGBO(74, 74, 74, 1),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 19),
              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                backGroundColor: Color.fromRGBO(245, 245, 245, 1),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "Yeah Sure",
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                ),
              ),

              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                backGroundColor: Color.fromRGBO(245, 245, 245, 1),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "If your dreams don’t scare you, they are too small.",
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                ),
              ),

              ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                backGroundColor: Color.fromRGBO(245, 245, 245, 1),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "Nothing is impossible. The word itself says I’m possible! #DailyAffirmations",
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "03:40 PM",
                    style: TextStyle(
                      color: Color.fromRGBO(74, 74, 74, 1),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Type a message...',
                    labelStyle: TextStyle(color: Colors.black,fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    suffixIcon: Stack(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(top:1.5),
                          child: Image.asset('assets/Image/Chat_Bot/Ellipse 98.png', width: 44.5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:11,left:10),
                          child: Image.asset(
                            'assets/Image/Chat_Bot/Vector.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

               // Add more ChatBubbles as required...
            ],
          ),
        ),
        // Message Input Field

      ],
    ),
  );
  }
  }

  void showTooltip(BuildContext context, String message) {}

  void hideTooltip() {}

