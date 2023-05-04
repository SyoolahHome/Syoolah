// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final String? currentHint;

  const ChatState({
    this.messages = const [],
    this.currentHint,
  });

  @override
  List<Object?> get props => [
        messages,
        currentHint,
      ];

  ChatState copyWith({
    List<ChatMessage>? messages,
    String? currentHint,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      currentHint: currentHint ?? this.currentHint,
    );
  }
}

class ChatInitial extends ChatState {}
