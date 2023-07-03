import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

part 'current_user_posts_state.dart';

/// {@template current_user_posts_state}
///  The responsible cubit about the current user posts
/// {@endtemplate}
class CurrentUserPostsCubit extends Cubit<CurrentUserPostsState> {
  /// The Nostr Stream for the user posts events
  NostrEventsStream currentUserPostsStream;

  /// The sub that will listen to [currentUserPostsStream.stream].
  StreamSubscription<NostrEvent>? _currentUserPostsSubscription;

  /// {@macro current_user_posts_state}
  CurrentUserPostsCubit({
    required this.currentUserPostsStream,
  }) : super(CurrentUserPostsInitial()) {
    _handleCurrentUserPosts();
  }

  @override
  Future<void> close() async {
    currentUserPostsStream.close();
    _currentUserPostsSubscription?.cancel();

    return super.close();
  }

  /// Insert new event state to ours reflecting changes to UI.
  void _handleCurrentUserPosts() {
    _currentUserPostsSubscription =
        currentUserPostsStream.stream.listen((event) {
      emit(
        state.copyWith(
          currentUserPosts: [
            event,
            ...state.currentUserPosts,
          ],
        ),
      );
    });
  }
}
