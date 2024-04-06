import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/core/key_pairs.dart';
import 'package:dart_nostr/nostr/model/event/event.dart';
import 'package:ditto/model/messages/chat_conversation.dart';
import 'package:ditto/model/messages/chat_message.dart';

import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nip04.dart';
import 'package:ditto/services/nostr/nip_17_tmp.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:equatable/equatable.dart';

part 'dms_state.dart';

class DmsCubit extends Cubit<DmsState> {
  DmsCubit() : super(DmsInitial()) {
    _init();
    _listenPersiodicallyToUsers();
  }

  final subIds = <String>[];
  String? mainSubId;
  final dmUsers = <String>{};

  final keyPair = NostrKeyPairs(
    private: LocalDatabase.instance.getPrivateKey()!,
  );

  @override
  Future<void> close() {
    for (var id in [mainSubId, ...subIds]) {
      if (id != null) NostrService.instance.subs.close(id);
    }

    return super.close();
  }

  List<ChatConversation> groupByVisisbility(
    List<ChatConversation> messages,
    String currentUserPublicKey,
  ) {
    final map = <String, List<ChatConversation>>{};

    for (var i = 0; i < messages.length; i++) {
      final convo = messages[i];
      final sentByMe = convo.originalNostrEvent!.pubkey == currentUserPublicKey;

      if (sentByMe) {
        final p = convo.originalNostrEvent!.tags!
            .nostrTags('p')
            .firstWhereOrNull((e) => e[1] != currentUserPublicKey);

        final recipientPubKey = p?[1];

        if (recipientPubKey != null) {
          map[recipientPubKey] ??= [];
          map[recipientPubKey]!.add(convo);

          continue;
        }
      }

      map[convo.originalNostrEvent!.pubkey] ??= [];
      map[convo.originalNostrEvent!.pubkey]!.add(convo);
    }

    final res = map.entries.map((e) {
      e.value.sort(
        (a, b) => b.originalNostrEvent!.createdAt!
            .compareTo(a.originalNostrEvent!.createdAt!),
      );

      return ChatConversation(
        originalNostrEvent: null,
        originalMessage: '',
        userToShow: e.key,
        messages: e.value
            .map(
              (e) => ChatMessage.fromEvent(
                e.originalNostrEvent!,
                e.originalMessage,
              ),
            )
            .toList(),
      );
    }).toList();

    res.sort((a, b) {
      if (a.messages.isEmpty || b.messages.isEmpty) {
        return 0;
      }

      return b.messages.first.originalNostrEvent!.createdAt!
          .compareTo(a.messages.first.originalNostrEvent!.createdAt!);
    });

    return res;
  }

  void _init() {
    final sub = NostrService.instance.subs.userDms();
    mainSubId = sub.subscriptionId;

    sub.stream.listen(
      (event) async {
        dmUsers.add(event.pubkey);

        event.tags!.nostrTags("p").map((e) => e[1]).forEach(
          (element) {
            dmUsers.add(element);
          },
        );

        eventToChatConv(event, keyPair).then((convo) {
          emit(
            state.copyWith(
              chatConvoMessages: {
                ...state.chatConvoMessages,
                event.id!: convo,
              },
            ),
          );
        });
      },
    );
  }

  Future<ChatConversation> eventToChatConv(
      NostrEvent ev, NostrKeyPairs keyPair) async {
    if (ev.kind == 1059) {
      final event = await NIP17.nip44decrypt(
        ev,
        keyPair.private,
      );

      return ChatConversation.fromEvent(event, event.content!);
    }

    final p =
        ev.tags!.nostrTags('p').firstWhereOrNull((e) => e[1] != keyPair.public);

    final peerPublicKey = ev.pubkey == keyPair.public ? p![1] : ev.pubkey;

    final nip04decrypted = Nip4.decryptContent(
      ev.content!,
      peerPublicKey,
      keyPair,
    );

    final event = ChatConversation.fromEvent(ev, nip04decrypted);

    return event;
  }

  void _listenPersiodicallyToUsers() {
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final onlyNewUsers = dmUsers.where((e) => state.userMetadatas[e] == null);
    if (onlyNewUsers.isEmpty) {
    } else {
      final sub = NostrService.instance.subs.userMetadatas(
        onlyNewUsers.toList(),
      );

      subIds.add(sub.subscriptionId);

      sub.stream.listen(
        (event) {
          final user = UserMetaData.fromEvent(event);

          emit(
            state.copyWith(
              userMetadatas: {
                ...state.userMetadatas,
                user.userMetadataEvent!.pubkey: user,
              },
            ),
          );
        },
      );
    }
    await Future.delayed(Duration(seconds: 1));

    for (var id in subIds) {
      NostrService.instance.subs.close(id);
    }

    _fetchUsers();
  }
}
