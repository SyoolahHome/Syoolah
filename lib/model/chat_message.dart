import 'package:dart_openai/openai.dart';
import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String message;
  final OpenAIChatMessageRole role;
  final String id;
  final DateTime createdAt;

  const ChatMessage({
    required this.message,
    required this.role,
    required this.id,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        message,
        role,
        id,
        createdAt,
      ];

  ChatMessage copyWith({
    String? message,
    OpenAIChatMessageRole? role,
    String? id,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      role: role ?? this.role,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  ChatMessage accumulateMessage(String message) {
    return copyWith(
      message: this.message + message,
    );
  }

  OpenAIChatCompletionChoiceMessageModel toOpenAIChatMessage() {
    return OpenAIChatCompletionChoiceMessageModel(
      role: role,
      content: message,
    );
  }
}
