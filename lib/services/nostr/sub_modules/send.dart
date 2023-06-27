import 'dart:convert';

import 'package:dart_nostr/dart_nostr.dart';

import '../../../constants/app_configs.dart';
import '../../../model/note.dart';
import '../../../model/user_meta_data.dart';
import '../../database/local/local_database.dart';

class NostrServiceSend {
  NostrServiceSend();

  void setCurrentUserMetaData({
    required UserMetaData metadata,
  }) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 0,
      keyPairs: nostrKeyPairs,
      content: jsonEncode(metadata.toJson()),
    );

    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  void sendTextNoteFromCurrentUser({
    required String text,
    DateTime? creationDate,
    List<List<String>>? tags,
  }) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final eventTags = [
      ["t", "global"]
    ];

    if (tags != null) {
      eventTags.addAll(tags);
    }

    final event = NostrEvent.fromPartialData(
      kind: 1,
      keyPairs: nostrKeyPairs,
      content: text,
      tags: eventTags,
      createdAt: creationDate,
    );

    Nostr.instance.relaysService.sendEventToRelays(event);
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

  void sendRepostEventFromCurrentUser(Note note) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 6,
      keyPairs: nostrKeyPairs,
      content: jsonEncode(note.toJson()),
      tags: [
        ["e", note.event.id],
        ["p", note.event.pubkey],
      ],
    );

    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  void sendReportEvent({
    required Note note,
    required String selectedReportType,
  }) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final event = NostrEvent.fromPartialData(
      kind: 1984,
      keyPairs: nostrKeyPairs,
      content: jsonEncode(note.toJson()),
      tags: [
        ["e", note.event.id, selectedReportType],
        ["p", note.event.pubkey, selectedReportType],
        ...AppConfigs.categories.map(
          (e) => ["t", e.enumValue.name],
        )
      ],
    );

    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  void muteUserWithPubKeyPublicly({
    NostrEvent? currentMuteEvent,
    required String pubKey,
  }) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    final initialMuteTagsList = currentMuteEvent?.tags ?? [];

    final event = NostrEvent.fromPartialData(
        kind: 10000,
        keyPairs: nostrKeyPairs,
        content: currentMuteEvent?.content ?? "",
        tags: <List<String>>[
          ...initialMuteTagsList,
          ["p", pubKey],
        ]);

    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  void muteUserWithPubKeyPrivately({
    NostrEvent? currentMuteEvent,
    required String pubKey,
  }) {
    throw UnimplementedError();
  }
}
