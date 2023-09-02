import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:equatable/equatable.dart';

part 'user_follows_state.dart';

/// {@template user_follows_cubit}
///  A [Cubit] which manages the state of the followers and following of a user by his public key.
/// {@endtemplate}
class UserFollowsCubit extends Cubit<UserFollowsState> {
  /// The public key of the user whose followers and following we are fetching
  final String userPubKey;

  /// The nostr stream for the user followers.
  final NostrEventsStream userFollowersNostrStream;

  /// The nostr stream for the user following.
  final NostrEventsStream userFollowingsNostrStream;

  /// The subscription that is used to listen to [userFollowersNostrStream.stream].
  StreamSubscription? followersSubscription;

  /// The subscription that is used to listen to [userFollowingsNostrStream.stream].
  StreamSubscription? followingsSubscription;

  /// {@macro user_follows_cubit}
  UserFollowsCubit({
    required this.userPubKey,
    required this.userFollowingsNostrStream,
    required this.userFollowersNostrStream,
  }) : super(UserFollowsState.initial()) {
    _init();
  }

  @override
  Future<void> close() {
    userFollowersNostrStream.close();
    userFollowingsNostrStream.close();

    followersSubscription?.cancel();
    followingsSubscription?.cancel();

    return super.close();
  }

  void _init() {
    _handleUserFollowers();
    _handleUserFollowing();
  }

  void _handleUserFollowers() {
    followersSubscription = userFollowersNostrStream.stream.listen(
      (event) {
        if (state.userFollowersEvents
            .map((e) => e.pubkey)
            .contains(event.pubkey)) {
          return;
        }

        emit(state.copyWith(userFollowersEvents: [
          event,
          ...state.userFollowersEvents,
        ]));
      },
    );
  }

  void _handleUserFollowing() {
    followingsSubscription = userFollowingsNostrStream.stream.listen(
      (event) {
        emit(state.copyWith(userFollowingEvent: event));
      },
    );
  }
}
