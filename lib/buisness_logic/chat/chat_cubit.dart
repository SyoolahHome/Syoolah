import 'package:bloc/bloc.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/chat_message.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/open_ai/openai.dart';
import 'package:ditto/services/translator/translator.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../services/tts/tts.dart';

part 'chat_state.dart';

/// {@template chat_cubit}
/// The responsible cubit for the chat chat Imam functionality & UI
/// {@endtemplate}
class ChatCubit extends Cubit<ChatState> {
  /// The AI instruction (OpenAI system instruction) that will be used to inform and instruct the Imam to respond based on it.
  final String instruction;

  /// The responsible controller for the user input where the user can ask.
  TextEditingController? userMessageController;

  /// The focus node associated with the text field that uses the [userMessageController].
  FocusNode? focusNode;

  /// The initial message that will be shown in the text field when the chat screen is opened.
  final String? initialMessage;

  /// {@macro chat_cubit}
  ChatCubit({
    required this.instruction,
    this.initialMessage,
  }) : super(ChatState.initial()) {
    _init();
  }

  /// Sends a new message with the user input that contains the question, in order to start the functionality and start the AI Imam to respond to it, the message will be added to the [state.messages].
  /// if the [userMessageController] is not initialized, it will be ignored.
  /// when this method is called, the text field will lose the focus using the [focusNode].
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
    final newMessageId = AppUtils.instance.getChatUserId();

    final newMessage = ChatMessage.user(
      message: userMessage,
      id: newMessageId,
      createdAt: DateTime.now(),
    );

    final newMessagesList = <ChatMessage>[
      ...currentMessagesList,
      newMessage,
    ];

    emit(state.copyWith(messages: newMessagesList));

    controller.clear();
  }

  /// Sends the message of the system which all will rely on it, basically the [instruction].
  void _sendMessageBySystem(
    String message, {
    bool isError = false,
  }) {
    emit(state.copyWith(isDoneFromGeneratingResponse: false));

    final currentMessagesList = state.messages;

    final newMessageId = AppUtils.instance.getChatSystemId();

    var systemMessage = ChatMessage.system(
      message: isError ? message : "",
      id: newMessageId,
      createdAt: DateTime.now(),
    );

    emit(
      state.copyWith(
        messages: <ChatMessage>[...currentMessagesList, systemMessage],
      ),
    );

    if (isError) {
      return;
    }

    Stream<String> messageReponseStream =
        OpenAIService.instance.messageResponseStream(
      chatMessages: currentMessagesList,
      instruction: instruction,
    );

    messageReponseStream
        .intervalDuration(AppConfigs.durationBetweenAIChatMessages)
        .listen(
      (responseMessage) {
        emitMessageContentForSystemMessageWithId(newMessageId, responseMessage);
      },
      onDone: () {
        print("done from message");
        emit(state.copyWith(isDoneFromGeneratingResponse: true));
      },
      onError: (err) {
        print("error throw message");
        _sendMessageBySystem("error".tr(), isError: true);
      },
      cancelOnError: true,
    );
  }

  ///
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

    if (initialMessage != null) {
      Future.delayed(Duration(milliseconds: 100), () {
        userMessageController!.text = initialMessage!;
        sendMessageByCurrentUser();
      });
    }

    focusNode = FocusNode();

    stream.where((event) => event.messages.isNotEmpty).distinct(
      (prev, curr) {
        return prev.messages.last.role == curr.messages.last.role;
      },
    ).listen(
      (event) {
        final lastMessage = event.messages.last;
        final role = lastMessage.role;

        if (role == OpenAIChatMessageRole.user) {
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
          // emit(state.copyWith());
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
    return AppUtils.instance.copy(message.message);
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
    AppUtils.instance.copy(messagesText);
  }

  void clearMessages() {
    emit(state.copyWith(messages: <ChatMessage>[]));
  }

  void postMessageAsNoteOfCurrentUser(
    BuildContext context,
    ChatMessage message,
  ) {
    final indexOfMessage =
        state.messages.indexWhere((chatMessage) => chatMessage == message);

    final currentMessage = state.messages[indexOfMessage];
    assert(message.role != OpenAIChatMessageRole.user);

    final indexOfPreviousMessage = indexOfMessage - 1;
    final previousMessage = state.messages[indexOfPreviousMessage];
    assert(previousMessage.role == OpenAIChatMessageRole.user);

    String messageToSend = previousMessage.message;
    messageToSend += "\n\n";
    messageToSend += currentMessage.message;

    BottomSheetService.showCreatePostBottomSheet(
      context,
      initialNoteContent: messageToSend,
    );
  }

  void translateMessage(
    BuildContext context, {
    required ChatMessage message,
  }) async {
    try {
      emit(state.copyWith(
        loadingMessageId: message.id,
      ));

      final selectedLanguage = await BottomSheetService.showLangSelection(
        context,
        initialLang: null,
      );

      if (selectedLanguage == null) {
        return;
      }

      final translatedMessage = await Translator.translate(
        text: message.message,
        targetLang: selectedLanguage.name,
      );

      final newMessages = <ChatMessage>[];

      for (int index = 0; index < state.messages.length; index++) {
        final current = state.messages[index];

        if (current.id == message.id) {
          final newMessage = current.copyWith(
            message: translatedMessage,
            isTranslated: true,
          );

          newMessages.add(newMessage);
        } else {
          newMessages.add(current);
        }
      }

      emit(state.copyWith(messages: newMessages));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        errorMessage: 'error'.tr(),
      ));
    } finally {
      emit(state.copyWith(
        loadingMessageId: "",
      ));
    }
  }

  Future<void> speakMessage(
    BuildContext context, {
    required ChatMessage message,
  }) async {
    try {
      emit(state.copyWith(
        loadingMessageId: message.id,
        speakingTTS: true,
      ));

      await TTS.speak(
        text: message.message,
        context: context,
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        errorMessage: 'error'.tr(),
      ));
    } finally {
      emit(state.copyWith(
        loadingMessageId: "",
        speakingTTS: false,
      ));
    }
  }

  Future<void> stopSpeaking() async {
    try {
      await TTS.stop();
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        errorMessage: 'error'.tr(),
      ));
    } finally {
      emit(state.copyWith(
        loadingMessageId: "",
        speakingTTS: false,
      ));
    }
  }
}
