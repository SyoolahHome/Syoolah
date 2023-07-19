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
  final String id;

  /// The youtube video controller.
  YoutubePlayerController? controller;

  /// {@macro youtube_video_widget_cubit}
  YoutubeVideoWidgetCubit(this.id) : super(null) {
    _init();
  }

  @override
  Future<void> close() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return super.close();
  }

  void _init() {
    controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(),
    );

    if (!cubitsCache.containsKey(id)) {
      cubitsCache[id] = this;
    }
  }
}
