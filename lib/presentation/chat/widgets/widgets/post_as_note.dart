import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../../../buisness_logic/chat/chat_cubit.dart';
import '../../../../model/chat_message.dart';

class PostDirectlyAsNote extends StatelessWidget {
  const PostDirectlyAsNote({
    super.key,
    required this.message,
  });

  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return GestureDetector(
      onTap: () => cubit.postMessageAsNoteOfCurrentUser(context, message),
      child: Icon(
        Icons.share,
        size: 14.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
