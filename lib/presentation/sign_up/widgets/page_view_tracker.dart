import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/colors.dart';

class PageViewTracker extends StatelessWidget {
  const PageViewTracker({
    super.key,
    required this.currentStepIndex,
    required this.stepsLength,
  });

  final int currentStepIndex;
  final int stepsLength;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.05),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: AnimatedSwitcher(
          transitionBuilder: (wid, val) {
            return FadeTransition(
              opacity: val,
              child: wid,
            );
          },
          duration: 200.ms,
          child: Text.rich(
            TextSpan(
              text: "",
              children: <TextSpan>[
                TextSpan(
                  text: "$currentStepIndex",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                ),
                TextSpan(
                  text: " / $stepsLength",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                ),
              ],
            ),
            key: ValueKey<int>(currentStepIndex),
          ),
        ),
      ),
    );
  }
}
