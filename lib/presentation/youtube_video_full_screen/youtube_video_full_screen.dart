import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../buisness_logic/youtube_video_widget/youtube_video_widget_cubit.dart';

class YoutubeVideoFullScreen extends StatelessWidget {
  const YoutubeVideoFullScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final youtubePlayer = Builder(builder: (context) {
      final cubit = context.read<YoutubeVideoWidgetCubit>();
      final controller = cubit.controller!;

      return YoutubePlayer(
        controller: controller,
        // // bottomActions: <Widget>[
        // //   const SizedBox(width: 14.0),
        // //   CurrentPosition(),
        // //   const SizedBox(width: 8.0),
        // //   ProgressBar(controller: controller, isExpanded: true),
        // //   RemainingDuration(controller: controller),
        // //   PlaybackSpeedButton(controller: controller),
        // //   IconButton(
        // //     onPressed: Navigator.of(context).pop,
        // //     icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
        // //   ),
        // ],
      );
    });

    return Container(
      height: 500,
      color: Colors.green,
      child: BlocProvider(
        create: (context) => YoutubeVideoWidgetCubit(id),
        child: youtubePlayer,
      ),
    );
  }
}
