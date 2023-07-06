import 'package:ditto/presentation/current_user_keys/widgets/danger_box.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../general/pattern_widget.dart';
import '../general/widget/bottom_sheet_title_with_button.dart';

class SuccessAccountMade extends StatelessWidget {
  const SuccessAccountMade({super.key});

  @override
  Widget build(BuildContext context) {
    return PatternScaffold(
      body: MarginedBody(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Animate(
              effects: <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(0, 0.5),
                ),
              ],
              child: BottomSheetTitleWithIconButton(
                title: "",
              ),
            ),
            const SizedBox(height: 10),

            Animate(
              delay: 300.ms,
              effects: <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(0, 0.5),
                ),
              ],
              child: Icon(
                FlutterRemix.checkbox_circle_line,
                color: Colors.green.withOpacity(.8),
                size: 70,
              ),
            ),
            Animate(
              delay: 600.ms,
              effects: <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(0, 0.5),
                ),
              ],
              child: DangerBox(
                bgColor: Colors.green.withOpacity(.45),
                messageText: "accountCreatedSuccessfully".tr(),
                titleText: "success".tr(),
                showPopIcon: false,
              ),
            ),

            const SizedBox(height: 20),
            // const SizedBox(height: 10),
            // const Text(
            //   "You can now access all the features of the app and enjoy using Munawarah app.",
            //   textAlign: TextAlign.center,
            // ),
            Animate(
              delay: 900.ms,
              effects: <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(0, 0.5),
                ),
              ],
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: MunawarahButton(
                  icon: FlutterRemix.arrow_right_line,
                  isSmall: true,
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Paths.nostrServiceLoading);
                  },
                  text: 'letsGo'.tr(),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
