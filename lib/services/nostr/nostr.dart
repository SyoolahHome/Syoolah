import 'dart:async';
import 'dart:convert';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/strings.dart';

import '../../model/note.dart';
import '../../model/user_meta_data.dart';
import '../database/local/local.dart';

class NostrService {
  static final NostrService _instance = NostrService._();
  static NostrService get instance => _instance;
  NostrService._();

  Future<void> init() async {
    await Nostr.instance.relaysService.init(
      relaysUrl: [
        'wss://eden.nostr.land',
        'wss://nostr.fmt.wiz.biz',
        'wss://relay.damus.io',
        'wss://nostr-pub.wellorder.net',
        'wss://relay.nostr.info',
        'wss://offchain.pub',
        'wss://nos.lol',
        // 'wss://brb.io', // throws error
        'wss://relay.snort.social',
        'wss://relay.current.fyi',
        'wss://nostr.relayer.se',
      ],
    );
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

    Nostr.instance.relaysService.sendEventToRelays(event);
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

    return Nostr.instance.relaysService
        .startEventsSubscription(request: requestWithFilter);
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

    return Nostr.instance.relaysService
        .startEventsSubscription(request: requestWithFilter);
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

    Nostr.instance.relaysService.sendEventToRelays(event);
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

    return Nostr.instance.relaysService
        .startEventsSubscription(request: requestWithFilter);
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

    return Nostr.instance.relaysService
        .startEventsSubscription(request: requestWithFilter);
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

    return Nostr.instance.relaysService.startEventsSubscription(
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

    Nostr.instance.relaysService.sendEventToRelays(event);
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

    return Nostr.instance.relaysService.startEventsSubscription(
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

    Nostr.instance.relaysService.sendEventToRelays(event);
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

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> currentUserLikes() {
    final randomId = NostrClientUtils.random64HexChars();
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );
    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [nostrKeyPairs.public],
          kinds: const [7],
          until: DateTime.now().add(Duration(days: 10)),
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> noteComments({
    required String postEventId,
    required Note note,
  }) {
    final randomId = NostrClientUtils.random64HexChars();
    print("post: " + note.noteOnly + ", random: " + randomId);

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          e: [postEventId],
          kinds: const [1],
        ),
      ],
    );

    final stream = Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );

    stream.listen((event) {
      print("comment: " + event.content + ", random: " + randomId);
    });

    return stream;
  }

  void addCommentToPost({
    required String postEventId,
    required String text,
  }) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 1,
      keyPairs: nostrKeyPairs,
      content: text,
      tags: [
        // ["p", nostrKeyPairs.public],
        ["e", postEventId],
      ],
    );

    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  Stream<NostrEvent> quranFeedStream() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: const [AppStrings.quran],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> duaFeedStream() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: const [AppStrings.dua],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> hadithFeedStream() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: const [AppStrings.hadith],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> shariaFeedStream() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: const [AppStrings.sharia],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> fiqhFeedStream() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: const [AppStrings.fiqh],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> sirahFeedStream() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: const [AppStrings.sirah],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> globalFeed() {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: const <String>[
            AppStrings.quran,
            AppStrings.dua,
            AppStrings.hadith,
            AppStrings.sharia,
            AppStrings.fiqh,
            AppStrings.sirah,
          ],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> followingsFeed({
    required List<String> followings,
  }) {
    final randomId = NostrClientUtils.random64HexChars();
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: followings,
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> noteStreamById({
    required String noteId,
  }) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          e: [noteId],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }
}
