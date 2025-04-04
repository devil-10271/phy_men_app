// developed by Ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phy_men_app/Home/Physical/BloodPressure/AddBloodPressure.dart';
import 'package:phy_men_app/Home/Physical/BloodPressure/BloodData.dart';

class BloodGraph extends StatefulWidget {
  const BloodGraph({super.key});

  @override
  State<BloodGraph> createState() => _BloodGraphState();
}

class _BloodGraphState extends State<BloodGraph> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
        'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  
  @override
  void initState() {
    super.initState();
    _fetchBloodPressureData();
  }

  List<FlSpot> systolicData = []; // List for systolic FlSpot data points
  List<FlSpot> diastolicData = []; // List for diastolic FlSpot data points
  List<String> lastFiveDates = []; // List to store last 5 date labels

  Future<void> _fetchBloodPressureData() async {
    try {
      final snapshot = await _database
          .child('users/$uid/physical_health/blood_pressure')
          .get();

      if (snapshot.exists) {
        print('Blood Pressure Data: ${snapshot.value}');
        final bloodPressureDataMap = snapshot.value as Map<dynamic, dynamic>;

        // Process and generate systolicData, diastolicData, and lastFiveDates
        _processBloodPressureData(bloodPressureDataMap);
      } else {
        print('No blood pressure data found.');
        setState(() {
          systolicData = [];
          diastolicData = [];
          lastFiveDates = [];
        });
      }
    } catch (e) {
      print('Error fetching blood pressure data: $e');
    }
  }

  void _processBloodPressureData(Map<dynamic, dynamic> bloodPressureDataMap) {
    final Map<DateTime, Map<String, double>> consolidatedData = {};

    // Date format for parsing
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    // Process blood pressure data
    bloodPressureDataMap.forEach((dateKey, dateValue) {
      final date = dateFormat.parse(dateKey);

      if (dateValue['time'] != null) {
        final timeEntries = dateValue['time'] as Map<dynamic, dynamic>;

        double totalSystolic = 0;
        double totalDiastolic = 0;
        int count = 0;

        // Iterate over time entries
        timeEntries.forEach((timeKey, timeData) {
          if (timeData is Map<dynamic, dynamic>) {
            final systolic = double.tryParse(timeData['reading_systole'].toString()) ?? 0.0;
            final diastolic = double.tryParse(timeData['reading_diastole'].toString()) ?? 0.0;

            totalSystolic += systolic;
            totalDiastolic += diastolic;
            count++;
          }
        });

        // Calculate average for systolic and diastolic
        if (count > 0) {
          consolidatedData[date] = {
            'systolic': totalSystolic / count,
            'diastolic': totalDiastolic / count,
          };
        }
      }
    });

    // Sort the entries by date and extract the last 5
    final sortedEntries = consolidatedData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final lastFiveEntries = sortedEntries.length > 5
        ? sortedEntries.sublist(sortedEntries.length - 5)
        : sortedEntries;

    // Create FlSpot lists for systolic and diastolic values
    final systolicSpots = lastFiveEntries.map((entry) {
      return FlSpot(
        entry.key.millisecondsSinceEpoch.toDouble(),
        entry.value['systolic']!,
      );
    }).toList();

    final diastolicSpots = lastFiveEntries.map((entry) {
      return FlSpot(
        entry.key.millisecondsSinceEpoch.toDouble(),
        entry.value['diastolic']!,
      );
    }).toList();

    // Create date labels
    final dates = lastFiveEntries.map((entry) {
      return DateFormat('dd-M').format(entry.key); // Format date as "24-12"
    }).toList();

    // Update state
    setState(() {
      systolicData = systolicSpots;
      diastolicData = diastolicSpots;
      lastFiveDates = dates;
    });
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
        backgroundColor: Color.fromRGBO(190, 227, 246, 1),
        foregroundColor: Colors.white,
        title: Text(
          "Blood Pressure",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: systolicData.isEmpty || diastolicData.isEmpty
              ? Center(
                  child: Text('No blood pressure data available.'),
                )
              : Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16)),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Row(
                        children: [
                          Container(
                            height: ScreenUtil().setHeight(141),
                            width: ScreenUtil().setWidth(189),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:  Color.fromRGBO(190, 227, 246, 0.2),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(15),
                                          left: ScreenUtil().setWidth(15)),
                                      child: Text(
                                        'Average Systolic',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(15),
                                          left: ScreenUtil().setWidth(15)),
                                      child: Text(
                                        '120', // Placeholder value
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(10),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'BP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BloodData()));
                              },
                              child: Text(
                                'view graph data',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color:  Color.fromRGBO(190, 227, 246, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(256),
                        width: ScreenUtil().setWidth(388),
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: systolicData,
                                isCurved: false,
                                isStrokeCapRound: false,
                                barWidth: 2,
                                color: Colors.blue,
                                dotData: FlDotData(
                                  show: false, // Disable dots for systolic line
                                ),
                              ),
                              LineChartBarData(
                                spots: diastolicData,
                                isCurved: false,
                                isStrokeCapRound: false,
                                barWidth: 2,
                                color: Colors.green,
                                dotData: FlDotData(
                                  show: false, // Disable dots for diastolic line
                                ),
                              ),
                            ],
                            titlesData: FlTitlesData(
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 20,
                                  getTitlesWidget: (value, meta) {
                                    if (value >= 0 && value <= 160) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: TextStyle(fontSize: 10),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ),
                            minY: 0,
                            maxY: 160,
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              drawHorizontalLine: true,
                              horizontalInterval: 20,
                              getDrawingHorizontalLine: (value) {
                                if (value >= 0 && value <= 160) {
                                  return FlLine(
                                    color: Colors.grey.withOpacity(0.5),
                                    strokeWidth: 1,
                                    dashArray: [5, 5],
                                  );
                                }
                                return FlLine(color: Colors.transparent);
                              },
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                                bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                                left: BorderSide.none,
                                right: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(left: ScreenUtil().setWidth(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lastFiveDates
                              .map(
                                (date) => Text(
                              date,
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(120),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Container(
                          height: ScreenUtil().setHeight(54),
                          width: ScreenUtil().setWidth(388),
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => AddBloodPressure(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(190, 227, 246, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    100), // Adjust the radius as needed
                              ),
                            ),
                            child: Text(
                              'ADD NEW',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
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
