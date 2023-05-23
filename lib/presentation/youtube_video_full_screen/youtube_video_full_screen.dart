import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoFullScreen extends StatefulWidget {
  const YoutubeVideoFullScreen({
    super.key,
    required this.controller,
  });

  final YoutubePlayerController controller;

  @override
  State<YoutubeVideoFullScreen> createState() => _YoutubeVideoFullScreenState();
}

class _YoutubeVideoFullScreenState extends State<YoutubeVideoFullScreen> {
  YoutubePlayerController? controller;
  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.controller.initialVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        startAt: widget.controller.flags.startAt,
        showLiveFullscreenButton: false,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.controller.hashCode,
        child: YoutubePlayer(
          bottomActions: <Widget>[
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            ProgressBar(controller: controller, isExpanded: true),
            RemainingDuration(controller: controller),
            PlaybackSpeedButton(controller: controller),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
            ),
          ],
          controller: controller!,
        ),
      ),
    );
  }
}
