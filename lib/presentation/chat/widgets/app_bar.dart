import 'package:ditto/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(AppStrings.imamOnDuty),
      actions: <Widget>[
        SizedBox(width: 10),
        IconButton(
          icon: Icon(FlutterRemix.more_2_line),
          onPressed: () {},
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
