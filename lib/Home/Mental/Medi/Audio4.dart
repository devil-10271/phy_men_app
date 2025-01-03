import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Audio4 extends StatefulWidget {
  const Audio4({super.key});

  @override
  State<Audio4> createState() => _Audio4State();
}

class _Audio4State extends State<Audio4> with TickerProviderStateMixin {
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
    "O_mare.mp3",
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h),
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
            Center(
              child: Text(
                'Deep Breath',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: 300.h, end: isPlaying ? 300.h : 320.h),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, size, child) {
                    return ClipOval(
                      child: RotationTransition(
                        turns: _animation,
                        child: Image.asset(
                          'assets/audio_image4.png',
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
            SizedBox(height: 40.h),
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
                    style: TextStyle(color: Colors.grey, fontSize: 20.sp),
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
            _controller.stop();
          } else {
            await player.resume();
            _controller.repeat();
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
