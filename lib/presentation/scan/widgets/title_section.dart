import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../general/widget/title.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final labelLarge = Theme.of(context).textTheme.labelLarge!;
    const height = 10.0;

    return Column(
      children: <Widget>[
        Animate(
          effects: const <Effect>[
            FadeEffect(),
            SlideEffect(
              begin: Offset(-0.25, 0),
            ),
          ],
          child: HeadTitle(
            title: "existentKeyAuthTitle".tr(),
            isForSection: true,
          ),
        ),
        SizedBox(height: height * 2),
        Animate(
          delay: 200.ms,
          effects: const <Effect>[
            FadeEffect(),
            SlideEffect(
              begin: Offset(-0.25, 0),
            ),
          ],
          child: Text(
            "existentKeyAuthSubtitle".tr(),
            style: labelLarge.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
