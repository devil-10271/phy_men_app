import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videoplayer extends StatefulWidget {
  const Videoplayer({super.key, required this.videoid});

  final String videoid;
  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoid,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("player"),
      ),
      body: YoutubePlayer(controller: _controller),
    );
  }
}
