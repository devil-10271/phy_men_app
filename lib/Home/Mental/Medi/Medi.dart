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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: IconButton(
                icon: Image.asset(
                  'assets/Frame.png',
                  width: 30.w,
                  height: 30.h,
                  color: const Color(0xFF76CFE2),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'What time would you \nlike to ',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'meditate?\n',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 194, 188, 1),
                      ),
                    ),
                    TextSpan(
                      text:
                          'Any time you can choose but We \n recommend first thing in the morning.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 245, 249, 1),
                    borderRadius: BorderRadius.circular(30),
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
                        itemHeight: 60,
                        itemWidth: 80,
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
                        itemHeight: 60,
                        itemWidth: 80,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: timeformat == "AM"
                                      ? Color.fromRGBO(225, 225, 229, 1)
                                      : Color.fromRGBO(245, 245, 249, 1),
                                  border: Border.all(
                                      color: Color.fromRGBO(225, 225, 229, 1))),
                              child: const Text(
                                "AM",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  timeformat = "PM";
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    color: timeformat == "AM"
                                        ? Color.fromRGBO(245, 245, 249, 1)
                                        : Color.fromRGBO(225, 225, 229, 1),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(225, 225, 229, 1))),
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
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Which day would you like to \n meditate?\n',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Everyday is best, but we recommend \n picking at least five.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color.fromRGBO(63, 65, 71, 1)
                            : Color.fromRGBO(245, 245, 249, 1),
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Color.fromRGBO(225, 225, 229, 1)),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 20,
                            color: isSelected ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Color.fromRGBO(255, 194, 188, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
            TextButton(
              onPressed: () {
                print('NO THANKS button pressed');
              },
              child: Center(
                child: Text(
                  'NO THANKS',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
