import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/cubit/chat_cubit.dart';
import '../../general/text_field.dart';

class MessageSection extends StatelessWidget {
  const MessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    final hint = AppUtils.randomChatMessagePlaceholder();
    return Container(
      margin: const EdgeInsets.only(
            bottom: 10,
          ) +
          MarginedBody.defaultMargin / 2,
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          CustomTextField(
            focusNode: cubit.focusNode,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 17.5,
            ),
            controller: cubit.userMessageController,
            hint: hint,
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                FlutterRemix.send_plane_2_line,
                size: 18,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                cubit.setCurrentHint(hint);
                cubit.sendMessageByCurrentUser();
              },
            ),
          ),
        ],
      ),
    );
  }
}
