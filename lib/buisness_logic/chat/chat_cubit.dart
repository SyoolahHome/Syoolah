import 'package:bloc/bloc.dart';
import 'package:dart_openai/openai.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/chat_message.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/open_ai/openai.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final String instruction;
  TextEditingController? userMessageController;
  FocusNode? focusNode;

  ChatCubit({
    required this.instruction,
  }) : super(ChatInitial()) {
    _init();
  }

  void sendMessageByCurrentUser() {
    final controller = userMessageController;
    assert(state.currentHint != null || controller?.text != null);

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

    Stream<String> messageReponseStream =
        OpenAIService.instance.messageResponseStream(
      chatMessages: currentMessagesList,
      instruction: instruction,
    );
    messageReponseStream
        .intervalDuration(AppConfigs.durationBetweenAIChatMessages)
        .listen((responseMessage) {
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
    focusNode = FocusNode();

    stream.where((event) => event.messages.isNotEmpty).listen(
          (event) {
            final lastMessage = event.messages.last;
            if (lastMessage.role == OpenAIChatMessageRole.user) {
              _sendMessageBySystem(lastMessage.message);
            }
          },
          onError: (e) {
            String errorMessage;
            if (kDebugMode) {
              errorMessage = e.toString();
            } else {
              errorMessage = "error".tr();
            }
            if (!isClosed) {
              emit(state.copyWith(errorMessage: errorMessage));
            }
          },
          cancelOnError: true,
          onDone: () {
            if (!isClosed) {
              emit(state.copyWith());
            }
          },
        );
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
          title: "copyChatMessage".tr(),
          onPressed: () => copyMessage(message),
        ),
        if (isCurrentUserMessage)
          BottomSheetOption(
            icon: FlutterRemix.refresh_line,
            title: "resendChatMessage".tr(),
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
          title: "copyChatMessages".tr(),
          onPressed: () => copyMessages(),
        ),
        BottomSheetOption(
          icon: FlutterRemix.delete_bin_2_line,
          title: "clearChatMessages".tr(),
          onPressed: () {
            AlertsService.confirmDialog(
              context: context,
              title: "areYouSureclearChatMessages".tr(),
              confirmText: "yes".tr(),
              cancelTextt: "no".tr(),
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

  void postMessageAsNoteOfCurrentUser(
    BuildContext context,
    ChatMessage message,
  ) {
    BottomSheetService.showCreatePostBottomSheet(
      context,
      initialNoteContent: message.message,
    );
  }
}
