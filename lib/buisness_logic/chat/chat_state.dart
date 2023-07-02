part of 'chat_cubit.dart';

/// {@template chat_state}
///  The state of [ChatCubit].
/// {@endtemplate}
class ChatState extends Equatable {
  /// A List that holds the message for the Chat functionality
  final List<ChatMessage> messages;

  /// The current hint that is shown in the Imam text field
  final String? currentHint;

  /// An error text if it exists.
  final String? errorMessage;

  /// {@macro chat_state}
  const ChatState({
    this.messages = const [],
    this.currentHint,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        messages,
        currentHint,
        errorMessage,
      ];

  /// {@macro chat_state}
  ChatState copyWith({
    List<ChatMessage>? messages,
    String? currentHint,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      currentHint: currentHint ?? this.currentHint,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory ChatState.initial() {
    return ChatInitial();
  }
}

/// {@macro chat_state}
class ChatInitial extends ChatState {}
