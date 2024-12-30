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

  List<Map<String, dynamic>> _bloodData = [];

  @override
  void initState() {
    super.initState();
    _fetchBloodData();
  }

  Future<void> _fetchBloodData() async {
    try {
      final snapshot = await _database
          .child('users/$uid/physical_health/blood_pressure')
          .get();

      if (snapshot.exists) {
        final bloodMap = Map<String, dynamic>.from(snapshot.value as Map);

        List<Map<String, dynamic>> bloodList = [];

        bloodMap.forEach((date, details) {
          final times = Map<String, dynamic>.from(details['time'] ?? {});

          bloodList.add({
            'date': date,
            'times': times,
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
          "Blood Pressure Data",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: _bloodData.isEmpty
          ? Center(child: Text('No data found'))
          : ListView.builder(
        itemCount: _bloodData.length,
        itemBuilder: (context, index) {
          final bloodItem = _bloodData[index];
          final times = bloodItem['times'] as Map<String, dynamic>;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text(
                '${bloodItem['date']}',
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              children: times.entries.map((entry) {
                final time = entry.key;
                final readingSys = entry.value['reading_systole'];
                final readingDia = entry.value['reading_diastole'];

                return ListTile(
                  title: Text(
                    'Time: $time',
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    'Systolic: ${readingSys ?? "N/A"} mmHg\nDiastolic: ${readingDia ?? "N/A"} mmHg',
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
