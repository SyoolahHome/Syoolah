import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/home/widgets/or_divider.dart';
import 'package:ditto/presentation/navigations_screen/home/widgets/global_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/strings.dart';
import '../../services/utils/paths.dart';
import 'widgets/app_bar.dart';
import 'widgets/box.dart';

class AuthChoose extends StatelessWidget {
  const AuthChoose({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const CustomAppBar(),
          MarginedBody(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AuthChooseBox(
                  buttonText: AppStrings.create,
                  icon: FlutterRemix.arrow_right_line,
                  title: AppStrings.createNewAcc,
                  description: AppStrings.createNewAccDescription,
                  onTap: () {},
                  targetRoutePath: Paths.keyAuth,
                ),
                const SizedBox(height: height * 3),
                OrDivider(
                  onlyDivider: true,
                  color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(height: height * 3),
                AuthChooseBox(
                  targetRoutePath: Paths.existentKeyAuth,
                  buttonText: AppStrings.login,
                  icon: FlutterRemix.arrow_right_line,
                  title: AppStrings.alreadyHaveAKey,
                  description: AppStrings.alreadyHaveAKeyDescription,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
