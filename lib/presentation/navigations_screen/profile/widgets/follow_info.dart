import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class FollowInfo extends StatelessWidget {
  const FollowInfo({
    super.key,
    required this.label,
    required this.count,
    this.onTap,
  });

  final String label;
  final int count;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
