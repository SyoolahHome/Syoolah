import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../services/utils/paths.dart';
import '../../general/widget/button.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: 600.ms,
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: MunawarahButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          text: AppStrings.close,
        ),
      ),
    );
  }
}
