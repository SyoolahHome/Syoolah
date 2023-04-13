import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../../constants/colors.dart';

class NoteDateOfCreationAgo extends StatelessWidget {
  const NoteDateOfCreationAgo({
    super.key,
    required this.createdAt,
  });

  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.teal.withOpacity(.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Icon(
            FlutterRemix.time_line,
            size: 12.5,
            color: AppColors.teal,
          ),
          const SizedBox(width: 5),
          Text(
            createdAt.toReadableString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: AppColors.teal,
                ),
          ),
        ],
      ),
    );
  }
}
