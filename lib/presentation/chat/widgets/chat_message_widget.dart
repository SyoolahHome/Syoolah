import 'package:dart_openai/dart_openai.dart';
import 'package:ditto/model/chat_message.dart';
import 'package:ditto/presentation/chat/widgets/widgets/copy_icon.dart';
import 'package:ditto/presentation/chat/widgets/widgets/reload_icon.dart';
import 'package:ditto/presentation/general/loading_widget.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_vreation_ago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/chat/chat_cubit.dart';
import 'widgets/post_as_note.dart';
import 'widgets/speak_icon.dart';
import 'widgets/stop_speak_icon.dart';
import 'widgets/translation_icon.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isCurrentUserMessage = message.role == OpenAIChatMessageRole.user;
    final cubit = context.read<ChatCubit>();

    if (message.message.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onLongPress: () {
        cubit.showChatMessageOptionsSheet(context, message: message);
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 15.0,
          // left: isCurrentUserMessage ? 30 : 0,
          // right: isCurrentUserMessage ? 0 : 30,
        ),
        child: Row(
          children: <Widget>[
            if (isCurrentUserMessage)
              Animate(
                effects: const <Effect>[
                  FadeEffect(),
                  SlideEffect(begin: Offset(0.25, 0)),
                ],
                child: Animate(
                  effects: const <Effect>[
                    FadeEffect(),
                    SlideEffect(begin: Offset(0, 0.25)),
                  ],
                  child: ChatMessageWidgetDots(
                    message: message,
                  ),
                ),
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(isCurrentUserMessage ? .5 : .25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      message.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    const SizedBox(height: 12.5),
                    BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        return Animate(
                          effects: const <Effect>[
                            FadeEffect(),
                          ],
                          child: Row(
                            children: <Widget>[
                              if (isCurrentUserMessage) ...<Widget>[
                                ReloadIcon(message: message),
                              ] else ...<Widget>[
                                if (state.loadingMessageId.isNotEmpty &&
                                    message.id == state.loadingMessageId &&
                                    state.speakingTTS) ...[
                                  const LoadingWidget(
                                    size: 15,
                                  ),
                                  if (state.speakingTTS) ...[
                                    SizedBox(width: 10.0),
                                    StopSpeakingIcon(),
                                  ],
                                ] else ...[
                                  CopyIcon(message: message),
                                  SizedBox(width: 10.0),
                                  PostDirectlyAsNote(message: message),
                                  if (!message.isTranslated) ...[
                                    SizedBox(width: 10.0),
                                    TranslationIcon(message: message),
                                  ],
                                  SizedBox(width: 10.0),
                                  SpeakIcon(message: message),
                                ]
                              ],
                              Spacer(),
                              Align(
                                alignment: isCurrentUserMessage
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: NoteDateOfCreationAgo(
                                  createdAt: message.createdAt,
                                  isMedium: true,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (!isCurrentUserMessage)
              ChatMessageWidgetDots(
                message: message,
              ),
          ],
        ),
      ),
    );
  }
}

class ChatMessageWidgetDots extends StatelessWidget {
  const ChatMessageWidgetDots({
    super.key,
    required this.message,
  });

  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return GestureDetector(
      onTap: () {
        cubit.showChatMessageOptionsSheet(context, message: message);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.5),
        child: const Icon(
          FlutterRemix.more_line,
          size: 20,
        ),
      ),
    );
  }
}
