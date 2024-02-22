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

  /// The id of the message that is currently loading.
  final String loadingMessageId;

  /// Weither the response is done from generating or not.
  final bool isDoneFromGeneratingResponse;

  final bool speakingTTS;

  /// {@macro chat_state}
  const ChatState({
    this.messages = const [],
    this.currentHint,
    this.errorMessage,
    this.loadingMessageId = "",
    this.isDoneFromGeneratingResponse = false,
    this.speakingTTS = false,
  });

  @override
  List<Object?> get props => [
        messages,
        currentHint,
        errorMessage,
        isDoneFromGeneratingResponse,
        loadingMessageId,
        speakingTTS,
      ];

  /// {@macro chat_state}
  ChatState copyWith({
    List<ChatMessage>? messages,
    String? currentHint,
    String? errorMessage,
    bool? isDoneFromGeneratingResponse,
    String? loadingMessageId,
    bool? speakingTTS,
  }) {
    return ChatState(
      loadingMessageId: loadingMessageId ?? this.loadingMessageId,
      messages: messages ?? this.messages,
      currentHint: currentHint ?? this.currentHint,
      errorMessage: errorMessage,
      isDoneFromGeneratingResponse:
          isDoneFromGeneratingResponse ?? this.isDoneFromGeneratingResponse,
      speakingTTS: speakingTTS ?? this.speakingTTS,
    );
  }

  factory ChatState.initial() {
    return ChatInitial();
  }
}

/// {@macro chat_state}
class ChatInitial extends ChatState {}
