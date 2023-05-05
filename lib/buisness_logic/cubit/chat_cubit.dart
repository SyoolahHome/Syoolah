import 'package:bloc/bloc.dart';
import 'package:dart_openai/openai.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/app_strings.dart';
import '../../model/bottom_sheet_option.dart';
import '../../model/chat_message.dart';
import '../../services/open_ai/openai.dart';
import '../../services/utils/app_utils.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  TextEditingController? userMessageController;
  ScrollController? scrollController;
  FocusNode? focusNode;
  ChatCubit() : super(ChatInitial()) {
    _init();
  }

  void sendMessageByCurrentUser() {
    assert(state.currentHint != null);

    final controller = userMessageController;
    if (controller == null) {
      return;
    }

    if (focusNode!.hasFocus) {
      focusNode!.unfocus();
    }

    final userMessage =
        controller.text.isEmpty ? state.currentHint! : controller.text;

    final currentMessagesList = state.messages;
    final newMessageId = AppUtils.getChatUserId();

    final newMessage = ChatMessage(
      message: userMessage,
      role: OpenAIChatMessageRole.user,
      id: newMessageId,
      createdAt: DateTime.now(),
    );

    final newMessagesList = [...currentMessagesList, newMessage];

    emit(state.copyWith(messages: newMessagesList));

    controller.clear();
  }

  void _sendMessageBySystem(String message) {
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
          ),
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
    userMessageController = TextEditingController()
      ..addListener(() {
        print("Text: ${userMessageController!.text}");
      });
    scrollController = ScrollController();
    focusNode = FocusNode();

    stream.where((event) => event.messages.isNotEmpty).listen((event) {
      final lastMessage = event.messages.last;
      if (lastMessage.role == OpenAIChatMessageRole.user) {
        _sendMessageBySystem(lastMessage.message);
      }
    });
  }

  void setCurrentHint(String hint) {
    emit(state.copyWith(currentHint: hint));
  }

  void resendUserMessage(ChatMessage message) {
    final controller = userMessageController;
    if (controller == null) {
      return;
    }

    controller.text = message.message;
    sendMessageByCurrentUser();
  }

  Future<void> showChatMessageOptionsSheet(
    BuildContext context, {
    required ChatMessage message,
  }) {
    final isCurrentUserMessage = message.role == OpenAIChatMessageRole.user;

    return BottomSheetService.showChatMessageOptionsSheet(
      context,
      message: message,
      options: <BottomSheetOption>[
        BottomSheetOption(
          icon: FlutterRemix.file_copy_line,
          title: AppStrings.copyChatMessage,
          onPressed: () => copyMessage(message),
        ),
        if (isCurrentUserMessage)
          BottomSheetOption(
            icon: FlutterRemix.refresh_line,
            title: AppStrings.resendChatMessage,
            onPressed: () => resendUserMessage(message),
          ),
      ],
    );
  }

  Future<void> copyMessage(ChatMessage message) {
    return AppUtils.copy(
      message.message,
    );
  }

  Future<void> showChatOptionsSheet(BuildContext context) {
    return BottomSheetService.showChatOptionsSheet(
      context,
      options: <BottomSheetOption>[
        BottomSheetOption(
          icon: FlutterRemix.file_copy_line,
          title: AppStrings.copyChatMessages,
          onPressed: () => copyMessages(),
        ),
        BottomSheetOption(
          icon: FlutterRemix.delete_bin_2_line,
          title: AppStrings.clearChatMessages,
          onPressed: () {
            AlertsService.confirmDialog(
              context: context,
              title: AppStrings.areYouSureclearChatMessages,
              confirmText: AppStrings.yes,
              cancelTextt: AppStrings.no,
              onConfirm: () async => clearMessages(),
            );
          },
        ),
      ],
    );
  }

  void copyMessages() {
    final messages = state.messages;
    final messagesText = messages.map((e) => e.message).join("\n");
    AppUtils.copy(messagesText);
  }

  void clearMessages() {
    emit(state.copyWith(messages: <ChatMessage>[]));
  }
}

extension ScrollControllerExt on ScrollController {
  bool get isNotAtBottom {
    if (hasClients) {
      return false;
    }

    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;

    return maxScroll - currentScroll > 100;
  }

  Future<void> animateToBottom() async {
    if (isNotAtBottom && hasClients) {
      return animateTo(
        position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
