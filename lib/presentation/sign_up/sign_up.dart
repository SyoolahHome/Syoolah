import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/presentation/sign_up/widgets/logo.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../services/utils/paths.dart';
import '../../services/utils/snackbars.dart';
import '../general/auth_app_handler.dart';
import '../general/widget/button.dart';
import '../general/widget/margined_body.dart';
import '../general/widget/title.dart';
import 'widgets/app_bar.dart';
import 'widgets/go_button.dart';
import 'widgets/name_field.dart';
import 'widgets/or_divider.dart';
import 'widgets/page_view_tracker.dart';
import 'widgets/private_key_label.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final cubit = context.read<AuthCubit>();

    final signUpScreens = cubit.state.signUpScreens;

    if (signUpScreens == null) {
      return const SizedBox();
    }

    final stepsLength = signUpScreens.length;

    widget(index) {
      final current = signUpScreens[index];
      final labelLarge = Theme.of(context).textTheme.labelLarge;
      if (labelLarge == null) {
        throw Exception("labelLarge is null");
      }
      final animationDuration = 200.ms;

      return MarginedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Animate(
              child: HeadTitle(
                title: current.title,
                isForSection: true,
              ),
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(-0.25, 0),
                ),
              ],
            ),
            const SizedBox(height: height * 2),
            Animate(
              child: Text(
                current.subtitle,
                style: labelLarge.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(-0.25, 0),
                ),
              ],
              delay: animationDuration,
            ),
            const Spacer(),
            Animate(
              child: current.widgetBody,
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(-0.25, 0),
                ),
              ],
              delay: animationDuration,
            ),
            const Spacer(),
          ],
        ),
      );
    }

    return AuthenticationStreamHandler(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(screenWidth, screenHeight)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CustomAppBar(),
                const SizedBox(height: height * 10),
                Flexible(
                  child: PageView(
                    controller: cubit.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List<Widget>.generate(stepsLength, widget),
                    allowImplicitScrolling: false,
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLastView = state.currentStepIndex == stepsLength;

                    final current = signUpScreens[state.currentStepIndex - 1];

                    void onMainButtonPressed() {
                      final onButtonTap = current.onButtonTap;
                      if (!current.nextViewAllower()) {
                        final val = SnackBars.text(
                          context,
                          AppStrings.finishThisStepFirst,
                        );
                      } else {
                        if (onButtonTap != null) {
                          onButtonTap();
                        }
                        if (isLastView) {
                          final val = Navigator.of(context)
                              .pushNamed(Paths.nostrServiceLoading);
                        } else {
                          cubit.gotoNext();
                        }
                      }
                    }

                    String textDecider() {
                      final textIfAuthenticated =
                          Routing.authCubit.state.authenticated
                              ? AppStrings.start
                              : "loading..";

                      return isLastView
                          ? textIfAuthenticated
                          : AppStrings.continueText;
                    }

                    final animationDuration = 600.ms;
                    final height = 45.0;

                    return Animate(
                      child: MarginedBody(
                        child: SizedBox(
                          width: double.infinity,
                          height: height,
                          child: MunawarahButton(
                            onTap: onMainButtonPressed,
                            text: textDecider(),
                          ),
                        ),
                      ),
                      effects: const <Effect>[
                        FadeEffect(),
                        SlideEffect(begin: Offset(0, 0.25)),
                      ],
                      delay: animationDuration,
                    );
                  },
                ),
                const SizedBox(height: height),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
