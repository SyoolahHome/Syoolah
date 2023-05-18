import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'youtube_video_widget_state.dart';

class YoutubeVideoWidgetCubit extends Cubit<YoutubeVideoWidgetState> {
  final String url;
  YoutubePlayerController? controller;

  YoutubeVideoWidgetCubit(this.url) : super(YoutubeVideoWidgetInitial()) {
    controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(url) ?? '',
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );
  }
}
