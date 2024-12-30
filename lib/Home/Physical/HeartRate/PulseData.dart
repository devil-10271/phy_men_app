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

  List<Map<String, dynamic>> _pulseData = [];

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

        List<Map<String, dynamic>> pulseList = [];

        pulseMap.forEach((date, details) {
          // Safely cast details['time'] as a Map
          final times = Map<String, dynamic>.from(details['time'] ?? {});

          // Add each date and its time object to the list
          pulseList.add({
            'date': date,
            'times': times, // Corrected key here
          });
        });

        // Sort the list by date in descending order
        pulseList.sort((a, b) {
          DateTime dateA = DateFormat('dd-MM-yyyy').parse(a['date']);
          DateTime dateB = DateFormat('dd-MM-yyyy').parse(b['date']);
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
          ? Center(child: Text('No data found'))
          : ListView.builder(
        itemCount: _pulseData.length,
        itemBuilder: (context, index) {
          final pulseItem = _pulseData[index];
          final times = pulseItem['times'] as Map<String, dynamic>; // Corrected key here

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text(
                '${pulseItem['date']}',
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              children: times.entries.map((entry) {
                final time = entry.key;
                final reading = entry.value['reading_pulse'];
                return ListTile(
                  title: Text(
                    'Time: $time',
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    'Pulse: ${reading ?? "N/A"} bpm',
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
