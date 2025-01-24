import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';

class Medi extends StatefulWidget {
  const Medi({super.key});

  @override
  State<Medi> createState() => _MediState();
}

class _MediState extends State<Medi> {
  var hour = 0;
  var min = 0;
  var timeformat = "AM";
  List<String> days = ["SU", "M", "T", "W", "TH", "F", "S"];
  Set<String> selectedDays = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(15),
                    left: ScreenUtil().setWidth(20)),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: ScreenUtil().setSp(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(10)),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'What time would you like to ',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(43),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'meditate?\n',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(43),
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 194, 188, 1),
                        ),
                      ),
                      TextSpan(
                        text:
                            'Any time you can choose but We recommend first thing in the morning.',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(21),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 245, 249, 1),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NumberPicker(
                          minValue: 0,
                          maxValue: 12,
                          value: hour,
                          zeroPad: true,
                          infiniteLoop: true,
                          itemHeight: ScreenUtil().setHeight(60),
                          itemWidth: ScreenUtil().setWidth(80),
                          onChanged: (value) {
                            setState(() {
                              hour = value;
                            });
                          },
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                          selectedTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(225, 225, 229, 1)),
                              bottom: BorderSide(
                                  color: Color.fromRGBO(225, 225, 229, 1)),
                            ),
                          ),
                        ),
                        NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: min,
                          zeroPad: true,
                          infiniteLoop: true,
                          itemHeight: ScreenUtil().setHeight(60),
                          itemWidth: ScreenUtil().setWidth(80),
                          onChanged: (value) {
                            setState(() {
                              min = value;
                            });
                          },
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                          selectedTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(225, 225, 229, 1)),
                              bottom: BorderSide(
                                  color: Color.fromRGBO(225, 225, 229, 1)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              timeformat = "AM";
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20),
                                    vertical: ScreenUtil().setHeight(10)),
                                decoration: BoxDecoration(
                                    color: timeformat == "AM"
                                        ? Color.fromRGBO(225, 225, 229, 1)
                                        : Color.fromRGBO(245, 245, 249, 1),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(225, 225, 229, 1))),
                                child: const Text(
                                  "AM",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(10)),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    timeformat = "PM";
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(20),
                                      vertical: ScreenUtil().setHeight(10)),
                                  decoration: BoxDecoration(
                                      color: timeformat == "AM"
                                          ? Color.fromRGBO(245, 245, 249, 1)
                                          : Color.fromRGBO(225, 225, 229, 1),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              225, 225, 229, 1))),
                                  child: const Text(
                                    "PM",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(10)),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Which day would you like to meditate?\n',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(35),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Everyday is best, but we recommend picking at least five.',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(23),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(25)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: days.map((day) {
                    bool isSelected = selectedDays.contains(day);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedDays.remove(day);
                          } else {
                            selectedDays.add(day);
                          }
                        });
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color.fromRGBO(63, 65, 71, 1)
                              : Color.fromRGBO(245, 245, 249, 1),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Color.fromRGBO(225, 225, 229, 1)),
                        ),
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: ScreenUtil().setHeight(40),
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: ScreenUtil().setSp(20)),
                      backgroundColor: Color.fromRGBO(255, 194, 188, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(30)),
                      ),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      print('Save button pressed');
                    },
                    child: const Text('Save'),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'NO THANKS',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(20)),
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
