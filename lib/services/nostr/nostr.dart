import 'dart:async';
import 'dart:convert';
import 'package:nostr_client/nostr_client.dart';

import '../../model/user_meta_data.dart';
import '../database/local/local.dart';

class NostrService {
  static final NostrService _instance = NostrService._();
  static NostrService get instance => _instance;
  NostrService._();

  Future<void> init() async {
    await Nostr.instance.init(relaysUrl: [
      'wss://relay.damus.io',
    ]);
  }

  void setCurrentUserMetaData({
    required UserMetaData metadata,
    DateTime? creationDate,
  }) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 0,
      keyPairs: nostrKeyPairs,
      content: jsonEncode({
        "name": metadata.name,
        "creationDate": (creationDate ?? DateTime.now()).toIso8601String(),
        "picture": metadata.picture,
        "banner": metadata.banner,
        "about": metadata.about,
        "username": metadata.username,
      }),
    );

    Nostr.instance.sendEventToRelays(event);
  }

  Stream<NostrEvent> userMetadata(String pubKey) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: [
        NostrFilter(
          authors: [pubKey],
          kinds: const [0],
          since: DateTime.now().subtract(const Duration(days: 100)),
        )
      ],
    );

    return Nostr.instance.subscribeToEvents(request: requestWithFilter);
  }

  Stream<NostrEvent> currentUserMetaDataStream() {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: [
        NostrFilter(
          authors: [nostrKeyPairs.public],
          kinds: const [0],
          since: DateTime.now().subtract(const Duration(days: 100)),
        )
      ],
    );

    return Nostr.instance.subscribeToEvents(request: requestWithFilter);
  }

  void sendTextNoteFromCurrentUser({
    required String text,
    DateTime? creationDate,
    List<List<String>>? tags,
  }) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 1,
      keyPairs: nostrKeyPairs,
      content: text,
      tags: tags,
      createdAt: creationDate,
    );

    Nostr.instance.sendEventToRelays(event);
  }

  Stream<NostrEvent> currentUserTextNotesStream() {
    final randomId = NostrClientUtils.random64HexChars();

    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [nostrKeyPairs.public],
          kinds: const [1],
          since: DateTime.now().subtract(const Duration(days: 100)),
        )
      ],
    );

    return Nostr.instance.subscribeToEvents(request: requestWithFilter);
  }

  Stream<NostrEvent> textNotesFeed() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          kinds: const [1],
          t: const ["anas", "gwhyyy"],
          since: DateTime.now().subtract(const Duration(days: 30)),
        )
      ],
    );

    return Nostr.instance.subscribeToEvents(request: requestWithFilter);
  }

  Stream getFollowedPeople() {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [nostrKeyPairs.public],
          kinds: const [3],
          since: DateTime.now().subtract(const Duration(days: 100)),
        )
      ],
    );

    return Nostr.instance.subscribeToEvents(
      request: requestWithFilter,
    );
  }

  void followUserWithPubKey(String pubKey) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 3,
      keyPairs: nostrKeyPairs,
      content: pubKey,
    );

    Nostr.instance.sendEventToRelays(event);
  }

  Stream<NostrEvent> allUsersMetadata() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          kinds: const [0],
          since: DateTime.now().subtract(const Duration(days: 100)),
        )
      ],
    );

    return Nostr.instance.subscribeToEvents(
      request: requestWithFilter,
    );
  }

  void likePost(String postEventId) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 7,
      keyPairs: nostrKeyPairs,
      content: "+",
      tags: [
        ["e", postEventId],
        ["p", nostrKeyPairs.public],
      ],
      createdAt: DateTime.now(),
    );

    Nostr.instance.sendEventToRelays(event);
  }

  Stream<NostrEvent> noteLikes({
    required String postEventId,
  }) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          e: [postEventId],
          kinds: const [7],
          until: DateTime.now().add(Duration(days: 10)),
        )
      ],
    );

    return Nostr.instance.subscribeToEvents(
      request: requestWithFilter,
    );
  }
}
