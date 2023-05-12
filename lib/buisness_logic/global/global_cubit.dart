import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:equatable/equatable.dart';

import '../../services/nostr/nostr_service.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  NostrEventsStream currentUserFollowing;
  NostrEventsStream currentUserFollowers;

  StreamSubscription<NostrEvent>? _currentUserFollowingSubscription;
  StreamSubscription<NostrEvent>? _currentUserFollowersSubscription;

  GlobalCubit({
    required this.currentUserFollowing,
    required this.currentUserFollowers,
  }) : super(GlobalInitial()) {
    _handleCurrentUserFollowers();
    _handleCurrentUserFollowing();
  }

  bool isNoteOwnerFollowed(String pubkey) {
    return state.currentUserFollowing?.tags
            .map((elem) => elem[1])
            .contains(pubkey) ??
        false;
  }

  void followUser(String pubKey) {
    NostrEvent newEvent;

    final currentUserPrivateKey = LocalDatabase.instance.getPrivateKey();

    if (currentUserPrivateKey == null) {
      return;
    }

    if (state.currentUserFollowing == null) {
      final nostrEventContactListKind = 3;

      newEvent = NostrEvent.fromPartialData(
        kind: nostrEventContactListKind,
        content: "",
        keyPairs: NostrKeyPairs(private: currentUserPrivateKey),
        tags: [
          ["p", pubKey],
        ],
      );
    } else {
      final currentUserFollowing = state.currentUserFollowing;
      if (currentUserFollowing == null) {
        return;
      }

      newEvent = currentUserFollowing.copyWith(tags: [
        ...currentUserFollowing.tags,
        ["p", pubKey],
      ]);
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

  @override
  Future<void> close() {
    currentUserFollowing.close();
    currentUserFollowers.close();

    _currentUserFollowersSubscription?.cancel();
    _currentUserFollowingSubscription?.cancel();

    return super.close();
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
}
