import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Calm2 extends StatefulWidget {
  const Calm2({super.key});

  @override
  State<Calm2> createState() => _Calm2State();
}

class _Calm2State extends State<Calm2> {
  bool isPlaying = false;
  double value = 0;

  final player = AudioPlayer();
  Duration? duration;

  final List<String> playlist = [
    "calm2.mp3",
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(20)),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: ScreenUtil().setSp(30),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/Image/Mental_Health/Calm/calm4.png',
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setHeight(350),
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
                      text: 'Sparkless \n',
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
                SizedBox(width: ScreenUtil().setWidth(30)),
                _buildPlayPauseButton(),
                SizedBox(width: ScreenUtil().setWidth(30)),
                _buildIconButton(Icons.forward_30, skipForward),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
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
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(70),
      child: InkWell(
        onTap: onPressed,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Icon(icon, size: ScreenUtil().setSp(50), color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return Container(
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setHeight(50),
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
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: ScreenUtil().setSp(40),
          color: Colors.white,
        ),
      ),
    );
  }
}