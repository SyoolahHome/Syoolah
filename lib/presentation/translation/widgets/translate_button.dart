import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/translation/translation_cubit.dart';
import '../../general/widget/button.dart';

class TranslateButton extends StatelessWidget {
  const TranslateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TranslationCubit>();

    return SizedBox(
      width: max(200, MediaQuery.of(context).size.width * .5),
      child: BlocSelector<TranslationCubit, TranslationState, String>(
        selector: (state) => state.inputText,
        builder: (context, inputText) {
          final allowBtnToBePressed = inputText.isNotEmpty;

          return Animate(
            // make fade animation based on the state of the button.
            target: allowBtnToBePressed ? 1 : 0.5,
            effects: [
              FadeEffect(),
            ],
            child: KeshiButton(
              icon: FlutterRemix.translate,
              onTap: allowBtnToBePressed ? cubit.applyTranslation : null,
              text: "translate".tr(),
              isRounded: true,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
            ),
          );
        },
      ),
    );
  }
}
