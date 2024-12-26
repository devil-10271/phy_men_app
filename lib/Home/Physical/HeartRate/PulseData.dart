// developed by Ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Pulsedata extends StatefulWidget {
  const Pulsedata({super.key});

  @override
  State<Pulsedata> createState() => _PulsedataState();
}

class _PulsedataState extends State<Pulsedata> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
    'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, String>> _pulseData = [];

  @override
  void initState() {
    super.initState();
    _fetchPulseData();
  }

  Future<void> _fetchPulseData() async {
    try {
      // Access the pulse data path in the database
      final snapshot = await _database
          .child('users/$uid/physical_health/pulse')
          .get();

      if (snapshot.exists) {
        final pulseMap = Map<String, dynamic>.from(snapshot.value as Map);
        List<Map<String, String>> pulseList = [];

        pulseMap.forEach((date, details) {
          pulseList.add({
            'date': date,
            'reading_pulse': details['reading_pulse'] ?? 'N/A',
            'time': details['time'] ?? 'N/A',
          });
        });

        // Sort the list by date in descending order
        pulseList.sort((a, b) {
          DateTime dateA = DateFormat('dd-MM-yyyy').parse(a['date']!);
          DateTime dateB = DateFormat('dd-MM-yyyy').parse(b['date']!);
          return dateB.compareTo(dateA);
        });

        setState(() {
          _pulseData = pulseList;
        });
      }
    } catch (e) {
      print('Error fetching pulse data: $e');
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
      body: _pulseData.isEmpty
          ? Center(child: Text('no data found'))
          : ListView.builder(
        itemCount: _pulseData.length,
        itemBuilder: (context, index) {
          final pulseItem = _pulseData[index];
          return ListTile(
            title: Text(
              '${pulseItem['date']}',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Pulse Rate : ${pulseItem['reading_pulse']} BPM'
                ),
                Text(
                    '${pulseItem['time']}'
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
