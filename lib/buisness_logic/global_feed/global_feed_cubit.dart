import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

part 'global_feed_state.dart';

class FeedCubit extends Cubit<GlobalFeedState> {
  Stream<NostrEvent> feedPostsStream;
  StreamSubscription? _streamSubscription;
  FeedCubit({
    required this.feedPostsStream,
  }) : super(GlobalFeedInitial()) {
    handleStreams();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  void handleStreams() {
    _streamSubscription?.cancel();
    feedPostsStream.listen(
      (event) {
        final sortedList = [...state.feedPosts, event].reversed.toList();
        sortedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        if (!isClosed) {
          emit(
            state.copyWith(
              feedPosts: sortedList,
            ),
          );
        }
      },
    );
  }
}
