// developed by ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddHeartRate extends StatefulWidget {
  const AddHeartRate({super.key});

  @override
  State<AddHeartRate> createState() => _AddHeartRateState();
}

class _AddHeartRateState extends State<AddHeartRate> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _pulseController;

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
    _pulseController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _saveDataToFirebase() async {
    final String date = _dateController.text;
    final String time = _timeController.text;
    final String pulse = _pulseController.text;

    if (pulse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid pulse rate")),
      );
      return;
    }

    try {
      // Reference to the pulse data for the current user
      final DatabaseReference pulseRef = _database.child('users/$uid/physical_health/pulse');

      // Fetch existing pulse data
      final DataSnapshot snapshot = await pulseRef.get();
      final Map<String, dynamic>? existingData =
      snapshot.value != null ? Map<String, dynamic>.from(snapshot.value as Map) : null;

      // Add the new data
      await pulseRef.child(date).set({
        "reading_pulse": pulse,
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
                    'Heart Rate Reading',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                _buildInputRow("Date", _dateController, TextInputType.datetime),
                _buildDivider(),
                _buildInputRow("Time", _timeController, TextInputType.datetime),
                _buildDivider(),
                Container(
                  height: ScreenUtil().setHeight(54),
                  width: ScreenUtil().setWidth(388),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pulse Rate (bpm)',
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
                          controller: _pulseController,
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
                        textColor: const Color.fromRGBO(118, 207, 226, 1),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      _buildButton(
                        label: 'Save',
                        color: const Color.fromRGBO(171, 222, 232, 1),
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

  Widget _buildInputRow(
      String label, TextEditingController controller, TextInputType type) {
    return Container(
      height: ScreenUtil().setHeight(54),
      width: ScreenUtil().setWidth(388),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Container(
            height: ScreenUtil().setHeight(54),
            width: ScreenUtil().setWidth(150),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(border: InputBorder.none),
              keyboardType: type,
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
    );
  }

  Widget _buildDivider() {
    return Container(
      height: ScreenUtil().setHeight(1),
      width: ScreenUtil().setWidth(388),
      color: const Color.fromRGBO(234, 234, 234, 1),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
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
