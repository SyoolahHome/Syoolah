import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../youtube_video_full_screen/youtube_video_full_screen.dart';

class YoutubeVideoContainer extends StatelessWidget {
  const YoutubeVideoContainer({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => YoutubeVideoFullScreen(id: id),
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: <Widget>[
              Image.network(
                YoutubePlayer.getThumbnail(videoId: id),
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : Container(color: Colors.black),
                errorBuilder: (context, _, __) => Image.network(
                  YoutubePlayer.getThumbnail(
                    videoId: id,
                    webp: false,
                  ),
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) =>
                      progress == null ? child : Container(color: Colors.black),
                  errorBuilder: (context, _, __) => Container(),
                ),
              ),
              Icon(
                FlutterRemix.play_fill,
                size: 40.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
