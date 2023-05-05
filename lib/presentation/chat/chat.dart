import 'package:dart_openai/openai.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/chat_cubit.dart';
import 'widgets/app_bar.dart';
import 'widgets/chat_message_widget.dart';
import 'widgets/chat_section.dart';
import 'widgets/empty_chat_widget.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (context) => ChatCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ChatCubit>();

          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Scaffold(
                appBar: CustomAppBar(),
                body: MarginedBody(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state.messages.isEmpty) {
                        return Center(
                          child: EmptyChatWidget(),
                        );
                      }

                      return SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            ...state.messages.map(
                              (message) {
                                return Animate(
                                  key: ValueKey(message.id),
                                  effects: <Effect>[
                                    FadeEffect(),
                                    SlideEffect(begin: Offset(0, 0.25)),
                                  ],
                                  child: ChatMessageWidget(message: message),
                                );
                              },
                            ).toList(),
                            SizedBox(height: 90),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(child: MessageSection()),
            ],
          );
        },
      ),
    );
  }
}
