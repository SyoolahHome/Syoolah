import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:bloc/bloc.dart';
import '../../presentation/youtube_video_full_screen/youtube_video_full_screen.dart';

/// {@template youtube_video_widget_cubit}
/// The responsible cubit about youtube video widget that is used to preview a video in the app.
/// {@endtemplate}
class YoutubeVideoWidgetCubit extends Cubit<Null> {
  static final cubitsCache = <String, YoutubeVideoWidgetCubit>{};

  // The youtube video url.
  final String url;

  /// The youtube video controller.
  YoutubePlayerController? controller;

  /// {@macro youtube_video_widget_cubit}
  YoutubeVideoWidgetCubit(this.url) : super(null) {
    _init();
  }

  /// TODO: review this feature.
  /// Opens the youtube video widget in full screen mode.
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

  void _init() {
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    if (!cubitsCache.containsKey(url)) {
      cubitsCache[url] = this;
    }
  }
}
