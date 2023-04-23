import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';
import '../../../services/utils/paths.dart';
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
              onTap:  () {
                Navigator.of(context).pushNamed(Paths.authChoose);
              },
              text: AppStrings.getStarted,
            ),
          ),
          Animate(
            effects: const <Effect>[FadeEffect()],
            delay: const Duration(milliseconds: 1800),
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                FlutterRemix.arrow_right_s_line,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
