import 'package:flutter/material.dart';

import 'package:phy_men_app/Auth/login.dart';


class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Center(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Log_in()));
        },child: Text('Login')),
        SizedBox(width: 20,),
        InkWell(onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Sign_Up()));
        },child: Text('Sign up'))
        ,
        Container(color: Colors.cyan,height: 200,width: 100,)
      ],
    ))));
  }
}
