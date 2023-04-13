import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class FollowInfo extends StatelessWidget {
  const FollowInfo({
    super.key,
    required this.label,
    required this.count,
  });

  final String label;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
