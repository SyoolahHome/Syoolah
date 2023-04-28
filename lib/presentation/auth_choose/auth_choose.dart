import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:ditto/presentation/navigations_screen/home/widgets/global_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/strings.dart';
import '../../services/utils/paths.dart';
import '../general/widget/bottom_sheet_title_with_button.dart';
import 'widgets/app_bar.dart';
import 'widgets/box.dart';

class AuthChoose extends StatelessWidget {
  const AuthChoose({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    final isShownInBottomSheet =
        ModalRoute.of(context)?.settings.name != Paths.authChoose;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          if (isShownInBottomSheet) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: height * 2),
              child: MarginedBody(
                child: BottomSheetTitleWithIconButton(
                  title: AppStrings.chooseAuth,
                ),
              ),
            ),
          ] else ...[
            const CustomAppBar(),
          ],
          MarginedBody(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!isShownInBottomSheet) ...[
                  const SizedBox(height: kToolbarHeight),
                ],
                AuthChooseBox(
                  additionalDelay: 0.ms,
                  buttonText: AppStrings.create,
                  icon: FlutterRemix.arrow_right_line,
                  title: AppStrings.createNewAcc,
                  description: AppStrings.createNewAccDescription,
                  targetRoutePath: Paths.SignUp,
                ),
                const SizedBox(height: height * 3),
                OrDivider(
                  onlyDivider: true,
                  color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(height: height * 3),
                AuthChooseBox(
                  additionalDelay: 200.ms,
                  targetRoutePath: Paths.existentSignUp,
                  buttonText: AppStrings.login,
                  icon: FlutterRemix.arrow_right_line,
                  title: AppStrings.alreadyHaveAKey,
                  description: AppStrings.alreadyHaveAKeyDescription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
