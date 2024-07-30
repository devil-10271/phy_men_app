import 'package:flutter/material.dart';
import 'package:phy_men_app/Auth/signup.dart';

class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
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
        Container(color: Colors.red,height: 200,width: 100,)
      ],
    ))));
  }
}
