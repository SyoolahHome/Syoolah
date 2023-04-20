import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class MunawarahShortDescription extends StatelessWidget {
  const MunawarahShortDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: const Duration(milliseconds: 600),
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      child: Text(
        AppStrings.appDescrition,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              // color: AppColors.white.withOpacity(0.75),
              fontWeight: FontWeight.w300,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
