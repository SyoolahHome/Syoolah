import 'package:dart_nostr/dart_nostr.dart';

import '../../../constants/app_configs.dart';
import '../../../model/note.dart';
import '../../database/local/local_database.dart';

class NostrServiceSub {
  NostrEventsStream userMetadata(String pubKey) {
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream currentUserMetaDataStream() {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream currentUserTextNotesStream() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

//   NostrEventsStream textNotesFeed() {
//     final randomId = Nostr.instance.utilsService.random64HexChars();
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

    final randomId = Nostr.instance.utilsService.random64HexChars();

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
    final randomId = Nostr.instance.utilsService.random64HexChars();

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
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream currentUserLikes() {
    final randomId = Nostr.instance.utilsService.random64HexChars();
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

  NostrEventsStream currentUserFollowings() {
    final randomId = Nostr.instance.utilsService.random64HexChars();
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
    final randomId = Nostr.instance.utilsService.random64HexChars();
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
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream quranFeedStream() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: [MunawarahTopics.quran.name],
          kinds: const [1],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream duaFeedStream() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: [MunawarahTopics.dua.name],
          kinds: const [1],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream hadithFeedStream() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: [MunawarahTopics.hadith.name],
          kinds: const [1],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream shariaFeedStream() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: [MunawarahTopics.sharia.name],
          kinds: const [1],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream fiqhFeedStream() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: [MunawarahTopics.fiqh.name],
          kinds: const [1],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream sirahFeedStream() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: [MunawarahTopics.dua.name],
          kinds: const [1],
          limit: 10,
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream globalFeed() {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final eventTags = [
      "global",
      ...AppConfigs.categories
          .map((category) => category.enumValue.name)
          .toList()
    ];

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          t: eventTags,
          kinds: const [1],
          limit: 10,
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
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [".", ...followings],
          kinds: const [1],
          limit: 10,
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
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream userTextNotesStream(String userProfilePubKey) {
    final randomId = Nostr.instance.utilsService.random64HexChars();

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [userProfilePubKey],
          kinds: const [1],
          t: ["global"],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }

  NostrEventsStream userMetaDataStream(String userProfilePubKey) {
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream userLikes(String userProfilePubKey) {
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream userFollowers(String userProfilePubKey) {
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream userFollowing(String userProfilePubKey) {
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream usersListMetadata(List<String> pubKeys) {
    final randomId = Nostr.instance.utilsService.random64HexChars();

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

  NostrEventsStream currentUserReposts() {
    final randomId = Nostr.instance.utilsService.random64HexChars();
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final requestWithFilter = NostrRequest(
      subscriptionId: randomId,
      filters: <NostrFilter>[
        NostrFilter(
          authors: [nostrKeyPairs.public],
          kinds: const [6],
        ),
      ],
    );

    return Nostr.instance.relaysService.startEventsSubscription(
      request: requestWithFilter,
    );
  }
}
