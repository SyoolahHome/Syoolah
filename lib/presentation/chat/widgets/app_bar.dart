import 'package:ditto/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/cubit/chat_cubit.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(AppStrings.imamOnDuty),
      actions: <Widget>[
        SizedBox(width: 10),
        IconButton(
          icon: Icon(FlutterRemix.more_2_line),
          onPressed: () {
            cubit.showChatOptionsSheet(context);
          },
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
