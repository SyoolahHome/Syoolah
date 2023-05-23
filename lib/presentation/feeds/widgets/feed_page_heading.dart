import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FeedPageHeading extends StatelessWidget {
  const FeedPageHeading({
    super.key,
    required this.notesLength,
    required this.feedName,
    this.hideCount = false,
    this.endTitleWithAdditionalText = true,
  });

  final int notesLength;
  final String feedName;
  final bool hideCount;
  final bool endTitleWithAdditionalText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Text(
            endTitleWithAdditionalText
                ? "feedOfName".tr(args: [feedName])
                : feedName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          if (!hideCount)
            Container(
              padding: const EdgeInsets.all(7.5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
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
                        color: Theme.of(context).primaryColor,
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
