import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:easy_localization/easy_localization.dart';
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 2),
              child: MarginedBody(
                child: BottomSheetTitleWithIconButton(
                  title: "chooseAuth".tr(),
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
                // if (!isShownInBottomSheet) ...[
                const SizedBox(height: kToolbarHeight),
                // ],
                AuthChooseBox(
                  isShownInBottomSheet: isShownInBottomSheet,
                  additionalDelay: 0.ms,
                  buttonText: "create".tr(),
                  icon: FlutterRemix.arrow_right_line,
                  title: "createNewAcc".tr(),
                  description: "createNewAccDescription".tr(),
                  targetRoutePath: Paths.SignUp,
                ),
                const SizedBox(height: height * 3),
                OrDivider(
                  onlyDivider: true,
                  // color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(height: height * 3),
                AuthChooseBox(
                  isShownInBottomSheet: isShownInBottomSheet,
                  additionalDelay: 200.ms,
                  targetRoutePath: Paths.existentSignUp,
                  buttonText: "login".tr(),
                  icon: FlutterRemix.arrow_right_line,
                  title: "alreadyHaveAKey".tr(),
                  description: "alreadyHaveAKeyDescription".tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
