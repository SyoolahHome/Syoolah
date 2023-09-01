import 'dart:async';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

import '../../constants/abstractions/abstractions.dart';

part 'current_user_reposts_state.dart';

/// {@template current_users_reposts_cubit}
/// The responsible cubit about the user reposts.
/// {@endtemplate}
class CurrentUserRepostsCubit
    extends CurrentUserTabViewCubit<CurrentUserRepostsState> {
  /// The stream of the current user reposts.
  NostrEventsStream currentUserReposts;

  /// The subscription of the current user reposts.
  StreamSubscription<NostrEvent>? _currentUserRepostsSubscription;

  /// {@macro current_users_reposts_cubit}
  CurrentUserRepostsCubit({
    required this.currentUserReposts,
  }) : super(CurrentUserRepostsInitial()) {
    init();
  }

  Future<void> close() {
    currentUserReposts.close();
    _currentUserRepostsSubscription?.cancel();

    return super.close();
  }

  @override
  void init() {
    _handleCurrentUserRepostsStream();
    Future.delayed(durationToWaitBeforeHidingLoadingIndicator, () {
      if (!isClosed) emit(state.copyWith(shouldShowLoadingIndicator: false));
    });
  }

  /// Insert new event state to ours reflecting changes to UI.
  _handleCurrentUserRepostsStream() {
    _currentUserRepostsSubscription = currentUserReposts.stream.listen((event) {
      emit(
        state.copyWith(
          currentUserReposts: <ReceivedNostrEvent>[
            ...state.currentUserReposts,
            event,
          ],
        ),
      );
    });
  }
}
