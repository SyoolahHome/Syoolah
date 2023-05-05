import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/app_colors.dart';

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
        "appDescrition".tr(),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.black.withOpacity(0.9),
              fontWeight: FontWeight.w400,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
