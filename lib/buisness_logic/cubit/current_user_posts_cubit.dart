import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

part 'current_user_posts_state.dart';

class CurrentUserPostsCubit extends Cubit<CurrentUserPostsState> {
  NostrEventsStream currentUserPostsStream;
  StreamSubscription<NostrEvent>? _currentUserPostsSubscription;

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

  void _handleCurrentUserPosts() {
    _currentUserPostsSubscription =
        currentUserPostsStream.stream.listen((event) {
      emit(
        state.copyWith(
          currentUserPosts: [...state.currentUserPosts, event],
        ),
      );
    });
  }
}
