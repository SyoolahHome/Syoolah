import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/youtube_video_full_screen/youtube_video_full_screen.dart';

part 'youtube_video_widget_state.dart';

class YoutubeVideoWidgetCubit extends Cubit<YoutubeVideoWidgetState> {
  final String url;
  YoutubePlayerController? controller;

  YoutubeVideoWidgetCubit(this.url) : super(YoutubeVideoWidgetInitial()) {
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  void fullScreen(BuildContext context) async {
    final navigator = Navigator.of(context);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await navigator.push(
      MaterialPageRoute(
        builder: (context) => YoutubeVideoFullScreen(controller: controller!),
      ),
    );

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
