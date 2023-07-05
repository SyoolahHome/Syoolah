import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';

import 'package:equatable/equatable.dart';

import '../../constants/abstractions/abstractions.dart';
import '../../constants/app_configs.dart';

part 'current_user_likes_state.dart';

/// {@template current_user_likes_cubit}
/// The responsible cubit about the current user likes
/// {@endtemplate}
class CurrentUserLikesCubit
    extends CurrentUserTabViewCubit<CurrentUserLikesState> {
  /// The Nostr stream that will receive like events.
  NostrEventsStream currentUserLikedPosts;

  /// The subscription that will manage the listening to the [currentUserLikedPosts.stream].
  StreamSubscription<NostrEvent>? _currentUserLikedPostsSubscription;

  /// {@macro current_user_likes_cubit}
  CurrentUserLikesCubit({
    required this.currentUserLikedPosts,
  }) : super(CurrentUserLikesInitial()) {
    init();
  }

  @override
  Future<void> close() {
    currentUserLikedPosts.close();
    _currentUserLikedPostsSubscription?.cancel();

    return super.close();
  }

  @override
  void init() {
    _handleCurrentUserLikedPosts();
    Future.delayed(durationToWaitBeforeHidingLoadingIndicator, () {
      emit(state.copyWith(shouldShowLoadingIndicator: false));
    });
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
