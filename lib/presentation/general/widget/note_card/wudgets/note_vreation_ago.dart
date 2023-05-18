import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../../constants/app_colors.dart';

class NoteDateOfCreationAgo extends StatelessWidget {
  const NoteDateOfCreationAgo({
    super.key,
    required this.createdAt,
    this.isSmall = false,
    this.isMedium = false,
  });

  final DateTime createdAt;
  final bool isSmall;
  final bool isMedium;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingDecider(),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            FlutterRemix.time_line,
            size: iconSizeDecider(),
            color: Theme.of(context).colorScheme.background,
          ),
          SizedBox(width: isSmall ? 2.5 : 5),
          Text(
            createdAt.toReadableString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: fontSizeDecider(),
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
        ],
      ),
    );
  }

  EdgeInsets paddingDecider() {
    if (isSmall) {
      return EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 2.5,
      );
    } else if (isMedium) {
      return EdgeInsets.symmetric(
        horizontal: 7.5,
        vertical: 5,
      );
    } else {
      return EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7.5,
      );
    }
  }

  double iconSizeDecider() {
    if (isSmall) {
      return 9;
    } else if (isMedium) {
      return 12.5;
    } else {
      return 15;
    }
  }

  double fontSizeDecider() {
    if (isSmall) {
      return 7.5;
    } else if (isMedium) {
      return 10;
    } else {
      return 12.5;
    }
  }
}
