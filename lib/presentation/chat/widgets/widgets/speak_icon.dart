import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/chat/chat_cubit.dart';
import '../../../../model/chat_message.dart';

class SpeakIcon extends StatelessWidget {
  const SpeakIcon({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return GestureDetector(
      onTap: () {
        cubit.speakMessage(
          context,
          message: message,
        );
      },
      child: Icon(
        Icons.multitrack_audio_rounded,
        size: 14.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
