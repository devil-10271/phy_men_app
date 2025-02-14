import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class AddBloodPressure extends StatefulWidget {
  const AddBloodPressure({super.key});

  @override
  State<AddBloodPressure> createState() => _AddBloodPressureState();
}

class _AddBloodPressureState extends State<AddBloodPressure> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _systolicController;
  late TextEditingController _diastolicController;

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
    _systolicController = TextEditingController();
    _diastolicController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    super.dispose();
  }

  Future<void> _saveDataToFirebase() async {
    final String date = _dateController.text;
    final String time = _timeController.text;
    final String systolic = _systolicController.text;
    final String diastolic = _diastolicController.text;

    if (systolic.isEmpty || diastolic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    try {
      // Reference to the blood pressure data for the current user
      final DatabaseReference bpRef =
          _database.child('users/$uid/physical_health/blood_pressure');

      // Fetch existing blood pressure data
      final DataSnapshot snapshot = await bpRef.child(date).get();
      Map<String, dynamic>? existingData = snapshot.value != null
          ? Map<String, dynamic>.from(snapshot.value as Map)
          : null;

      // Add the new data
      // await bpRef.child(date).set({
      //   "time": time,
      //   "reading_systole": systolic,
      //   "reading_diastole": diastolic,
      // });

      //prepare the new entry
      final Map<String, dynamic> newTimeEntry = {
        time: {
          'reading_systole': double.tryParse(systolic) ?? 0.0,
          'reading_diastole': double.tryParse(diastolic) ?? 0.0,
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

      await bpRef.child(date).set(existingData);

      // Check if there are more than 7 entries and remove the oldest
      if (existingData != null && existingData.keys.length >= 30) {
        final List<String> sortedDates = existingData.keys.toList()
          ..sort((a, b) => DateFormat('dd-M-yyyy')
              .parse(a)
              .compareTo(DateFormat('dd-M-yyyy').parse(b)));

        while (sortedDates.length > 30) {
          final String oldestDate = sortedDates.removeAt(0);
          await bpRef.child(oldestDate).remove();
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Blood pressure data saved successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  'Blood Pressure Reading',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              _buildInputRow("Date", _dateController, TextInputType.datetime),
              _buildDivider(),
              _buildInputRow("Time", _timeController, TextInputType.datetime),
              _buildDivider(),
              _buildInputRow("Systolic (mmHg)", _systolicController,
                  TextInputType.number),
              _buildDivider(),
              _buildInputRow("Diastolic (mmHg)", _diastolicController,
                  TextInputType.number),
              _buildDivider(),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 20,
                  // right: 20,
                ),
                child: Row(
                  children: [
                    _buildButton(
                      label: 'Cancel',
                      color: Colors.white,
                      textColor: const Color.fromRGBO(190, 227, 246, 1),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    _buildButton(
                      label: 'Save',
                      color: const Color.fromRGBO(190, 227, 246, 1),
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
            style:TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Container(
            height: ScreenUtil().setHeight(54),
            width: ScreenUtil().setWidth(150),
            decoration: BoxDecoration(border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
            
            child: TextField(
              controller: controller,
              decoration:  InputDecoration(border: InputBorder.none),
              keyboardType: type,
              textAlign: TextAlign.center,
              style:  TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400),
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
      width: ScreenUtil().setWidth(180),
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
