import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../constants/colors.dart';
import '../../onboarding/widgets/animated_logo.dart';
import 'page_view_tracker.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final stepsLength = cubit.state.signUpScreens!.length;

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
            SizedBox(width: 10),
          ],
          leading: IconButton(
            onPressed: () {
              if (state.currentStepIndex == 1) {
                Navigator.of(context).pop();
              } else {
                cubit.previousStep();
              }
            },
            icon: const Icon(
              FlutterRemix.arrow_left_line,
              color: AppColors.black,
            ),
          ),
          title: Animate(
            effects: const <Effect>[
              FadeEffect(),
              SlideEffect(
                begin: Offset(-0.25, 0.0),
              ),
            ],
            target: isFirstView ? 0.0 : 1.0,
            child: const MunawarahLogo(
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
