import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr/nostr.dart';
import 'package:nostr_client/nostr_client.dart';

part 'home_page_after_login_state.dart';

class HomePageAfterLoginCubit extends Cubit<HomePageAfterLoginState> {
  Stream<NostrEvent> feedPostsStream;

  HomePageAfterLoginCubit({
    required this.feedPostsStream,
  }) : super(const HomePageAfterLoginInitial()) {
    handleStreams();
    connectToRelaysAndSubscribeToTopics();
  }

  void connectToRelaysAndSubscribeToTopics() async {
    try {
      emit(state.copyWith(isLoading: true));

      emit(state.copyWith(didConnectedToRelaysAndSubscribedToTopics: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void handleStreams() {
    feedPostsStream.listen((event) {
      emit(
        state.copyWith(
          feedPosts: [...state.feedPosts, event].reversed.toList(),
        ),
      );
    });
  }
}
