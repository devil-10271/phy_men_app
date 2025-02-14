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
      final DatabaseReference bpRef =
      _database.child('users/$uid/physical_health/blood_pressure');

      final DataSnapshot snapshot = await bpRef.child(date).get();
      Map<String, dynamic>? existingData = snapshot.value != null
          ? Map<String, dynamic>.from(snapshot.value as Map)
          : null;

      final Map<String, dynamic> newTimeEntry = {
        time: {
          'reading_systole': double.tryParse(systolic) ?? 0.0,
          'reading_diastole': double.tryParse(diastolic) ?? 0.0,
        }
      };

      if (existingData != null) {
        final Map<String, dynamic> timeData = existingData['time'] != null
            ? Map<String, dynamic>.from(existingData['time'] as Map)
            : {};
        timeData.addAll(newTimeEntry);
        existingData['time'] = timeData;
      } else {
        existingData = {'time': newTimeEntry};
      }

      await bpRef.child(date).set(existingData);

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
    return Center( // Ensure it appears at the center
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Blood Pressure Reading',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10.h),
            _buildInputRow("Date", _dateController, TextInputType.datetime),
            _buildDivider(),
            _buildInputRow("Time", _timeController, TextInputType.datetime),
            _buildDivider(),
            _buildInputRow("Systolic (mmHg)", _systolicController, TextInputType.number),
            _buildDivider(),
            _buildInputRow("Diastolic (mmHg)", _diastolicController, TextInputType.number),
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

  Widget _buildInputRow(String label, TextEditingController controller, TextInputType type) {
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
          style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// ** Function to show modal in center **
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
          child: AddBloodPressure(),
        ),
      ),
    ),
  );
}
