//developed by ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class QuizData extends StatefulWidget {
  const QuizData({super.key});

  @override
  State<QuizData> createState() => _QuizDataState();
}

class _QuizDataState extends State<QuizData> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL:
    'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, dynamic>> _iqScoreData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchScores();
  }

  Future<void> _fetchScores() async {
    final snapshot = await _database.child("users/$uid/mental_health/iq_score").get();
    if (snapshot.exists) {
      final iqData = Map<String, dynamic>.from(snapshot.value as Map);
      setState(() {
        _iqScoreData = iqData.entries
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
        title: const Text("IQ Test Scores"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _iqScoreData.isEmpty
          ? const Center(child: Text("No scores available"))
          : ListView.builder(
        itemCount: _iqScoreData.length,
        itemBuilder: (context, index) {
          final iqItem = _iqScoreData[index];
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
                final score = entry.value['reading_iqscore'];

                return ListTile(
                  title: Text(
                    'Time: $time',
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    'IQ Score: ${score ?? "N/A"}',
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
