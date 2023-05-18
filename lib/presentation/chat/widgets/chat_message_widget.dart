import 'package:dart_openai/openai.dart';
import 'package:ditto/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/cubit/chat_cubit.dart';
import '../../general/widget/note_card/wudgets/note_vreation_ago.dart';
import 'widgets/copy_icon.dart';
import 'widgets/reload_icon.dart';

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
      return SizedBox.shrink();
    }

    return GestureDetector(
      onLongPress: () {
        cubit.showChatMessageOptionsSheet(context, message: message);
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 15.0,
          // left: isCurrentUserMessage ? 30 : 0,
          // right: isCurrentUserMessage ? 0 : 30,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isCurrentUserMessage)
              Animate(
                effects: <Effect>[
                  FadeEffect(),
                  SlideEffect(begin: Offset(0.25, 0)),
                ],
                child: Animate(
                  effects: <Effect>[
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
                padding: EdgeInsets.all(12.5),
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
                    SizedBox(height: 12.5),
                    Animate(
                      effects: <Effect>[
                        FadeEffect(),
                      ],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (isCurrentUserMessage) ...[
                            ReloadIcon(message: message),
                          ] else ...[
                            CopyIcon(message: message),
                          ],
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
        margin: EdgeInsets.symmetric(horizontal: 12.5),
        child: Icon(
          FlutterRemix.more_line,
          size: 20,
        ),
      ),
    );
  }
}
