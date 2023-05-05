import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          FlutterRemix.chat_off_line,
          size: 60,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        SizedBox(height: 40),
        Text(
          "startConversation".tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
