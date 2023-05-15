import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/utils/paths.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(FlutterRemix.arrow_left_line),
      ),
      actions: <Widget>[
        MunawarahButton(
          onTap: () {
            Navigator.of(context).pushNamed(Paths.myKeys);
          },
          isSmall: true,
          text: "myKeys".tr(),
          icon: FlutterRemix.key_2_line,
          iconSize: 15,
          isOnlyBorder: true,
        ),
        SizedBox(width: 10),
        // IconButton(
        //   icon: const Icon(FlutterRemix.key_2_line),
        //   onPressed:
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
