import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

    return Animate(
      delay: 1400.ms,
      effects: <Effect>[FadeEffect()],
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10) +
              MarginedBody.defaultMargin / 2,
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              CustomTextField(
                focusNode: cubit.focusNode,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                bgColor: Color(Theme.of(context).colorScheme.onPrimary.value),
                controller: cubit.userMessageController,
                hint: "askQuestionHere".tr() ?? hint,
                fontWight: FontWeight.w300,
              ),
              Animate(
                delay: 1800.ms,
                effects: <Effect>[FadeEffect()],
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: IconButton(
                    icon: Icon(
                      FlutterRemix.chat_1_line,
                      size: 18,
                    ),
                    onPressed: () {
                      print(cubit.userMessageController!.text);
                      cubit.setCurrentHint(hint);
                      print(cubit.userMessageController!.text);
                      cubit.sendMessageByCurrentUser();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
