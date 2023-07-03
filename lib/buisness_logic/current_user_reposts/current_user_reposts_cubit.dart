import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

part 'current_user_reposts_state.dart';

/// {@template current_users_reposts_cubit}
/// The responsible cubit about the user reposts.
/// {@endtemplate}
class CurrentUserRepostsCubit extends Cubit<CurrentUserRepostsState> {
  NostrEventsStream currentUserReposts;
  StreamSubscription<NostrEvent>? _currentUserRepostsSubscription;

  /// {@macro current_users_reposts_cubit}
  CurrentUserRepostsCubit({
    required this.currentUserReposts,
  }) : super(CurrentUserRepostsInitial()) {
    _handleCurrentUserRepostsStream();
  }

  /// Insert new event state to ours reflecting changes to UI.
  _handleCurrentUserRepostsStream() {
    _currentUserRepostsSubscription = currentUserReposts.stream.listen((event) {
      emit(
        state.copyWith(
          currentUserReposts: <NostrEvent>[
            event,
            ...state.currentUserReposts,
          ],
        ),
      );
    });
  }
}
