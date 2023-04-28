import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../../constants/colors.dart';

class NoteDateOfCreationAgo extends StatelessWidget {
  const NoteDateOfCreationAgo({
    super.key,
    required this.createdAt,
    this.isSmall = false,
  });

  final DateTime createdAt;
  final bool isSmall;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 5 : 10,
        vertical: isSmall ? 2.5 : 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.teal.withOpacity(.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Icon(
            FlutterRemix.time_line,
            size: isSmall ? 9 : 12.5,
            color: AppColors.teal,
          ),
          SizedBox(width: isSmall ? 2.5 : 5),
          Text(
            createdAt.toReadableString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: isSmall ? 7.5 : 10,
                  color: AppColors.teal,
                ),
          ),
        ],
      ),
    );
  }
}
