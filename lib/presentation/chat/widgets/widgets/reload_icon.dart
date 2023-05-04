import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/cubit/chat_cubit.dart';
import '../../../../model/chat_message.dart';

class ReloadIcon extends StatelessWidget {
  const ReloadIcon({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return GestureDetector(
      onTap: () => cubit.resendUserMessage(message),
      child: Icon(
        FlutterRemix.refresh_line,
        size: 13.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
