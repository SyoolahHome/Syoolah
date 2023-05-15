import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../services/utils/paths.dart';
import '../general/widget/margined_body.dart';

class SuccessAccountMade extends StatelessWidget {
  const SuccessAccountMade({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: MarginedBody(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Icon(
              FlutterRemix.checkbox_circle_line,
              // color: Colors.green,
              size: 70,
            ),
            SizedBox(height: 20),
            HeadTitle(
              title: "Account Created Successfully",
              alignment: Alignment.center,
            ),
            SizedBox(height: 10),
            Text(
              "You can now access all the features of the app and enjoy using Munawarah app.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: MunawarahButton(
                // isSmall: true,
                onTap: () {
                  final val = Navigator.of(context)
                      .pushNamed(Paths.nostrServiceLoading);
                },
                text: 'getIn'.tr(),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
