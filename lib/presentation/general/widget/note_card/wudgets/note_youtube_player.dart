import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../buisness_logic/youtube_video_widget/youtube_video_widget_cubit.dart';
import '../../../pattern_widget.dart';
import 'yt_container.dart';

class NoteYoutubePlayer extends StatelessWidget {
  const NoteYoutubePlayer({
    required this.url,
    super.key,
  });

  final String url;
  @override
  Widget build(BuildContext context) {
    return YoutubeVideoContainer(
      id: YoutubePlayer.convertUrlToId(url)!,
    );

    return PatternWidget(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: BlocProvider<YoutubeVideoWidgetCubit>(
          create: (context) =>
              YoutubeVideoWidgetCubit.cubitsCache[url] ??
              YoutubeVideoWidgetCubit(url),
          child: Builder(
            builder: (context) {
              final cubit = context.read<YoutubeVideoWidgetCubit>();

              final youtubeController = cubit.controller;

              return YoutubePlayer(controller: youtubeController!);
            },
          ),
        ),
      ),
    );
  }
}
