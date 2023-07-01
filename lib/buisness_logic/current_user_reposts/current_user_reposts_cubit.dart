import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

part 'current_user_reposts_state.dart';

class CurrentUserRepostsCubit extends Cubit<CurrentUserRepostsState> {
  NostrEventsStream currentUserReposts;
  StreamSubscription<NostrEvent>? _currentUserRepostsSubscription;

  CurrentUserRepostsCubit({
    required this.currentUserReposts,
  }) : super(CurrentUserRepostsInitial()) {
    _handleCurrentUserRepostsStrem();
  }

  _handleCurrentUserRepostsStrem() {
    _currentUserRepostsSubscription = currentUserReposts.stream.listen((event) {
      emit(
        state.copyWith(
          currentUserReposts: [event, ...state.currentUserReposts],
        ),
      );
    });
  }
}
