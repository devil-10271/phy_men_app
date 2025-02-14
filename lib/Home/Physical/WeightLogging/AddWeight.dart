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
    final String date = _dateController.text; // Date in "dd-MM-yyyy" format
    final String time = _timeController.text; // Time in "HH:mm" format
    final String weight = _weightController.text; // Weight as a string

    if (weight.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid weight")),
      );
      return;
    }

    try {
      // Reference to the user's weight data
      final DatabaseReference weightRef =
          _database.child('users/$uid/physical_health/weight');

      // Check if data for the given date exists
      final DataSnapshot snapshot = await weightRef.child(date).get();
      Map<String, dynamic>? existingData = snapshot.value != null
          ? Map<String, dynamic>.from(snapshot.value as Map)
          : null;

      // Prepare the new time entry
      final Map<String, dynamic> newTimeEntry = {
        time: {
          'reading_weight': double.tryParse(weight) ?? 0.0,
        }
      };

      // Update the time field for the date
      if (existingData != null) {
        final Map<String, dynamic> timeData = existingData['time'] != null
            ? Map<String, dynamic>.from(existingData['time'] as Map)
            : {};
        timeData.addAll(newTimeEntry); // Add or update the time entry
        existingData['time'] = timeData;
      } else {
        // Create a new entry for the date
        existingData = {'time': newTimeEntry};
      }

      // Save the updated data back to Firebase
      await weightRef.child(date).set(existingData);

      // Limit the number of dates to the last 7
      final DataSnapshot allDatesSnapshot = await weightRef.get();
      final Map<dynamic, dynamic>? allDatesData = allDatesSnapshot.value != null
          ? Map<dynamic, dynamic>.from(allDatesSnapshot.value as Map)
          : null;

      if (allDatesData != null && allDatesData.keys.length > 30) {
        // Sort dates to find the oldest ones
        final List<String> sortedDates = allDatesData.keys
            .map((key) => key.toString())
            .toList()
          ..sort((a, b) => DateFormat('dd-MM-yyyy')
              .parse(a)
              .compareTo(DateFormat('dd-MM-yyyy').parse(b)));

        // Remove the oldest dates to keep only the last 7
        while (sortedDates.length > 30) {
          final String oldestDate = sortedDates.removeAt(0);
          await weightRef.child(oldestDate).remove();
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Weight data updated successfully")),
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
    return Center( // Ensure it appears at the center
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
              children: [
                const Center(
                  child: Text(
                    'Weight Measurement',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                _buildInputRow("Date", _dateController, TextInputType.datetime),
                _buildDivider(),
                _buildInputRow("Time", _timeController, TextInputType.datetime),
                _buildDivider(),
                _buildInputRow("Weight (kg)", _weightController, TextInputType.datetime),
                _buildDivider(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton(
                      label: 'Cancel',
                      color: Colors.white,
                      textColor: Color.fromRGBO(171, 222, 232, 1),
                      onPressed: () => Navigator.pop(context),
                    ),
                    _buildButton(
                      label: 'Save',
                      color: Color.fromRGBO(171, 222, 232, 1),
                      textColor: Colors.white,
                      onPressed: _saveDataToFirebase,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}

Widget _buildInputRow(
    String label, TextEditingController controller, TextInputType type) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
        ),
      ),
      Container(
        height: 50.h,
        width: 150.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(border: InputBorder.none),
          keyboardType: type,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
        ),
      ),
    ],
  );
}

Widget _buildDivider() {
  return Divider(color: Colors.grey, height: 20.h);
}

Widget _buildButton({
  required String label,
  required Color color,
  required Color textColor,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Text(
        label,
        style: TextStyle(
            color: textColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

void showCenteredDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Center(
        child: Container(
          height: 450.h,
          width: 400.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: AddWeight(),
        ),
      ),
    ),
  );
}
