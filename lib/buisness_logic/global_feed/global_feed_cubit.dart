import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

part 'global_feed_state.dart';

class GlobalFeedCubit extends Cubit<GlobalFeedState> {
  Stream<NostrEvent> feedPostsStream;

  GlobalFeedCubit({
    required this.feedPostsStream,
  }) : super(GlobalFeedInitial()) {
    handleStreams();
  }

  void handleStreams() {
    feedPostsStream.listen(
      (event) {
        final sortedList = [...state.feedPosts, event].reversed.toList();
        sortedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        emit(
          state.copyWith(
            feedPosts: sortedList,
          ),
        );
      },
    );
  }
}
