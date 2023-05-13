import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../../buisness_logic/cubit/youtube_video_widget_cubit.dart';

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

        return YoutubePlayer(
          controller: cubit.controller!,
          aspectRatio: 16 / 9,
        );
      }),
    );
  }
}
