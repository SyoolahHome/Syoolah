import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          Animate(
            effects: [
              FadeEffect(
                duration: Duration(
                    milliseconds: Animate.defaultDuration.inMilliseconds ~/ 2,),
              )
            ],
            key: ValueKey<int>(count),
            child: Text(
              count.toString(),
              key: ValueKey<int>(count),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
