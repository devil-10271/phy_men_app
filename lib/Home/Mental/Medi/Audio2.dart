import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Audio2 extends StatefulWidget {
  const Audio2({super.key});

  @override
  State<Audio2> createState() => _Audio2State();
}

class _Audio2State extends State<Audio2> with TickerProviderStateMixin {
  bool isPlaying = false;
  double value = 0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  final player = AudioPlayer();
  Duration? duration;

  final List<String> playlist = [
    "medi2.mp3",
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
  }

  @override
  void dispose() {
    player.dispose();
    _controller.dispose();
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
    if (newValue < duration!.inSeconds) {
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
            Center(
              child: Text(
                'Deep Breath',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: ScreenUtil().setSp(45), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: ScreenUtil().setHeight(300), end: isPlaying ? ScreenUtil().setHeight(300) : ScreenUtil().setHeight(320)),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, size, child) {
                    return ClipOval(
                      child: RotationTransition(
                        turns: _animation,
                        child: Image.asset(
                          'assets/Image/Mental_Health/Medi/audio_image2.png',
                          width: size,
                          height: size,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
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
            _controller.stop();
          } else {
            await player.resume();
            _controller.repeat();
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