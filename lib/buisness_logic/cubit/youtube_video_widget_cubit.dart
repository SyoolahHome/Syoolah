import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'youtube_video_widget_state.dart';

class YoutubeVideoWidgetCubit extends Cubit<YoutubeVideoWidgetState> {
  final String url;
  YoutubePlayerController? controller;

  YoutubeVideoWidgetCubit(this.url) : super(YoutubeVideoWidgetInitial()) {
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }
}
