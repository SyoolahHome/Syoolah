import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/presentation/sign_up/widgets/page_view_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/utils/app_utils.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final stepsLength = cubit.signUpScreens.length;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isFirstView = state.currentStepIndex == 1;

        return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 5.0,
          actions: <Widget>[
            PageViewTracker(
              currentStepIndex: state.currentStepIndex,
              stepsLength: stepsLength,
            ),
            const SizedBox(width: 10),
          ],
          leading: IconButton(
            onPressed: () {
              if (state.currentStepIndex == 1) {
                Navigator.of(context).pop();
              } else {
                cubit.goBackToPreviousSignUpStep();
              }
            },
            icon: Icon(
              AppUtils.instance.directionality_arrow_left_line(context),
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          title: Animate(
            effects: const <Effect>[
              FadeEffect(),
              SlideEffect(
                begin: Offset(-0.25, 0.0),
              ),
            ],
            target:
                // isFirstView ? 0.0 :
                1.0,
            child: const RoundaboutLogo(
              width: 50,
              isHero: false,
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
