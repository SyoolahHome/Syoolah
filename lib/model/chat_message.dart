import 'package:dart_openai/dart_openai.dart';
import 'package:equatable/equatable.dart';

/// {@template chat_message}
/// A model that holds data related to one Imam conversation message.
/// {@endtemplate}
class ChatMessage extends Equatable {
  /// The actual message text.
  final String message;

  /// The role of the owner of this system, this leverages the enum from [dart_openai] package.
  final OpenAIChatMessageRole role;

  /// The identifier of this message, this is necessary for the cubit state that create & manage messages.
  final String id;

  /// THe date of creation of this message
  final DateTime createdAt;

  /// A flag that indicates if the message is translated or not.
  final bool isTranslated;

  /// {@macro chat_message}
  const ChatMessage({
    required this.message,
    required this.role,
    required this.id,
    required this.createdAt,
    this.isTranslated = false,
  });

  @override
  List<Object?> get props => [
        message,
        role,
        id,
        createdAt,
        isTranslated,
      ];

  /// {@macro chat_message}
  ChatMessage copyWith({
    String? message,
    OpenAIChatMessageRole? role,
    String? id,
    DateTime? createdAt,
    bool? isTranslated,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      role: role ?? this.role,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      isTranslated: isTranslated ?? this.isTranslated,
    );
  }

  /// Return a new [ChatMessage] instance using the current one, but accumulating the given [message] with the current's, so we get like-stream functionality to be used.
  ChatMessage accumulateMessage(String message) {
    return copyWith(
      message: this.message + message,
    );
  }

  /// returns a [OpenAIChatCompletionChoiceMessageModel] object which is the wrapper model that is accepted by the [dart_openai] package, so it make it more easier to leverage commutation between dependencies.
  OpenAIChatCompletionChoiceMessageModel toOpenAIChatMessage() {
    return OpenAIChatCompletionChoiceMessageModel(
      role: role,
      content: message,
    );
  }

  /// {@macro chat_message}
  /// This is an message for the user [role].
  factory ChatMessage.user({
    required String message,
    required String id,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      message: message,
      role: OpenAIChatMessageRole.user,
      id: id,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  /// {@macro chat_message}
  /// This is an message for the system [role].
  factory ChatMessage.system({
    required String message,
    required String id,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      message: message,
      role: OpenAIChatMessageRole.system,
      id: id,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  /// {@macro chat_message}
  /// This is an message for the assistant [role].
  factory ChatMessage.assistant({
    required String message,
    required String id,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      message: message,
      role: OpenAIChatMessageRole.assistant,
      id: id,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
