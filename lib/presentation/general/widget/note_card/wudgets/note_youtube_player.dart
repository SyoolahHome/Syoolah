import 'package:ditto/buisness_logic/cubit/youtube_video_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NoteYoutubePlayer extends StatelessWidget {
  const NoteYoutubePlayer({
    super.key,
    required this.url,
  });

  final String url;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<YoutubeVideoWidgetCubit>(
      create: (context) => YoutubeVideoWidgetCubit(url),
      child: Builder(builder: (context) {
        final cubit = context.read<YoutubeVideoWidgetCubit>();

        return ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: YoutubePlayer(
            controller: cubit.controller!,
          ),
        );
      },),
    );
  }
}
