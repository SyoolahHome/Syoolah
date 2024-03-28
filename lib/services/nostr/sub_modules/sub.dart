import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/utils/extensions.dart';

import '../../../constants/app_configs.dart';
import '../../../constants/app_enums.dart';
import '../../../model/note.dart';
import '../../database/local/local_database.dart';

class NostrServiceSub {
  String get randomHexString => Nostr.instance.utilsService.random64HexChars();

  NostrEventsStream userMetadata(String pubKey) {
    final randomId = randomHexString;

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

  NostrEventsStream userMetaData({
    required String userPubKey,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: [
        NostrFilter(
          authors: [userPubKey],
          kinds: const [0],
          since: DateTime.now().subtract(const Duration(days: 100)),
        )
      ],
    );

    return Nostr.instance.relaysService
        .startEventsSubscription(request: requestWithFilter);
  }

  NostrEventsStream userTextNotesStream({
    required String userPubKey,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userPubKey],
          kinds: const [1],
          since: DateTime.now().subtract(const Duration(days: 100)),
        )
      ],
    );

    return Nostr.instance.relaysService
        .startEventsSubscription(request: requestWithFilter);
  }

//   NostrEventsStream textNotesFeed() {
//     final randomId = randomHexString;
//
//     final requestWithFilter = NostrRequest(
//       subscriptionId: randomId,
//       filters: <NostrFilter>[
//         NostrFilter(
//           kinds: const [1],
//           t: const ["anas", "gwhyyy"],
//           since: DateTime.now().subtract(const Duration(days: 30)),
//         )
//       ],
//     );
//
//     return Nostr.instance.relaysService
//         .startEventsSubscription(request: requestWithFilter);
//   }

  NostrEventsStream getFollowedPeople() {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final randomId = randomHexString;

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

  NostrEventsStream allUsersMetadata() {
    final randomId = randomHexString;

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

  NostrEventsStream noteLikes({
    required String postEventId,
  }) {
    final randomId = randomHexString;

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

  NostrEventsStream currentUserFollowings() {
    final randomId = randomHexString;

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

  NostrEventsStream currentUserFollowers() {
    final randomId = randomHexString;
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

  NostrEventsStream noteComments({
    required String postEventId,
    required Note note,
  }) {
    final randomId = randomHexString;

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

    stream.stream.listen((event) {
      print("comment: ${event.content}, random: $randomId");
    });

    return stream;
  }

  NostrEventsStream topic({
    required AppBrandTopics topic,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: [topic.appBrandName],
          kinds: const [1],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream globalFeed({
    List<String>? followings,
  }) {
    final randomId = randomHexString;

    final eventTags = [
      "globalAppBrandApp_1",
      ...AppConfigs.categories
          .map((category) => category.enumValue.appBrandName)
          .toList()
    ];

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: eventTags,
          kinds: const [1],
          authors: followings,
          limit: 20,
        )
      ],
    );

    final stream = Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );

    return stream;
  }

  NostrEventsStream followingsFeed({
    required List<String> followings,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: followings.isEmpty
              ? ["something else to not retrieve all kind 1 posts ever."]
              : [...followings],
          kinds: const [1],
          limit: 30,
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream noteStreamById({
    required String noteId,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          ids: [noteId],
          kinds: const [1],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream userMetaDataStream({
    required String userProfilePubKey,
  }) {
    final randomId = randomHexString;

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

  NostrEventsStream userLikes({
    required String userPubKey,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userPubKey],
          kinds: const [7],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream userFollowers({
    required String userPubKey,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          p: [userPubKey],
          kinds: const [3],
        )
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream userFollowings({
    required String userPubKey,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userPubKey],
          kinds: const [3],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream usersListMetadata(List<String> pubKeys) {
    final randomId = randomHexString;

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

  NostrEventsStream userReposts({
    required String userPubKey,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userPubKey],
          kinds: const [6],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream userComments({
    required String userPubKey,
  }) {
    final randomId = randomHexString;

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: [
        NostrFilter(
          authors: [userPubKey],
          kinds: const [1],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }
}
