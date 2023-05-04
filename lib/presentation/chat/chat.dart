import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/chat_cubit.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (context) => ChatCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ChatCubit>();

          return BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return Scaffold(
                body: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: state.messages.map(
                        (message) {
                          return Text(
                            message.message,
                            textAlign:
                                message.role == OpenAIChatMessageRole.user
                                    ? TextAlign.right
                                    : TextAlign.left,
                          );
                        },
                      ).toList(),
                    ),
                    TextField(
                      controller: cubit.userMessageController,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.sendMessageByCurrentUser();
                      },
                      child: Text("send"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
