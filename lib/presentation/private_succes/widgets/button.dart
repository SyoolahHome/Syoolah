import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: 800.ms,
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: RoundaboutButton(
          onTap: onTap ??
              () {
                Navigator.of(context).pop();
              },
          text: "close".tr(),
        ),
      ),
    );
  }
}
