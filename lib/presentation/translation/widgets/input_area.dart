import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../buisness_logic/translation/translation_cubit.dart';
import '../../../services/utils/paths.dart';
import '../../general/text_field.dart';
import 'copy_button_overlay.dart';

class InputArea extends StatelessWidget {
  const InputArea({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TranslationCubit>();

    return BlocBuilder<TranslationCubit, TranslationState>(
      builder: (context, state) {
        return CopyButtonOverlay(
          key: ValueKey("inputArea"),
          audioOn: state.speakingInput,
          disableCopyAndSound: state.inputText.isEmpty,
          onGoChat: () {
            Navigator.of(context).pushNamed(Paths.chat, arguments: {
              'initialMessage': state.inputText,
            });
          },
          onTap: () {
            cubit.copyInput();
          },
          onClearTap: () {
            cubit.clearInput();
          },
          onSoundTap: () {
            cubit.speakInput(() => context);
          },
          child: CustomTextField(
            isMultiline: true,
            bgColor: Theme.of(context)
                .inputDecorationTheme
                .fillColor
                ?.withOpacity(.2),
            controller: cubit.inputController,
            minLines: 5,
          ),
        );
      },
    );
  }
}
