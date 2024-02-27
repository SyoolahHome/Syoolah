import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/presentation/general/auth_app_handler.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/sign_up/widgets/app_bar.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/utils/app_utils.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final cubit = context.read<AuthCubit>();

    // final signUpScreens = cubit.state.signUpScreens;
    final signUpScreens = cubit.signUpScreens;

    final stepsLength = signUpScreens.length;

    Widget widget(int index) {
      final current = signUpScreens[index];
      final labelLarge = Theme.of(context).textTheme.labelLarge;
      if (labelLarge == null) {
        throw Exception("labelLarge is null");
      }
      final animationDuration = 200.ms;

      return WillPopScope(
        onWillPop: () async {
          if (index == 0) {
            return true;
          }
          cubit.goBackToPreviousSignUpStep();
          return false;
        },
        child: MarginedBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                    effects: const <Effect>[
                      FadeEffect(),
                      SlideEffect(
                        begin: Offset(-0.25, 0),
                      ),
                    ],
                    delay: animationDuration,
                    child: Text(
                      current.subtitle,
                      style: labelLarge.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              Expanded(
                child: Center(
                  child: Animate(
                    effects: const <Effect>[
                      FadeEffect(),
                      SlideEffect(
                        begin: Offset(-0.25, 0),
                      ),
                    ],
                    delay: animationDuration,
                    child: current.widgetBody,
                  ),
                ),
              ),
              // const Spacer(),
            ],
          ),
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
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLastView = state.currentStepIndex == stepsLength;

                    final current = signUpScreens[state.currentStepIndex - 1];

                    Future<void> onMainButtonPressed() async {
                      if (!(Routing.authCubit.state.authenticated ||
                          !isLastView)) {
                        return;
                      }

                      final onButtonTap = current.onButtonTap;
                      bool shouldAllowToForward;
                      try {
                        shouldAllowToForward = await current.nextViewAllower();
                      } catch (e) {
                        shouldAllowToForward = false;
                      }

                      if (!shouldAllowToForward) {
                        final val = SnackBars.text(
                          context,
                          current.errorText ?? "finishThisStepFirst".tr(),
                          isError: true,
                        );
                      } else {
                        if (onButtonTap != null) {
                          onButtonTap();
                        }
                        if (isLastView) {
                          BottomSheetService.showRouteAsBottomSheet(
                            context,
                            route: Paths.successAccountMade,
                          );
                          // final val = Navigator.of(context)
                          //     .pushNamed(Paths.successAccountMade);
                        } else {
                          cubit.gotoNextSignUpStep();
                        }
                      }
                    }

                    String? textDecider() {
                      final textIfAuthenticated =
                          Routing.authCubit.state.authenticated
                              ? "start".tr()
                              : null;

                      return isLastView
                          ? textIfAuthenticated
                          : "continueText".tr();
                    }

                    Widget? customWidgetDecider() {
                      return Routing.authCubit.state.authenticated ||
                              !isLastView
                          ? null
                          : SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.2,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            );
                    }

                    final animationDuration = 600.ms;
                    const height = 45.0;

                    return Animate(
                      effects: const <Effect>[
                        FadeEffect(),
                        SlideEffect(begin: Offset(0, 0.25)),
                      ],
                      delay: animationDuration,
                      child: MarginedBody(
                        child: SizedBox(
                          width: double.infinity,
                          height: height,
                          child: Stack(
                            alignment: AppUtils.instance
                                .centerTextHorizontalAlignment(context),
                            fit: StackFit.expand,
                            children: <Widget>[
                              AlIttihadButton(
                                onTap: onMainButtonPressed,
                                text: textDecider(),
                                customWidget: customWidgetDecider(),
                              ),
                              if (!isLastView)
                                Animate(
                                  effects: const <Effect>[FadeEffect()],
                                  delay: 2000.ms,
                                  child: Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    end: MarginedBody.defaultMargin.horizontal /
                                        2,
                                    child: Icon(
                                      AppUtils.instance
                                          .directionality_arrow_right_line(
                                        context,
                                      ),
                                      size: 21,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                )
                            ],
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
