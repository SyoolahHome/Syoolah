import 'package:ditto/services/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../private_succes/widgets/key_field.dart';

class LNURLKeyField extends StatelessWidget {
  const LNURLKeyField({
    super.key,
    required this.lnurl,
  });

  final String lnurl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        KeyField(
          text: lnurl,
          isVisible: false,
        ),
        IconButton(
          onPressed: () {
            AppUtils.instance.copy(lnurl);
          },
          icon: Icon(
            FlutterRemix.clipboard_line,
            color: Theme.of(context).colorScheme.background.withOpacity(.8),
          ),
        ),
      ],
    );
  }
}
