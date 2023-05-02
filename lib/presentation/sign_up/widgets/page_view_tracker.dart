import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/app_colors.dart';

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
          color: Theme.of(context).colorScheme.background.withOpacity(0.05),
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
          child: Row(
            children: List.generate(
              stepsLength,
              (index) => Column(
                children: [
                  AnimatedOpacity(
                    duration: 200.ms,
                    opacity: currentStepIndex - 1 == index ? 1 : 0,
                    child: Text(
                      currentStepIndex.toString(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Container(
                    height: 5,
                    width: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: currentStepIndex - 1 >= index
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
