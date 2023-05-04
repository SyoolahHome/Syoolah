import 'package:bloc/bloc.dart';
import 'package:dart_openai/openai.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/chat_message.dart';
import '../../services/open_ai/openai.dart';
import '../../services/utils/app_utils.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  TextEditingController? userMessageController;
  ChatCubit() : super(ChatInitial()) {
    _init();
  }

  void sendMessageByCurrentUser() {
    final controller = userMessageController;
    if (controller == null) {
      return;
    }

    final currentMessagesList = state.messages;
    final newMessageId = AppUtils.getChatUserId();

    final newMessage = ChatMessage(
      message: controller.text,
      role: OpenAIChatMessageRole.user,
      id: newMessageId,
      createdAt: DateTime.now(),
    );

    final newMessagesList = [...currentMessagesList, newMessage];

    emit(state.copyWith(messages: newMessagesList));
  }

  void sendMessageBySystem(String message) {
    final currentMessagesList = state.messages;
    final newMessageId = AppUtils.getChatSystemId();

    emit(
      state.copyWith(
        messages: [
          ...currentMessagesList,
          ChatMessage(
            message: "",
            role: OpenAIChatMessageRole.system,
            id: newMessageId,
            createdAt: DateTime.now(),
          )
        ],
      ),
    );

    final messageReponseStream =
        OpenAIService.instance.messageResponseStream(currentMessagesList);

    messageReponseStream.listen((responseMessage) {
      emitMessageContentForSystemMessageWithId(newMessageId, responseMessage);
    });
  }

  void emitMessageContentForSystemMessageWithId(
    String systemChatMessageId,
    String newValue,
  ) {
    final currentMessagesList = List.of(state.messages);

    for (int index = 0; index < currentMessagesList.length; index++) {
      final current = currentMessagesList[index];

      if (current.id == systemChatMessageId) {
        final newMessage = current.accumulateMessage(newValue);
        currentMessagesList[index] = newMessage;
        break;
      }
    }

    return emit(state.copyWith(messages: currentMessagesList));
  }

  void _init() {
    userMessageController = TextEditingController();

    stream.where((event) => event.messages.isNotEmpty).listen((event) {
      final lastMessage = event.messages.last;
      if (lastMessage.role == OpenAIChatMessageRole.user) {
        sendMessageBySystem(lastMessage.message);
      }
    });
  }
}
