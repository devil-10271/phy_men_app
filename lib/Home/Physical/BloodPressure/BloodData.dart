// developed by Ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BloodData extends StatefulWidget {
  const BloodData({super.key});

  @override
  State<BloodData> createState() => _BloodDataState();
}

class _BloodDataState extends State<BloodData> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
    'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, String>> _bloodData = [];

  @override
  void initState() {
    super.initState();
    _fetchBloodData();
  }

  Future<void> _fetchBloodData() async {
    try {
      // Access the blood data path in the database
      final snapshot = await _database
          .child('users/$uid/physical_health/blood_pressure')
          .get();

      if (snapshot.exists) {
        final bloodMap = Map<String, dynamic>.from(snapshot.value as Map);
        List<Map<String, String>> bloodList = [];

        bloodMap.forEach((date, details) {
          bloodList.add({
            'date': date,
            'reading_systole': details['reading_systole'] ?? 'N/A',
            'reading_diastole': details['reading_diastole'] ?? 'N/A',
            'time': details['time'] ?? 'N/A',
          });
        });

        // Sort the list by date in descending order
        bloodList.sort((a, b) {
          DateTime dateA = DateFormat('dd-MM-yyyy').parse(a['date']!);
          DateTime dateB = DateFormat('dd-MM-yyyy').parse(b['date']!);
          return dateB.compareTo(dateA);
        });

        setState(() {
          _bloodData = bloodList;
        });
      }
    } catch (e) {
      print('Error fetching blood data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: InkWell(
          borderRadius: BorderRadius.circular(90),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        backgroundColor: Color.fromRGBO(248, 132, 146, 1),
        foregroundColor: Colors.white,
        title: Text(
          "Pulse Data",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: _bloodData.isEmpty
          ? Center(child: Text('no data found'))
          : ListView.builder(
        itemCount: _bloodData.length,
        itemBuilder: (context, index) {
          final pulseItem = _bloodData[index];
          return ListTile(
            title: Text(
              '${pulseItem['date']}',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Systolic : ${pulseItem['reading_systole']} mmHg'
                    ),
                    Text(
                        '${pulseItem['time']}'
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Diastolic : ${pulseItem['reading_diastole']} mmHg'
                    ),
                    Text(
                        '${pulseItem['time']}'
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
