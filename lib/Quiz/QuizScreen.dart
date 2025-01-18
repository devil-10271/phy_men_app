//developed by ayush

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phy_men_app/Quiz/Startquiz.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _currentQuestionIndex = 0;
  List _questions = [];
  int _score = 0;
  String? _selectedAnswer;
  Color? _feedbackColor;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final snapshot = await _firestore.collection('quizzes').get();
    setState(() {
      _questions = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void _onAnswerSelected(String selectedAnswer) {
    setState(() {
      _selectedAnswer = selectedAnswer;
      _feedbackColor =
          Color.fromRGBO(198, 224, 215, 0.41); // Initial feedback color
    });
  }

  void _onContinue() {
    if (_selectedAnswer != null) {
      // Check if the selected answer is correct or incorrect
      if (_selectedAnswer == _questions[_currentQuestionIndex]['answer']) {
        setState(() {
          _feedbackColor = Colors.green; // Correct answer
          _score++;
        });
      } else {
        setState(() {
          _feedbackColor = Colors.red; // Incorrect answer
        });
      }

      // Wait for feedback color to be shown, then proceed
      Future.delayed(Duration(seconds: 2), () {
        if (_currentQuestionIndex < _questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _selectedAnswer = null;
            _feedbackColor = null;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                score: _score,
                totalQuestions:
                    _questions.length, // Pass total number of questions
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(43),
                  vertical: ScreenUtil().setHeight(127),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question Container
                    Container(
                      height: ScreenUtil().setHeight(215),
                      width: ScreenUtil().setWidth(354),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(198, 224, 215, 1),
                        border: Border.all(
                          color: Color.fromRGBO(255, 231, 102, 1),
                          width: ScreenUtil().setWidth(1.5),
                        ),
                      ),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(10),
                            child: Text(
                              '${_currentQuestionIndex + 1}/${_questions.length}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              question['question'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),

                    // Options with feedback
                    ...question['options'].map<Widget>((option) {
                      return Container(
                        height: ScreenUtil().setHeight(60),
                        width: ScreenUtil().setWidth(336),
                        margin: EdgeInsets.only(bottom: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: _selectedAnswer == option
                                ? _feedbackColor
                                : Colors
                                    .white, // Change color based on feedback
                          ),
                          onPressed: () => _onAnswerSelected(option),
                          child: Text(option),
                        ),
                      );
                    }).toList(),

                    // Continue Button
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(93)),
                      child: Container(
                        height: ScreenUtil().setHeight(55),
                        width: ScreenUtil().setWidth(163),
                        child: ElevatedButton(
                          onPressed: _onContinue,
                          child: Text("Continue"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom-Left Image
            Positioned(
              bottom: 0,
              right: ScreenUtil().setWidth(345),
              child: Image.asset(
                'assets/Image/Quiz/Vector1.png',
                height: ScreenUtil().setHeight(100),
                width: ScreenUtil().setWidth(100),
              ),
            ),

            // Bottom-Right Image
            Positioned(
              bottom: 0,
              right: ScreenUtil().setWidth(-7),
              child: Image.asset(
                'assets/Image/Quiz/Vector.png',
                height: ScreenUtil().setHeight(100),
                width: ScreenUtil().setWidth(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultScreen({required this.score, required this.totalQuestions});

  // Function to update the Realtime Database
  Future<void> _updateScoreInDatabase(int score) async {
    final DatabaseReference _database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL:
      'https://phymenapp-default-rtdb.asia-southeast1.firebasedatabase.app',
    ).ref();
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final now = DateTime.now();

    // Format date and time
    String date = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    String time = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    // Database path
    String path = "users/$uid/mental_health/iq_score/$date/time/$time";

    // Update database
    await _database.child(path).set({
      "reading_iqscore": score,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: ScreenUtil().setHeight(403),
                  width: ScreenUtil().setWidth(371.37),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(133)),
                  child: Image(
                    image: AssetImage('assets/Image/Quiz/Group1.png'),
                  ),
                ),
                Text(
                  "Well Done!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(5)),
                Text(
                  "Questions you got right",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(13)),
                Text(
                  "$score out of $totalQuestions",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(198, 224, 215, 1),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(35)),
                Container(
                  height: ScreenUtil().setHeight(54),
                  width: ScreenUtil().setWidth(299),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Startquiz()),
                      );
                    },
                    child: Text(
                      "Retry",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(33)),
                Container(
                  height: ScreenUtil().setHeight(54),
                  width: ScreenUtil().setWidth(299),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color.fromRGBO(198, 224, 215, 1),
                    ),
                    onPressed: () async {
                      // Update the score in Realtime Database
                      await _updateScoreInDatabase(score);

                      // Continue with other logic if needed
                      // For now, navigate back or perform another action
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
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

