import 'dart:async';
import 'dart:convert';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../model/note.dart';
import '../../model/user_meta_data.dart';
import '../database/local/local_database.dart';
import '../utils/routing.dart';

class NostrService {
  static final NostrService _instance = NostrService._();
  static NostrService get instance => _instance;
  NostrService._();

  Completer relaysConnectionCompleter = Completer();
  Future<void> init({
    List<String>? relaysUrls,
  }) async {
    final defaultRelaysUrls =
        Routing.appCubit.state.relaysConfigurations.map((e) => e.url).toList();

    await Nostr.instance.relaysService.init(
      relaysUrl: relaysUrls ?? defaultRelaysUrls,
      retryOnClose: true,
      shouldReconnectToRelayOnNotice: true,
      connectionTimeout: Duration(seconds: 4),
    );

    relaysConnectionCompleter.complete();
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
          t: ["anas", "gwhyyy"],
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
          until: DateTime.now().add(const Duration(days: 10)),
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> currentUserFollowings() {
    final randomId = NostrClientUtils.random64HexChars();
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );
    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [nostrKeyPairs.public],
          kinds: const [3],
          until: DateTime.now().add(const Duration(days: 10)),
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> currentUserFollowers() {
    final randomId = NostrClientUtils.random64HexChars();
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );
    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          p: [nostrKeyPairs.public],
          kinds: const [3],
          until: DateTime.now().add(const Duration(days: 10)),
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
      print("comment: ${event.content}, random: $randomId");
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
          t: ["quran".tr()],
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
          t: ["dua".tr()],
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
          t: ["hadith".tr()],
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
          t: ["sharia".tr()],
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
          t: ["fiqh".tr()],
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
          t: ["sirah".tr()],
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
          t: <String>[
            "quran".tr(),
            "dua".tr(),
            "hadith".tr(),
            "sharia".tr(),
            "fiqh".tr(),
            "sirah".tr(),
          ],
          kinds: const [1],
          limit: 1,
        )
      ],
    );

    final stream = Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );

    stream.listen((event) {
      print("global: ${event.content}, random: $randomId");
    });
    return stream;
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
          ids: [noteId],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  void setFollowingsEvent(NostrEvent newEvent) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: newEvent.kind,
      keyPairs: nostrKeyPairs,
      content: newEvent.content,
      tags: newEvent.tags,
    );

    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  void reSendNote(NostrEvent event) {
    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  Future<String> getPubKeyFromEmail(String identifier) async {
    return await Nostr.instance.relaysService.pubKeyFromIdentifierNip05(
      internetIdentifier: identifier,
    );
  }

  Stream<NostrEvent> userTextNotesStream(String userProfilePubKey) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userProfilePubKey],
          kinds: const [1],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> userMetaDataStream(String userProfilePubKey) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userProfilePubKey],
          kinds: const [0],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> userLikes(String userProfilePubKey) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userProfilePubKey],
          kinds: const [7],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> userFollowers(String userProfilePubKey) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          p: [userProfilePubKey],
          kinds: const [3],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> userFollowing(String userProfilePubKey) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userProfilePubKey],
          kinds: const [3],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  Stream<NostrEvent> usersListMetadata(List<String> pubKeys) {
    final randomId = NostrClientUtils.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: pubKeys,
          kinds: const [0],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }
}
