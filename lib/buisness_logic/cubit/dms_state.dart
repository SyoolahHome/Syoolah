part of 'dms_cubit.dart';

class DmsState extends Equatable {
  const DmsState({
    this.chatConvoMessages = const {},
    this.userMetadatas = const {},
  });

  final Map<String, ChatConversation> chatConvoMessages;
  final Map<String, UserMetaData> userMetadatas;

  DmsState copyWith({
    Map<String, ChatConversation>? chatConvoMessages,
    Map<String, UserMetaData>? userMetadatas,
  }) {
    return DmsState(
      chatConvoMessages: chatConvoMessages ?? this.chatConvoMessages,
      userMetadatas: userMetadatas ?? this.userMetadatas,
    );
  }

  @override
  List<Object?> get props => [
        chatConvoMessages,
        userMetadatas,
      ];
}

final class DmsInitial extends DmsState {}
