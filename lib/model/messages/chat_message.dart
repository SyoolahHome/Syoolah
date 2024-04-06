import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/events_loader_cubit/events_loader_cubit.dart';
import 'package:equatable/equatable.dart';

class ChatMessage extends RelatedToNostrEvent {
  const ChatMessage({
    required super.originalNostrEvent,
    required this.originalMessage,
  });

  factory ChatMessage.fromEvent(
    NostrEvent event,
    String originalMessage,
  ) {
    return ChatMessage(
      originalNostrEvent: event,
      originalMessage: originalMessage,
    );
  }

  final String originalMessage;

  @override
  List<Object?> get props => [
        originalNostrEvent,
        originalMessage,
      ];
}
