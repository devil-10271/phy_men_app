//developed by ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GKData extends StatefulWidget {
  const GKData({super.key});

  @override
  State<GKData> createState() => _GKDataState();
}

class _GKDataState extends State<GKData> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
        'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, dynamic>> _gkScoreData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchScores();
  }

  Future<void> _fetchScores() async {
    final snapshot =
        await _database.child("users/$uid/mental_health/iq_score").get();
    if (snapshot.exists) {
      final iqData = Map<String, dynamic>.from(snapshot.value as Map);
      setState(() {
        _gkScoreData = iqData.entries
            .map((entry) => {
                  "date": entry.key,
                  "times": Map<String, dynamic>.from(entry.value['time']),
                })
            .toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GK Test Scores"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _gkScoreData.isEmpty
              ? const Center(child: Text("No scores available"))
              : ListView.builder(
                  itemCount: _gkScoreData.length,
                  itemBuilder: (context, index) {
                    final iqItem = _gkScoreData[index];
                    final times = iqItem['times'] as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ExpansionTile(
                        title: Text(
                          '${iqItem['date']}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        children: times.entries.map((entry) {
                          final time = entry.key;
                          final score = entry.value['reading_gkscore'];

                          return ListTile(
                            title: Text(
                              'Time: $time',
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              'GK Score: ${score ?? "N/A"}',
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
