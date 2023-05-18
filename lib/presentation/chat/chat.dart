import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/chat_cubit.dart';
import '../../model/chat_modules.dart';
import '../../services/utils/snackbars.dart';
import 'widgets/app_bar.dart';
import 'widgets/chat_message_widget.dart';
import 'widgets/chat_section.dart';
import 'widgets/empty_chat_widget.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final chatModduleItem = args['chatModduleItem'] as ChatModuleItem;

    return BlocProvider<ChatCubit>(
      create: (context) => ChatCubit(instruction: chatModduleItem.instruction),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              height: kToolbarHeight,
              title: chatModduleItem.title,
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state.errorMessage != null &&
                      state.errorMessage!.isNotEmpty) {
                    SnackBars.text(context, state.errorMessage!);
                  }
                },
                builder: (context, state) {
                  if (state.messages.isEmpty) {
                    return Center(
                      child: EmptyChatWidget(
                        recommendedQuestions:
                            chatModduleItem.recommendedQuestions,
                      ),
                    );
                  }

                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      MarginedBody(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            children: <Widget>[
                              Column(
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
                                        child:
                                            ChatMessageWidget(message: message),
                                      );
                                    },
                                  ).toList(),
                                  // SizedBox(height: 90),
                                ],
                              ),
                              SizedBox(height: 90),
                            ],
                          ),
                        ),
                      ),
                      MessageSection(),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
