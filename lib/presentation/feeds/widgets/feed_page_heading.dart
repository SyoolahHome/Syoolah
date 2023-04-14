import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class FeedPageHeading extends StatelessWidget {
  const FeedPageHeading({
    super.key,
    required this.notesLength,
    required this.feedName,
    this.hideCount = false,
  });

  final int notesLength;
  final String feedName;
  final bool hideCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Text(
            AppStrings.feedOfName(feedName),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          if (!hideCount)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.teal.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: AnimatedSwitcher(
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                duration: const Duration(milliseconds: 300),
                child: Text(
                  "$notesLength",
                  key: ValueKey(notesLength),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
