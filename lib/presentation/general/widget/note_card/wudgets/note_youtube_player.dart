import 'package:ditto/buisness_logic/cubit/youtube_video_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NoteYoutubePlayer extends StatelessWidget {
  const NoteYoutubePlayer({
    required this.url,
    super.key,
  });

  final String url;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BlocProvider<YoutubeVideoWidgetCubit>(
        create: (context) => YoutubeVideoWidgetCubit(url),
        child: Builder(
          builder: (context) {
            final cubit = context.read<YoutubeVideoWidgetCubit>();
            final youtubeController = cubit.controller;

            return Hero(
              tag: youtubeController.hashCode,
              child: YoutubePlayer(
                controller: youtubeController!,
                bottomActions: <Widget>[
                  IconButton(
                    onPressed: () {
                      cubit.fullScreen(context);
                    },
                    icon: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
