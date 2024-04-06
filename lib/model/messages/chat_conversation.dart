import 'package:dart_nostr/dart_nostr.dart';

import 'package:ditto/model/messages/chat_message.dart';
import 'package:equatable/equatable.dart';

class ChatConversation extends Equatable {
  const ChatConversation({
    required this.originalNostrEvent,
    required this.messages,
    required this.originalMessage,
    this.userToShow,
  });

  final NostrEvent? originalNostrEvent;

  factory ChatConversation.fromEvent(
    NostrEvent event,
    String originalMessage,
  ) {
    return ChatConversation(
      originalNostrEvent: event,
      messages: const [],
      originalMessage: originalMessage,
    );
  }

  final List<ChatMessage> messages;
  final String? userToShow;
  final String originalMessage;

  @override
  List<Object?> get props => [
        this.originalNostrEvent,
        messages,
        originalMessage,
      ];
}
