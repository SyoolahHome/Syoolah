import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';

import 'package:equatable/equatable.dart';

part 'current_user_likes_state.dart';

class CurrentUserLikesCubit extends Cubit<CurrentUserLikesState> {
  NostrEventsStream currentUserLikedPosts;
  StreamSubscription<NostrEvent>? _currentUserLikedPostsSubscription;

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

  void _handleCurrentUserLikedPosts() {
    _currentUserLikedPostsSubscription =
        currentUserLikedPosts.stream.listen((event) {
      emit(
        state.copyWith(
          currentUserLikedPosts: [...state.currentUserLikedPosts, event],
        ),
      );
    });
  }
}
