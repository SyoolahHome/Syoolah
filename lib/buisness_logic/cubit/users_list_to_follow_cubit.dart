import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';

import '../../services/database/local/local.dart';

part 'users_list_to_follow_state.dart';

class UsersListToFollowCubit extends Cubit<UsersListToFollowState> {
  Stream<NostrEvent> currentUserFollowing;
  Stream<NostrEvent> currentUserFollowers;

  bool isNoteOwnerFollowed(String pubkey) {
    return state.currentUserFollowing?.tags
            .map((elem) => elem[1])
            .contains(pubkey) ??
        false;
  }

  UsersListToFollowCubit({
    required List<String> pubKeys,
    required this.currentUserFollowers,
    required this.currentUserFollowing,
  }) : super(UsersListToFollowInitial()) {
    _handleCurrentUserFollowers();
    _handleCurrentUserFollowing();

    _handleContacts(pubKeys);
  }

  void _handleCurrentUserFollowers() {
    currentUserFollowers.listen((event) {
      emit(state.copyWith(currentUserFollowers: event));
    });
  }

  void _handleCurrentUserFollowing() {
    currentUserFollowing.listen((event) {
      emit(state.copyWith(currentUserFollowing: event));
    });
  }

  void followUser(String pubKey) {
    NostrEvent newEvent;

    if (state.currentUserFollowing == null) {
      newEvent = NostrEvent.fromPartialData(
        kind: 3,
        keyPairs:
            NostrKeyPairs(private: LocalDatabase.instance.getPrivateKey()!),
        tags: [
          ["p", pubKey],
        ],
        content: "",
      );
    } else {
      newEvent = state.currentUserFollowing!.copyWith(tags: [
        ...state.currentUserFollowing!.tags,
        ["p", pubKey],
      ]);
    }

    NostrService.instance.setFollowingsEvent(newEvent);
  }

  void unfollowUser(String pubKey) {
    assert(state.currentUserFollowing != null);

    NostrEvent newEvent = state.currentUserFollowing!.copyWith(tags: [
      ...state.currentUserFollowing!.tags
          .where((element) => element[1] != pubKey),
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

  void _handleContacts(List<String> pubKeys) {
    NostrService.instance.usersListMetadata(pubKeys).listen(
      (event) {
        final newList = [
          ...state.pubKeysMetadata,
          event,
        ];
        // .removeDuplicatedEvents();
        emit(
          state.copyWith(pubKeysMetadata: newList),
        );
      },
    );
  }
}

extension E on List<NostrEvent> {
  //remove duplicated events that have same field on NostrEvent.
  List<NostrEvent> removeDuplicatedEvents() {
    final List<NostrEvent> result = [];

    for (final event in this) {
      if (result.isEmpty) {
        result.add(event);
      } else {
        final isDuplicated = result.any(
          (element) {
            return element.pubkey == event.pubkey;
          },
        );
        if (!isDuplicated) {
          result.add(event);
        }
      }
    }
    return result;
  }
}
