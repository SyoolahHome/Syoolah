import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
        alignment: Alignment.centerRight,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 45,
            child: MunawarahButton(
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
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                FlutterRemix.arrow_right_s_line,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
