// developed by Ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phy_men_app/Home/Physical/HeartRate/AddHeartRate.dart';
import 'package:phy_men_app/Home/Physical/HeartRate/PulseData.dart';

class PulseGraph extends StatefulWidget {
  const PulseGraph({super.key});

  @override
  State<PulseGraph> createState() => _PulseGraphState();
}

class _PulseGraphState extends State<PulseGraph> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
        'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _fetchPulseData();
  }

  List<FlSpot> pulseData = []; // List for FlSpot data points
  List<String> lastFiveDates = []; // List to store last 5 date labels
  List<double> pulseValues = []; // List to store pulse values

  Future<void> _fetchPulseData() async {
    try {
      final snapshot = await _database
          .child('users/$uid/physical_health/pulse')
          .get();

      if (snapshot.exists) {
        print('Pulse Data: ${snapshot.value}');
        final pulseDataMap = snapshot.value as Map<dynamic, dynamic>;

        // Process and generate pulseData, lastFiveDates, and pulseValues
        _processPulseData(pulseDataMap);
      } else {
        print('No pulse data found.');
        setState(() {
          pulseData = [];
          lastFiveDates = [];
          pulseValues = [];
        });
      }
    } catch (e) {
      print('Error fetching pulse data: $e');
    }
  }

  void _processPulseData(Map<dynamic, dynamic> pulseDataMap) {
    final Map<DateTime, double> consolidatedPulseData = {};

    // Date format for parsing
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    // Consolidate data by unique dates
    pulseDataMap.forEach((dateKey, dateValue) {
      final date = dateFormat.parse(dateKey);

      if (dateValue['time'] != null) {
        final timeEntries = dateValue['time'] as Map<dynamic, dynamic>;
        final pulseReadings = timeEntries.values.map((timeData) {
          return double.tryParse(timeData['reading_pulse'].toString()) ?? 0.0;
        }).toList();

        if (pulseReadings.isNotEmpty) {
          final averagePulse =
              pulseReadings.reduce((a, b) => a + b) / pulseReadings.length;
          consolidatedPulseData[date] = averagePulse;
        }
      }
    });

    // Sort entries by date and extract the last 5
    final sortedEntries = consolidatedPulseData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final lastFiveEntries = sortedEntries.length > 5
        ? sortedEntries.sublist(sortedEntries.length - 5)
        : sortedEntries;

    // Create FlSpot list, date labels, and pulse values
    final spots = lastFiveEntries.map((entry) {
      return FlSpot(
        entry.key.millisecondsSinceEpoch.toDouble(),
        entry.value,
      );
    }).toList();

    final dates = lastFiveEntries.map((entry) {
      return DateFormat('dd-M').format(entry.key); // Format date as "24-12"
    }).toList();

    final pulses = lastFiveEntries.map((entry) => entry.value).toList();

    // Update state
    setState(() {
      pulseData = spots;
      lastFiveDates = dates;
      pulseValues = pulses;
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
        backgroundColor: Color.fromRGBO(248, 132, 146, 1),
        foregroundColor: Colors.white,
        title: Text(
          "Heart Rate",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: pulseData.isEmpty
              ? Center(
                  child: Text('No pulse data available.'),
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
                              color: Color.fromRGBO(248, 132, 146, 0.29),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(15),
                                          left: ScreenUtil().setWidth(15)),
                                      //color: Colors.yellow,
                                      child: Text(
                                        'Average BPM',
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
                                      //color: Colors.yellow,
                                      child: Text(
                                        '70',
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
                          Container(
                            height: ScreenUtil().setHeight(141),
                            width: ScreenUtil().setWidth(189),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromRGBO(245, 245, 245, 1),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(15),
                                          left: ScreenUtil().setWidth(15)),
                                      //color: Colors.yellow,
                                      child: Text(
                                        'Standards Limits',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      //color: Colors.green,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Pulse Rate : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(height: 18),
                                                Row(
                                                  children: [
                                                    Text('60 - 100'),
                                                  ],
                                                ),
                                                Row(
                                                  children: [Text('bpm')],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'BPM',
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
                                        builder: (context) =>
                                            Pulsedata()));
                              },
                              child: Text(
                                'view graph data',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(248, 132, 146, 1),
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
                                spots: pulseData,
                                isCurved: false,
                                isStrokeCapRound: false,
                                barWidth: 0, // Hide connecting line
                                color: Colors.transparent,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                    return FlDotCirclePainter(
                                      radius: 5,
                                      color: Colors.red,
                                    );
                                  },
                                ),
                              ),
                            ],
                            titlesData: FlTitlesData(
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 10,
                                  getTitlesWidget: (value, meta) {
                                    if (value >= 60 && value <= 100) {
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
                            // minX: pulseData.first.x,
                            // maxX: pulseData.last.x,
                            minY: 60,
                            maxY: 100,
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              drawHorizontalLine: true,
                              horizontalInterval: 10,
                              getDrawingHorizontalLine: (value) {
                                if (value >= 60 && value <= 100) {
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
                                  style: TextStyle(fontSize: 10),
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
                                builder: (context) => AddHeartRate(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(248, 132, 146, 1),
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
