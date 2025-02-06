import 'package:ditto/presentation/general/widget/button.dart';
import 'package:flutter/material.dart';

import 'package:ditto/buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class NoLndSupport extends StatelessWidget {
  const NoLndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedLogo(),
            SizedBox(height: 20),
            Animate(
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(begin: Offset(0, 0.45)),
              ],
              delay: Animate.defaultDuration * 3,
              child: Text(
                "noLndSupport".tr().replaceAll("\n", "\n\n"),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Animate(
                effects: const <Effect>[
                  FadeEffect(),
                  SlideEffect(begin: Offset(0, 0.45)),
                ],
                delay: Animate.defaultDuration * 6,
                child: RoundaboutButton(
                  isRounded: true,
                  isSmall: false,
                  text: "goHome".tr(),
                  onTap: () {
                    final cubit = context.read<BottomBarCubit>();

                    cubit.onItemTapped(3);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Animate(
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(begin: Offset(0, 0.45)),
              ],
              delay: Animate.defaultDuration * 9,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "poweredBy".tr(),
                    ),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: "AbuCash",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: kToolbarHeight),
          ],
        ),
      ),
    );
  }
}
