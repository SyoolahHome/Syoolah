import 'dart:async';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local_database.dart';

class NostrForZaplocker {
  String signSchnorrHash(String hash, NostrKeyPairs keyPair) {
    String sig = "";

    while (sig.length != 128) {
      sig = keyPair.sign(hash);
    }

    return sig;
  }

  NostrEvent createEventSignedByNewKeysToBeSent({
    required String message,
    required String recipientPubKey,
  }) {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;

    final userKeyPair = Nostr.instance.keysService
        .generateKeyPairFromExistingPrivateKey(privateKey);

    return NostrEvent.fromPartialData(
        kind: 4,
        content: message,
        keyPairs: userKeyPair,
        tags: [
          ["p", recipientPubKey]
        ]);
  }

  Future<bool> eventWasReplayedTilSeen({
    required NostrEvent event,
    required int triesToLookForEvent,
    required List<String> relays,
  }) async {
    await Nostr.instance.relaysService.init(
      relaysUrl: relays,
    );

    Nostr.instance.relaysService.sendEventToRelays(event);
    if (event.id == null) {
      return false;
    }

    final note = await getNostrNote(
      id: event.id!,
      relays: relays,
    );

    if (note != "time is up") {
      return true;
    } else {
      if (triesToLookForEvent > 0) {
        await Future.delayed(Duration(milliseconds: 100));
        return await eventWasReplayedTilSeen(
          event: event,
          triesToLookForEvent: triesToLookForEvent - 1,
          relays: relays,
        );
      } else {
        return false;
      }
    }
  }

  Future<String> getNostrNote({
    required String id,
    required List<String> relays,
  }) async {
    final request = NostrRequest(
      filters: [
        NostrFilter(
          ids: [id],
        ),
      ],
    );

    final nostrSub = Nostr.instance.relaysService.startEventsSubscription(
      request: request,
    );

    final completer = Completer<NostrEvent?>();

    bool eventFound = false;

    // close the subscription after 3 seconds.
    Future.delayed(Duration(seconds: 3), () {
      nostrSub.close();
      if (!eventFound) completer.complete(null);
    });

    nostrSub.stream.listen((event) {
      assert(event.id == id);

      if (event.id == id) {
        eventFound = true;

        completer.complete(event);
      }
    });

    final fetchedEvent = await completer.future;

    if (fetchedEvent == null) {
      return "time is up";
    } else {
      if (fetchedEvent.content == null) {
        return "";
      }

      return fetchedEvent.content!;
    }
  }

  Future<String> isNoteSetYet({
    required String note_i_seek,
    required int startedWaitingTime,
  }) async {
    if (note_i_seek == null) {
      final current_Time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (startedWaitingTime + 5 < current_Time) {
        return "time is up";
      } else {
        await Future.delayed(Duration(milliseconds: 100));
        return await isNoteSetYet(
          note_i_seek: note_i_seek,
          startedWaitingTime: startedWaitingTime,
        );
      }
    } else {
      return note_i_seek.toString();
    }
  }
}
