import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:equatable/equatable.dart';

import '../../services/nostr/nostr.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  Stream<NostrEvent> currentUserFollowing;
  Stream<NostrEvent> currentUserFollowers;

  bool isNoteOwnerFollowed(String pubkey) {
    return state.currentUserFollowing?.tags
            .map((elem) => elem[1])
            .contains(pubkey) ??
        false;
  }

  GlobalCubit({
    required this.currentUserFollowing,
    required this.currentUserFollowers,
  }) : super(GlobalInitial()) {
    _handleCurrentUserFollowers();
    _handleCurrentUserFollowing();
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
}
