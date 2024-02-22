import 'package:ditto/presentation/general/loading_widget.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import '../../../buisness_logic/translation/translation_cubit.dart';
import '../../../services/utils/paths.dart';
import '../../general/text_field.dart';
import 'copy_button_overlay.dart';

class OutputArea extends StatelessWidget {
  const OutputArea({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TranslationCubit>();

    return BlocConsumer<TranslationCubit, TranslationState>(
      key: ValueKey("outputArea"),
      listener: (context, state) {
        if (state.error != null) {
          SnackBars.text(context, state.error!);
        }
      },
      builder: (context, state) {
        final isLoading = state.isLoading;
        final output = state.translatedText;
        final speakingOutput = state.speakingOutput;

        return Stack(
          alignment: Alignment.center,
          children: [
            CopyButtonOverlay(
              disableCopyAndSound: output.isEmpty || isLoading,
              audioOn: speakingOutput,
              show: output.isNotEmpty,
              onGoChat: state.translatedText.isEmpty || isLoading
                  ? null
                  : () {
                      Navigator.of(context).pushNamed(Paths.chat, arguments: {
                        'initialMessage': output,
                      });
                    },
              onTap: state.translatedText.isEmpty || isLoading
                  ? null
                  : () {
                      cubit.copyOutput();
                    },
              onShareAsNoteTap: state.translatedText.isEmpty || isLoading
                  ? null
                  : () {
                      cubit.shareAsNote(context);
                    },
              onSoundTap: state.translatedText.isEmpty || isLoading
                  ? null
                  : () {
                      cubit.speakOutput(() => context);
                    },
              child: CustomTextField(
                readOnly: true,
                bgColor: Theme.of(context)
                    .inputDecorationTheme
                    .fillColor
                    ?.withOpacity(.1),
                controller: cubit.outputController,
                isMultiline: true,
                minLines: 5,
                hint: isLoading ? "" : "Translation",
              ),
            ),
            Animate(
              target: isLoading ? 1 : 0,
              effects: [
                FadeEffect(
                  duration: Duration(milliseconds: 300),
                ),
              ],
              child: const LoadingWidget(),
            ),
          ],
        );
      },
    );
  }
}
