import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/utils/paths.dart';

class LNDAppBar extends StatelessWidget with PreferredSizeWidget {
  const LNDAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: Row(
        children: <Widget>[
          Text("f1_zaplocker".tr()),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Paths.myKeys);
          },
          icon: Icon(FlutterRemix.key_line),
        ),
        SizedBox(width: 10)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
