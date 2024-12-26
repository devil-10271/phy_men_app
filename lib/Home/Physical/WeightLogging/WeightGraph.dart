// developed by Ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phy_men_app/Home/Physical/WeightLogging/AddWeight.dart';
import 'package:phy_men_app/Home/Physical/WeightLogging/WeightData.dart';

class WeightGraph extends StatefulWidget {
  const WeightGraph({super.key});

  @override
  State<WeightGraph> createState() => _WeightGraphState();
}

class _WeightGraphState extends State<WeightGraph> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
    'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _fetchWeightData();
  }

  List<FlSpot> weightData = []; // List for FlSpot data points
  List<String> lastFiveDates = []; // List to store last 5 date labels
  List<double> weightValues = [];

  Future<void> _fetchWeightData() async {
    try {
      final snapshot = await _database
          .child('users/$uid/physical_health/weight')
          .get();

      if (snapshot.exists) {
        print('Weight Data: ${snapshot.value}');
        final weightDataMap = snapshot.value as Map<dynamic, dynamic>;

        // Process and generate weightData, lastFiveDates and weightValues
        _processWeightData(weightDataMap);
      } else {
        print('No weight data found.');
        setState(() {
          weightData = [];
          lastFiveDates = [];
          weightValues = [];
        });
      }
    } catch (e) {
      print('Error fetching weight data: $e');
    }
  }

  void _processWeightData(Map<dynamic, dynamic> weightDataMap) {
    final Map<DateTime, double> consolidatedWeightData = {};

    // Date format for parsing
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    // Consolidate data by unique dates
    weightDataMap.forEach((key, value) {
      final date = dateFormat.parse(key); // Parse date from format "24-12-2024"
      final readingWeight =
          double.tryParse(value['reading_weight'].toString()) ?? 0.0;

      consolidatedWeightData[date] = readingWeight;
    });

    // Sort entries by date and extract the last 5
    final sortedEntries = consolidatedWeightData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final lastFiveEntries = sortedEntries.length > 5
        ? sortedEntries.sublist(sortedEntries.length - 5)
        : sortedEntries;

    // Create FlSpot list, date labels, and weight values
    final spots = lastFiveEntries.map((entry) {
      return FlSpot(
        entry.key.millisecondsSinceEpoch.toDouble(),
        entry.value,
      );
    }).toList();

    final dates = lastFiveEntries.map((entry) {
      return DateFormat('dd-M').format(entry.key); // Format date as "20 Dec"
    }).toList();

    final weight = lastFiveEntries.map((entry) => entry.value).toList();

    // Update state
    setState(() {
      weightData = spots;
      lastFiveDates = dates;
      weightValues = weight;
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
        backgroundColor: Color.fromRGBO(171, 222, 232, 1),
        foregroundColor: Colors.white,
        title: Text(
          "Weight Logging",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: weightData.isEmpty
              ? Center(
            child: Text('No weight data available.'),
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
                        color: Color.fromRGBO(230, 243, 246, 1),
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
                                  'Average Weight',
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
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Weight(kg)',
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
                                      WeightData()));
                        },
                        child: Text(
                          'view graph data',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(171, 222, 232, 1),
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
                          spots: weightData,
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
                                color: Color.fromRGBO(143, 198, 66, 1),
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
                            interval: 20,
                            getTitlesWidget: (value, meta) {
                              if (value >= 40 && value <= 160) {
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
                      minY: 40,
                      maxY: 160,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        drawHorizontalLine: true,
                        horizontalInterval: 20,
                        getDrawingHorizontalLine: (value) {
                          if (value >= 40 && value <= 160) {
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
                          builder: (context) => AddWeight(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(118, 207, 226, 1),
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
