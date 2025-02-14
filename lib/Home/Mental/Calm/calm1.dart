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
    "Image/Mental_Health/Calm/calm1.mp3",
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10), left: ScreenUtil().setWidth(20)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: ScreenUtil().setSp(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
                      child: Image.asset(
                        'assets/Image/Mental_Health/Calm/calm1.png',
                        width: ScreenUtil().setWidth(350),
                        height: ScreenUtil().setHeight(470),
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
                            fontSize: ScreenUtil().setSp(40),
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'SLEEP MUSIC',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            color: Color.fromRGBO(152, 161, 189, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIconButton(Icons.replay_30, skipBackward),
                    SizedBox(width: ScreenUtil().setWidth(40)),
                    _buildPlayPauseButton(),
                    SizedBox(width: ScreenUtil().setWidth(40)),
                    _buildIconButton(Icons.forward_30, skipForward),
                  ],
                ),
                SizedBox(height: ScreenUtil(). setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(value / 60).floor()}:${(value % 60).floor().toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(20)),
                    ),
                    if (duration != null)
                      Slider(
                        value: value.clamp(0.0, duration!.inSeconds.toDouble()),
                        min: 0.0,
                        max: duration!.inSeconds.toDouble(),
                        onChanged: (v) {
                          setState(() {
                            value = v.clamp(0.0, duration!.inSeconds.toDouble());
                          });
                        },
                        onChangeEnd: (newValue) async {
                          await player.seek(Duration(seconds: newValue.toInt()));
                          if (isPlaying) {
                            await player.resume();
                          }
                        },
                        activeColor: Colors.grey,
                      ),
                    if (duration != null)
                      Text(
                        "${duration!.inMinutes}:${(duration!.inSeconds % 60).toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(20)),
                      ),
                  ],
                ),
              ],
            ),

            SizedBox(width: ScreenUtil().setWidth(10)),

          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(70),
      child: IconButton(
        icon: Icon(icon, size: ScreenUtil().setSp(50), color: Colors.blueGrey),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return Container(
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setHeight(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(60)),
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
          size: ScreenUtil().setSp(40),
          color: Colors.white,
        ),
      ),
    );
  }
}