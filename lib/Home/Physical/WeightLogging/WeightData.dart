// developed by Ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WeightData extends StatefulWidget {
  const WeightData({super.key});

  @override
  State<WeightData> createState() => _WeightDataState();
}

class _WeightDataState extends State<WeightData> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
    'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, String>> _weightData = [];

  @override
  void initState() {
    super.initState();
    _fetchWeightData();
  }

  Future<void> _fetchWeightData() async {
    try {
      // Access the weight data path in the database
      final snapshot = await _database
          .child('users/$uid/physical_health/weight')
          .get();

      if (snapshot.exists) {
        final weightMap = Map<String, dynamic>.from(snapshot.value as Map);
        List<Map<String, String>> weightList = [];

        weightMap.forEach((date, details) {
          weightList.add({
            'date': date,
            'reading_weight': details['reading_weight'] ?? 'N/A',
            'time': details['time'] ?? 'N/A',
          });
        });

        // Sort the list by date in descending order
        weightList.sort((a, b) {
          DateTime dateA = DateFormat('dd-MM-yyyy').parse(a['date']!);
          DateTime dateB = DateFormat('dd-MM-yyyy').parse(b['date']!);
          return dateB.compareTo(dateA);
        });

        setState(() {
          _weightData = weightList;
        });
      }
    } catch (e) {
      print('Error fetching weight data: $e');
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
        backgroundColor: Color.fromRGBO(118, 207, 226, 1),
        foregroundColor: Colors.white,
        title: Text(
          "Weight Data",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: _weightData.isEmpty
          ? Center(child: Text('no data found'))
          : ListView.builder(
        itemCount: _weightData.length,
        itemBuilder: (context, index) {
          final weightItem = _weightData[index];
          return ListTile(
            title: Text(
              '${weightItem['date']}',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Weight : ${weightItem['reading_weight']} Kg'
                ),
                Text(
                    '${weightItem['time']}'
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
