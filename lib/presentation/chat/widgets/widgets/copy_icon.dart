import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/cubit/chat_cubit.dart';
import '../../../../model/chat_message.dart';

class CopyIcon extends StatelessWidget {
  const CopyIcon({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return GestureDetector(
      onTap: () => cubit.copyMessage(message),
      child: Icon(
        FlutterRemix.file_copy_line,
        size: 14.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
