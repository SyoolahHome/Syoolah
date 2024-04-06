import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nip44.dart';

class NIP17 {
  static Future<NostrEvent> nip44decrypt(
    NostrEvent ev,
    String privateKey,
  ) async {
    final publicKey = ev.pubkey;

    final wrap = {
      'content': ev.content,
      'createdAt': ev.createdAt,
      'id': ev.id,
      'kind': ev.kind,
      'pubkey': ev.pubkey,
      'sig': ev.sig,
      'tags': ev.tags,
    };

    final unwrappedSeal = await nip44Decrypt(
      wrap,
      privateKey,
    );

    final unsealedRumor = await nip44Decrypt(
      unwrappedSeal,
      privateKey,
    );

    final originalMessage = unsealedRumor['content'] as String;

    final rumorAsEvent = NostrEvent(
      content: originalMessage,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (unsealedRumor['created_at'] as int) * 1000,
      ),
      id: unsealedRumor['id'] as String,
      kind: unsealedRumor['kind'] as int,
      pubkey: unsealedRumor['pubkey'] as String,
      sig: '',
      tags: List<List<String>>.from(
        (unsealedRumor['tags'] as List)
            .map(
              (nestedElem) => (nestedElem as List)
                  .map(
                    (nestedElemContent) => nestedElemContent.toString(),
                  )
                  .toList(),
            )
            .toList(),
      ),
    );

    return rumorAsEvent;
  }
}
