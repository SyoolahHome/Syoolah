import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:equatable/equatable.dart';

part 'users_list_to_follow_state.dart';

/// {@template users_list_to_follow_cubit}
/// The responsible cubit about the users-to-follow (recommendations) list.
/// {@endtemplate}
class UsersListToFollowCubit extends Cubit<UsersListToFollowState> {
  /// The Nostr stream for the current user following.
  NostrEventsStream currentUserFollowing;

  /// The Nostr stream for the current user followers.
  NostrEventsStream currentUserFollowers;

  /// The Nostr stream for the users list metadata.
  NostrEventsStream usersListMetadata;

  /// The subscription for the [currentUserFollowing.stream].
  StreamSubscription<NostrEvent>? _currentUserFollowingSubscription;

  /// The subscription for the [currentUserFollowers.stream].
  StreamSubscription<NostrEvent>? _currentUserFollowersSubscription;

  /// The subscription for the [usersListMetadata.stream].
  StreamSubscription<NostrEvent>? _usersListMetadataSubscription;

  /// {@macro users_list_to_follow_cubit}
  UsersListToFollowCubit({
    required this.currentUserFollowers,
    required this.currentUserFollowing,
    required this.usersListMetadata,
  }) : super(UsersListToFollowInitial()) {
    _init();
  }

  @override
  Future<void> close() {
    currentUserFollowing.close();
    currentUserFollowers.close();
    usersListMetadata.close();

    _currentUserFollowersSubscription?.cancel();
    _currentUserFollowingSubscription?.cancel();
    _usersListMetadataSubscription?.cancel();

    return super.close();
  }

  /// Weither the note owner is followed by the current user.
  bool isNoteOwnerFollowed(String pubkey) {
    return state.currentUserFollowing?.tags
            .map((elem) => elem[1])
            .contains(pubkey) ??
        false;
  }

  /// {@macro follow_user}
  void followUser(String pubKey) {
    NostrEvent newEvent;

    const contactListNostrEventKind = 3;
    final curerntUserPrivateKey = LocalDatabase.instance.getPrivateKey();
    if (curerntUserPrivateKey == null) {
      return;
    }

    if (state.currentUserFollowing == null) {
      newEvent = NostrEvent.fromPartialData(
        kind: contactListNostrEventKind,
        content: "",
        keyPairs: NostrKeyPairs(private: curerntUserPrivateKey),
        tags: [
          ["p", pubKey],
        ],
      );
    } else {
      final currentUserFollowing = state.currentUserFollowing;
      if (currentUserFollowing == null) {
        return;
      }

      final newUserFollowTag = ["p", pubKey];

      newEvent = currentUserFollowing.copyWith(
        tags: [...currentUserFollowing.tags, newUserFollowTag],
      );
    }

    NostrService.instance.send.setFollowingsEvent(newEvent);
  }

  /// {@macro unfollow_user}
  void unfollowUser(String pubKey) {
    final currentUserFollowing = state.currentUserFollowing;
    if (currentUserFollowing == null) {
      return;
    }

    NostrEvent newEvent = currentUserFollowing.copyWith(
      tags: [
        ...currentUserFollowing.tags.where((element) => element[1] != pubKey),
      ],
    );

    NostrService.instance.send.setFollowingsEvent(newEvent);
  }

  /// {@macro handle_follow_button_tap}
  void handleFollowButtonTap(String pubkey) {
    if (isNoteOwnerFollowed(pubkey)) {
      unfollowUser(pubkey);
    } else {
      followUser(pubkey);
    }

    emit(state.copyWith(followedSuccessfully: true));
  }

  void _handleCurrentUserFollowers() {
    _currentUserFollowersSubscription =
        currentUserFollowers.stream.listen((event) {
      emit(state.copyWith(currentUserFollowers: event));
    });
  }

  void _handleCurrentUserFollowing() {
    _currentUserFollowingSubscription =
        currentUserFollowing.stream.listen((event) {
      emit(state.copyWith(currentUserFollowing: event));
    });
  }

  void _handleContacts() {
    _usersListMetadataSubscription = usersListMetadata.stream.listen(
      (event) {
        final newList = [
          ...state.pubKeysMetadata,
          event,
        ].removeDuplicatedEvents();
        emit(
          state.copyWith(pubKeysMetadata: newList),
        );
      },
    );
  }

  void _init() {
    _handleCurrentUserFollowers();
    _handleCurrentUserFollowing();
    _handleContacts();
  }
}
