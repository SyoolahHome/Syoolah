import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:dart_nostr/nostr/model/event/send_event.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';

part 'global_state.dart';

/// {@template global_cubit}
/// The responsible cubit for some related global funtionalities that are needed in many places..
/// {@endtemplate}
class GlobalCubit extends Cubit<GlobalState> {
  /// The nostr stream for the user following.
  NostrEventsStream currentUserFollowing;

  /// The nostr stream for the user followers.
  NostrEventsStream currentUserFollowers;

  /// The subscription that is used to listen to [currentUserFollowing.stream].
  StreamSubscription<ReceivedNostrEvent>? _currentUserFollowingSubscription;

  /// The subscription that is used to listen to [currentUserFollowers.stream].
  StreamSubscription<ReceivedNostrEvent>? _currentUserFollowersSubscription;

  /// {@macro global_cubit}
  GlobalCubit({
    required this.currentUserFollowing,
    required this.currentUserFollowers,
  }) : super(GlobalState.initial()) {
    _handleCurrentUserFollowers();
    _handleCurrentUserFollowing();
  }

  @override
  Future<void> close() {
    currentUserFollowing.close();
    currentUserFollowers.close();

    _currentUserFollowersSubscription?.cancel();
    _currentUserFollowingSubscription?.cancel();

    return super.close();
  }

  /// Weither the user with the [pubKey] is followed or not.
  bool isNoteOwnerFollowed(String pubkey) {
    dynamic tags = state.currentUserFollowing?.tags;
    tags = tags?.map((elem) => elem[1]);

    return tags?.contains(pubkey) ?? false;
  }

  /// {@template follow_user}
  /// Follows the user which have the given [pubKey] by the current authenticated user.
  /// if no user is authnticated, this method will do nothing.
  /// {@endtemplate}
  void followUser(String pubKey) {
    SentNostrEvent newEvent;

    final currentUserPrivateKey = LocalDatabase.instance.getPrivateKey();

    if (currentUserPrivateKey == null) {
      return;
    }

    if (state.currentUserFollowing == null) {
      const nostrEventContactListKind = 3;

      newEvent = NostrEvent.fromPartialData(
        kind: nostrEventContactListKind,
        content: "",
        keyPairs: NostrKeyPairs(private: currentUserPrivateKey),
        tags: <List<String>>[
          ["p", pubKey],
        ],
      );
    } else {
      final currentUserFollowing = state.currentUserFollowing;
      if (currentUserFollowing == null) {
        return;
      }

      newEvent = currentUserFollowing.copyWith(
        tags: <List<String>>{
          ...currentUserFollowing.tags,
          ["p", pubKey],
        }.toList(),
      );
    }

    NostrService.instance.send.setFollowingsEvent(newEvent);
  }

  /// {@template unfollow_user}
  /// Removes and unfollow a followed user with the given [pubKey].
  /// {@endtemplate}
  void unfollowUser(String pubKey) {
    final currentUserFollowing = state.currentUserFollowing;
    if (currentUserFollowing == null) {
      return;
    }

    var tags = currentUserFollowing.tags;
    tags = tags.where((element) => element[1] != pubKey).toList();

    SentNostrEvent newEvent = currentUserFollowing.copyWith(
      tags: tags,
    );

    NostrService.instance.send.setFollowingsEvent(newEvent);
  }

  /// {@template handle_follow_button_tap}
  /// A Wrapper to handling follow functionality, if a user is not followed, this will call the [followUser] method, otherwise it will [unfollowUser].
  /// {@endtemplate}
  void handleFollowButtonTap(String pubkey) {
    if (isNoteOwnerFollowed(pubkey)) {
      unfollowUser(pubkey);
    } else {
      followUser(pubkey);
    }
  }

  ///  Emits the new followers event
  void _handleCurrentUserFollowers() {
    _currentUserFollowersSubscription = currentUserFollowers.stream.listen(
      (event) {
        emit(state.copyWith(currentUserFollowers: [
          event,
          ...state.currentUserFollowers,
        ]));
      },
    );
  }

  ///  Emits the new following event
  void _handleCurrentUserFollowing() {
    _currentUserFollowingSubscription = currentUserFollowing.stream.listen(
      (event) {
        emit(state.copyWith(currentUserFollowing: event));
      },
    );
  }
}
