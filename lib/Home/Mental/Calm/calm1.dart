import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Calm1 extends StatefulWidget {
  const Calm1({super.key});

  @override
  State<Calm1> createState() => _Calm1State();
}

class _Calm1State extends State<Calm1> {
  bool isPlaying = false;
  double value = 0;

  final player = AudioPlayer();
  Duration? duration;

  final List<String> playlist = [
    "dekha_ek_khawab.mp3",
  ];
  int currentSongIndex = 0;

  void initPlayer() async {
    try {
      await player.setSource(AssetSource(playlist[currentSongIndex]));
      duration = await player.getDuration();
      setState(() {});
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
    player.onPositionChanged.listen((position) {
      setState(() {
        value = position.inSeconds.toDouble();
      });
    });
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playSong(int index) async {
    if (index >= 0 && index < playlist.length) {
      currentSongIndex = index;
      await player.setSource(AssetSource(playlist[currentSongIndex]));
      await player.resume();
      duration = await player.getDuration();
      setState(() {});
    }
  }

  void skipForward() async {
    final newValue = value + 30;
    if (duration != null && newValue < duration!.inSeconds) {
      await player.seek(Duration(seconds: newValue.toInt()));
    }
  }

  void skipBackward() async {
    final newValue = value - 30;
    if (newValue > 0) {
      await player.seek(Duration(seconds: newValue.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 10.w),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/Frame.png',
                      width: 30.w,
                      height: 30.h,
                      color: const Color(0xFF76CFE2),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/calm1.png',
                        width: 300.w,
                        height: 400.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Cloudycloud \n',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'SLEEP MUSIC',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(152, 161, 189, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIconButton(Icons.replay_30, skipBackward),
                    SizedBox(width: 30.w),
                    _buildPlayPauseButton(),
                    SizedBox(width: 30.w),
                    _buildIconButton(Icons.forward_30, skipForward),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(value / 60).floor()}:${(value % 60).floor().toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                    ),
                    if (duration != null)
                      Slider(
                        value: value.clamp(0.0, duration!.inSeconds.toDouble()),
                        min: 0.0,
                        max: duration!.inSeconds.toDouble(),
                        onChanged: (v) {
                          setState(() {
                            value =
                                v.clamp(0.0, duration!.inSeconds.toDouble());
                          });
                        },
                        onChangeEnd: (newValue) async {
                          await player
                              .seek(Duration(seconds: newValue.toInt()));
                          if (isPlaying) {
                            await player.resume();
                          }
                        },
                        activeColor: Colors.grey,
                      ),
                    if (duration != null)
                      Text(
                        "${duration!.inMinutes}:${(duration!.inSeconds % 60).toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 30.h,
            right: 15.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print("Liked!");
                  },
                  child: Image.asset(
                    'assets/like.png',
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    print("Saved!");
                  },
                  child: Image.asset(
                    'assets/save.png',
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 70.w,
      height: 70.h,
      child: IconButton(
        icon: Icon(icon, size: 30.sp, color: Colors.blueGrey),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return Container(
      width: 60.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.blueGrey,
        border: Border.all(color: Colors.grey),
      ),
      child: InkWell(
        onTap: () async {
          if (isPlaying) {
            await player.pause();
          } else {
            await player.resume();
          }
          setState(() {
            isPlaying = !isPlaying;
          });
        },
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 30.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
