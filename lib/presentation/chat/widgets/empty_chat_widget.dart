import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/app_strings.dart';

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
          AppStrings.startConversation,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
