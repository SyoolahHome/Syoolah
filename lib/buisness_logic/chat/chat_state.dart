part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final String? currentHint;

  final String? errorMessage;
  const ChatState({
    this.messages = const [],
    this.currentHint,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [messages, currentHint, errorMessage];

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
}

class ChatInitial extends ChatState {}
