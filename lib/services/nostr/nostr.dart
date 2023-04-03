import 'dart:convert';

import 'package:nostr_client/nostr/core/key_pairs.dart';
import 'package:nostr_client/nostr/core/utils.dart';
import 'package:nostr_client/nostr/model/event.dart';
import 'package:nostr_client/nostr/nostr.dart';
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

  Stream<NostrEvent> allRelaysTextNoteStreamOfCurrentUser() {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final metaDataSubscription = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: metaDataSubscription,
      filters: [
        NostrFilter(
          authors: [nostrKeyPairs.public],
          kinds: const [1],
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
}
