import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';

import 'package:equatable/equatable.dart';

part 'current_user_likes_state.dart';

/// {@template current_user_likes_cubit}
/// The responsible cubit about the current user likes
/// {@endtemplate}
class CurrentUserLikesCubit extends Cubit<CurrentUserLikesState> {
  /// The Nostr stream that will receive like events.
  NostrEventsStream currentUserLikedPosts;

  /// The subscription that will manage the listening to the [currentUserLikedPosts.stream].
  StreamSubscription<NostrEvent>? _currentUserLikedPostsSubscription;

  /// {@macro current_user_likes_cubit}
  CurrentUserLikesCubit({
    required this.currentUserLikedPosts,
  }) : super(CurrentUserLikesInitial()) {
    _handleCurrentUserLikedPosts();
  }

  @override
  Future<void> close() {
    currentUserLikedPosts.close();
    _currentUserLikedPostsSubscription?.cancel();

    return super.close();
  }

  /// Insert new event state to ours reflecting changes to UI.
  void _handleCurrentUserLikedPosts() {
    _currentUserLikedPostsSubscription =
        currentUserLikedPosts.stream.listen((event) {
      final newList = <NostrEvent>[
        event,
        ...state.currentUserLikedPosts,
      ];

      emit(state.copyWith(currentUserLikedPosts: newList));
    });
  }
}
