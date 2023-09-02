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

import '../general/pattern_widget.dart';

class AuthChoose extends StatelessWidget {
  const AuthChoose({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    final routeSettings = ModalRoute.of(context)?.settings;

    if (routeSettings == null) {
      throw Exception(
        "routeSettings is null, are you sure you're using this"
        "widget in a route?",
      );
    }

    final isShownInBottomSheet = routeSettings.name != Paths.authChoose;

    return Scaffold(
      body: PatternWidget(
        showPattern: isShownInBottomSheet,
        child: Stack(
          children: <Widget>[
            CustomAppBar(isShownInBottomSheet: isShownInBottomSheet),
            MarginedBody(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: kToolbarHeight),
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
                  const OrDivider(onlyDivider: true),
                  const SizedBox(height: height * 3),
                  AuthChooseBox(
                    isShownInBottomSheet: isShownInBottomSheet,
                    additionalDelay: 200.ms,
                    targetRoutePath: Paths.existentSignUp,
                    buttonText: "continueText".tr(),
                    icon: FlutterRemix.arrow_right_line,
                    title: "bringYourOwn".tr().titleCapitalized,
                    description: "useYourOwnKeysTogetInDirectly".tr(),
                  ),
                  // const SizedBox(height: height * 3),
                  // const OrDivider(onlyDivider: true),
                  // const SizedBox(height: height * 3),
                  // AuthChooseBox(
                  //   isShownInBottomSheet: isShownInBottomSheet,
                  //   additionalDelay: 200.ms,
                  //   targetRoutePath: Paths.tangemAuth,
                  //   buttonText: "continueText".tr(),
                  //   icon: FlutterRemix.arrow_right_line,
                  //   title: "Tangem Card".tr().titleCapitalized,
                  //   description: "r".tr(),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
