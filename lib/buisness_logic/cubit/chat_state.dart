// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;

  const ChatState({
    this.messages = const [],
  });

  @override
  List<Object> get props => [
        messages,
      ];

  ChatState copyWith({
    List<ChatMessage>? messages,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
    );
  }
}

class ChatInitial extends ChatState {}
