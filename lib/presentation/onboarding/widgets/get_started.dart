import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../services/utils/app_utils.dart';
import '../../general/widget/button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      delay: const Duration(milliseconds: 800),
      child: Stack(
        alignment: AppUtils.instance.centerHorizontalAlignment(context),
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 45,
            child: UmrahtyButton(
              onTap: () {
                Navigator.of(context).pushNamed(Paths.authChoose);
              },
              text: "getStarted".tr(),
            ),
          ),
          Animate(
            effects: const <Effect>[FadeEffect()],
            delay: const Duration(milliseconds: 1800),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Animate(
                effects: <Effect>[
                  SlideEffect(
                    begin: Offset(-0.1, 0),
                    end: Offset(0.1, 0),
                    duration: 2000.ms,
                  ),
                ],
                onComplete: (controller) => controller.repeat(reverse: true),
                child: Icon(
                  AppUtils.instance.directionality_arrow_right_s_line(context),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
