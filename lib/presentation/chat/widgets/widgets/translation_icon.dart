import 'package:ditto/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/chat/chat_cubit.dart';

class TranslationIcon extends StatelessWidget {
  const TranslationIcon({
    super.key,
    required this.message,
  });

  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return GestureDetector(
      onTap: () {
        cubit.translateMessage(
          context,
          message: message,
        );
      },
      child: Icon(
        FlutterRemix.translate,
        size: 14.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
