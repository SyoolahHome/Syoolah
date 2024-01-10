import 'dart:async';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

import '../../constants/abstractions/abstractions.dart';

part 'current_user_comments_state.dart';

class CurrentUserCommentsCubit
    extends CurrentUserTabViewCubit<CurrentUserCommentsState> {
  /// The Nostr Stream for the user comment events.
  NostrEventsStream currentUserCommentsStream;

  /// The sub that will listen to [currentUserCommentsStream.stream].
  StreamSubscription<NostrEvent>? _currentUserCommentsSubscription;

  /// {@macro current_user_posts_state}
  CurrentUserCommentsCubit({
    required this.currentUserCommentsStream,
  }) : super(CurrentUserCommentsInitial()) {
    init();
  }

  @override
  Future<void> close() async {
    currentUserCommentsStream.close();
    _currentUserCommentsSubscription?.cancel();

    return super.close();
  }

  @override
  void init() {
    _handleCurrentUserPosts();
    Future.delayed(durationToWaitBeforeHidingLoadingIndicator, () {
      emit(state.copyWith(
        shouldShowLoadingIndicator: false,
      ));
    });
  }

  /// Insert new event state to ours reflecting changes to UI.
  void _handleCurrentUserPosts() {
    _currentUserCommentsSubscription =
        currentUserCommentsStream.stream.listen((event) {
      emit(
        state.copyWith(
          currentUserComments: [...state.currentUserComments, event],
        ),
      );
    });
  }
}
