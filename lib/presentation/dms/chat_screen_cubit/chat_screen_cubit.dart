import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/messages/chat_conversation.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/nostr/nip04.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  ChatScreenCubit({
    required this.chatConversation,
    required this.currentUserKeys,
    required this.relays,
    this.targetUser,
  }) : super(ChatScreenInitial()) {}

  final List<String> relays;

  final NostrKeyPairs currentUserKeys;

  final ChatConversation? chatConversation;

  final UserMetaData? targetUser;

  String? subscriptionId;

  Future<void> close() {
    if (subscriptionId != null)
      NostrService.instance.subs.close(subscriptionId!);
    return super.close();
  }

  Future<void> sendMessage(
    String message, {
    required void Function(NostrEvent) onMessageSent,
  }) async {
    if (message.isEmpty) {
      return;
    }

    final ev = chatMeessageEv(
      message: message,
      peerPublicKey: targetUser!.userMetadataEvent!.pubkey,
      keyPairs: currentUserKeys,
    );

    final isOk = await _sendMessageEvent(ev);

    if (isOk) {
      onMessageSent(ev);
    }
  }

  Future<bool> _sendMessageEvent(NostrEvent event) async {
    final isOk =
        await NostrService.instance.send!.sendDirectEvent(event: event);

    return isOk;
  }

  NostrEvent chatMeessageEv({
    required String message,
    required String peerPublicKey,
    required NostrKeyPairs keyPairs,
  }) {
    final encryptedMessage = Nip4.encryptContent(
      message,
      peerPublicKey,
      keyPairs,
    );

    final decryptedToCheck = Nip4.decryptContent(
      encryptedMessage,
      peerPublicKey,
      keyPairs,
    );

    if (decryptedToCheck != message) {
      throw Exception('Decrypted message does not match original message');
    }

    final ev = NostrEvent.fromPartialData(
      keyPairs: keyPairs,
      kind: 4,
      content: encryptedMessage,
      tags: [
        ['p', peerPublicKey],
      ],
    );

    return ev;
  }
}
