import 'dart:convert';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/utils/extensions.dart';

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
      ["t", "globalRoundaboutApp_1"]
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
    final keyPairs =
        Nostr.instance.keysService.generateKeyPairFromExistingPrivateKey(
      LocalDatabase.instance.getPrivateKey()!,
    );
    if (newEvent.kind == null) {
      return;
    }
    if (newEvent.content == null) {
      return;
    }

    final ev = NostrEvent.fromPartialData(
      kind: newEvent.kind!,
      content: newEvent.content!,
      keyPairs: keyPairs,
      tags: newEvent.tags,
    );

    Nostr.instance.relaysService.sendEventToRelays(ev);
  }

  void reSendNote(NostrEvent event) {
    Nostr.instance.relaysService.sendEventToRelays(event);
  }

  Future<String> getPubKeyFromEmail(String identifier) async {
    return await Nostr.instance.utilsService.pubKeyFromIdentifierNip05(
      internetIdentifier: identifier,
    );
  }

  void sendRepostEventFromCurrentUser(Note note) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );
    if (note.event.id == null) {
      return;
    }

    final event = NostrEvent.fromPartialData(
      kind: 6,
      keyPairs: nostrKeyPairs,
      content: jsonEncode(note.toJson()),
      tags: [
        ["e", note.event.id!],
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

    if (note.event.id == null) {
      return;
    }

    final event = NostrEvent.fromPartialData(
      kind: 1984,
      keyPairs: nostrKeyPairs,
      content: jsonEncode(note.toJson()),
      tags: [
        ["e", note.event.id!, selectedReportType],
        ["p", note.event.pubkey, selectedReportType],
        ...AppConfigs.categories.map(
          (e) => ["t", e.enumValue.roundaboutName],
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

  Future<bool> sendDirectEvent({
    required NostrEvent event,
  }) async {
    final okCommand = await Nostr.instance.relaysService.sendEventToRelaysAsync(
      event,
      timeout: const Duration(seconds: 4),
    );

    return okCommand.isEventAccepted ?? false;
  }
}
