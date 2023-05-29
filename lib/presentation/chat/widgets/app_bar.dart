import 'package:ditto/buisness_logic/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    required this.height,
    required this.title,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(title),
      actions: <Widget>[
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(FlutterRemix.more_2_line),
          onPressed: () {
            cubit.showChatOptionsSheet(context);
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
