// developed by ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddWeight extends StatefulWidget {
  const AddWeight({super.key});

  @override
  State<AddWeight> createState() => _AddWeightState();
}

class _AddWeightState extends State<AddWeight> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _weightController;

  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
    'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: DateFormat('dd-M-yyyy').format(DateTime.now()),
    );
    _timeController = TextEditingController(
      text: DateFormat('hh:mm a').format(DateTime.now()),
    );
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _saveDataToFirebase() async {
    final String date = _dateController.text;
    final String time = _timeController.text;
    final String weight = _weightController.text;

    if (weight.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid pulse rate")),
      );
      return;
    }

    try {
      // Reference to the pulse data for the current user
      final DatabaseReference pulseRef = _database.child('users/$uid/physical_health/weight');

      // Fetch existing pulse data
      final DataSnapshot snapshot = await pulseRef.get();
      final Map<String, dynamic>? existingData =
      snapshot.value != null ? Map<String, dynamic>.from(snapshot.value as Map) : null;

      // Add the new data
      await pulseRef.child(date).set({
        "reading_weight": weight,
        "time": time,
      });

      // Check if there are more than 7 entries and remove the oldest
      if (existingData != null && existingData.keys.length >= 7) {
        final List<String> sortedDates = existingData.keys.toList()
          ..sort((a, b) => DateFormat('yyyy-MM-dd').parse(a).compareTo(DateFormat('yyyy-MM-dd').parse(b)));

        // Remove the oldest date
        final String oldestDate = sortedDates.first;
        await pulseRef.child(oldestDate).remove();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pulse data updated successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: ScreenUtil().setHeight(466),
          width: ScreenUtil().setWidth(428),
          child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Weight Measurement',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                Container(
                  //color: Colors.green,
                  height: ScreenUtil().setHeight(54),
                  width: ScreenUtil().setWidth(388),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(54),
                        width: ScreenUtil().setWidth(150),
                        child: TextField(
                          controller: _dateController, // Set the controller here
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.datetime, // Ensure the keyboard supports date input
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildDivider(),
                Container(
                  //color: Colors.green,
                  height: ScreenUtil().setHeight(54),
                  width: ScreenUtil().setWidth(388),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(54),
                        width: ScreenUtil().setWidth(150),
                        child: TextField(
                          controller: _timeController, // Set the controller here
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.datetime, // Ensure the keyboard supports date input
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildDivider(),
            Container(
              height: ScreenUtil().setHeight(54),
              width: ScreenUtil().setWidth(388),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weight (kg)',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(54),
                    width: ScreenUtil().setWidth(100),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      //color: Colors.yellow
                    ),
                    child: TextField(
                      controller: _weightController,
                      decoration:
                      const InputDecoration(border: InputBorder.none),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),

                // Buttons Row
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                  ),
                  child: Row(
                    children: [
                      _buildButton(
                        label: 'Cancel',
                        color: Colors.white,
                        textColor: Color.fromRGBO(118, 207, 226, 1),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      _buildButton(
                        label: 'Save',
                        color: Color.fromRGBO(171, 222, 232, 1),
                        textColor: Colors.white,
                        onPressed: _saveDataToFirebase,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInputRow(String label) {
  return Container(
    //color: Colors.green,
    height: ScreenUtil().setHeight(54),
    width: ScreenUtil().setWidth(388),
    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        Container(
          height: ScreenUtil().setHeight(54),
          width: ScreenUtil().setWidth(100),
          //margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            //color: Colors.yellow
          ),
          child: TextField(
            decoration: InputDecoration(border: InputBorder.none),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

// Divider between input rows
Widget _buildDivider() {
  return Container(
    height: ScreenUtil().setHeight(1),
    width: ScreenUtil().setWidth(388),
    color: Color.fromRGBO(234, 234, 234, 1),
    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
  );
}

// Reusable button
Widget _buildButton({
  required String label,
  required Color color,
  required Color textColor,
  required VoidCallback onPressed,
}) {
  return Container(
    height: ScreenUtil().setHeight(54),
    width: ScreenUtil().setWidth(189),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20)),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
