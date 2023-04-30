import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:equatable/equatable.dart';

import '../../services/database/local/local.dart';

part 'users_list_to_follow_state.dart';

class UsersListToFollowCubit extends Cubit<UsersListToFollowState> {
  Stream<NostrEvent> currentUserFollowing;
  Stream<NostrEvent> currentUserFollowers;
  StreamSubscription<NostrEvent>? _currentUserFollowingSubscription;
  StreamSubscription<NostrEvent>? _currentUserFollowersSubscription;
  StreamSubscription<NostrEvent>? _usersListMetadataSubscription;

  UsersListToFollowCubit({
    required List<String> pubKeys,
    required this.currentUserFollowers,
    required this.currentUserFollowing,
  }) : super(UsersListToFollowInitial()) {
    _handleCurrentUserFollowers();
    _handleCurrentUserFollowing();
    _handleContacts(pubKeys);
  }

  @override
  Future<void> close() {
    _currentUserFollowersSubscription?.cancel();
    _currentUserFollowingSubscription?.cancel();
    _usersListMetadataSubscription?.cancel();

    return super.close();
  }

  bool isNoteOwnerFollowed(String pubkey) {
    return state.currentUserFollowing?.tags
            .map((elem) => elem[1])
            .contains(pubkey) ??
        false;
  }

  void followUser(String pubKey) {
    NostrEvent newEvent;

    final contactListNostrEventKind = 3;
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

    NostrService.instance.setFollowingsEvent(newEvent);
  }

  void unfollowUser(String pubKey) {
    final currentUserFollowing = state.currentUserFollowing;
    if (currentUserFollowing == null) {
      return;
    }

    NostrEvent newEvent = currentUserFollowing.copyWith(tags: [
      ...currentUserFollowing.tags.where((element) => element[1] != pubKey),
    ]);

    NostrService.instance.setFollowingsEvent(newEvent);
  }

  void handleFollowButtonTap(String pubkey) {
    if (isNoteOwnerFollowed(pubkey)) {
      unfollowUser(pubkey);
    } else {
      followUser(pubkey);
    }
  }

  void _handleCurrentUserFollowers() {
    _currentUserFollowersSubscription = currentUserFollowers.listen((event) {
      emit(state.copyWith(currentUserFollowers: event));
    });
  }

  void _handleCurrentUserFollowing() {
    _currentUserFollowingSubscription = currentUserFollowing.listen((event) {
      emit(state.copyWith(currentUserFollowing: event));
    });
  }

  void _handleContacts(List<String> pubKeys) {
    _usersListMetadataSubscription =
        NostrService.instance.usersListMetadata(pubKeys).listen(
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
}
