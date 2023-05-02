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
    final stepsLength = cubit.state.signUpScreens!.length;

    return AuthenticationStreamHandler(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: screenHeight,
              minHeight: screenHeight,
              maxWidth: screenWidth,
              minWidth: screenWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CustomAppBar(),
                const SizedBox(height: height * 10),
                Flexible(
                  child: PageView(
                    controller: cubit.pageController,
                    allowImplicitScrolling: false,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List<Widget>.generate(
                      stepsLength,
                      (index) {
                        final current = cubit.state.signUpScreens![index];

                        return MarginedBody(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Animate(
                                effects: const <Effect>[
                                  FadeEffect(),
                                  SlideEffect(
                                    begin: Offset(-0.25, 0),
                                  ),
                                ],
                                child: HeadTitle(
                                  title: current.title,
                                  isForSection: true,
                                ),
                              ),
                              const SizedBox(height: height * 2),
                              Animate(
                                delay: 200.ms,
                                effects: const <Effect>[
                                  FadeEffect(),
                                  SlideEffect(
                                    begin: Offset(-0.25, 0),
                                  ),
                                ],
                                child: Text(
                                  current.subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(fontWeight: FontWeight.w300),
                                ),
                              ),
                              const Spacer(),
                              Animate(
                                delay: 400.ms,
                                effects: const <Effect>[
                                  FadeEffect(),
                                  SlideEffect(
                                    begin: Offset(-0.25, 0),
                                  ),
                                ],
                                child: current.widgetBody,
                              ),
                              const Spacer(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLastView = state.currentStepIndex == stepsLength;
                    final current =
                        cubit.state.signUpScreens![state.currentStepIndex - 1];

                    return Animate(
                      delay: 600.ms,
                      effects: const <Effect>[
                        FadeEffect(),
                        SlideEffect(
                          begin: Offset(0, 0.25),
                        ),
                      ],
                      child: MarginedBody(
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: MunawarahButton(
                            text: isLastView
                                ? Routing.authCubit.state.authenticated
                                    ? AppStrings.start
                                    : "loading.."
                                : AppStrings.continueText,
                            onTap: () {
                              if (!current.nextViewAllower()) {
                                SnackBars.text(
                                  context,
                                  AppStrings.finishThisStepFirst,
                                );
                              } else {
                                if (current.onButtonTap != null) {
                                  current.onButtonTap!();
                                }
                                if (isLastView) {
                                  Navigator.of(context)
                                      .pushNamed(Paths.nostrServiceLoading);
                                } else {
                                  cubit.gotoNext();
                                }
                              }
                            },
                          ),
                        ),
                      ),
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
