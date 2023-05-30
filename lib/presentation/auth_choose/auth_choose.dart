import 'package:ditto/presentation/auth_choose/widgets/app_bar.dart';
import 'package:ditto/presentation/auth_choose/widgets/box.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
              padding: const EdgeInsets.symmetric(vertical: height * 2),
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
                  title: "newCreateNewAcc".tr().titleCapitalized,
                  description: "aPrivatePublicKeyPairToAccessMunawarah".tr(),
                  targetRoutePath: Paths.SignUp,
                ),
                const SizedBox(height: height * 3),
                const OrDivider(
                  onlyDivider: true,
                  // color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(height: height * 3),
                AuthChooseBox(
                  isShownInBottomSheet: isShownInBottomSheet,
                  additionalDelay: 200.ms,
                  targetRoutePath: Paths.existentSignUp,
                  buttonText: "continueText".tr(),
                  icon: FlutterRemix.arrow_right_line,
                  title: "bringYourOwn".tr(),
                  description: "useYourOwnKeysTogetInDirectly".tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
