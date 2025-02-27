import 'package:ditto/presentation/general/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/utils/app_utils.dart';

class AuthChooseBox extends StatelessWidget {
  const AuthChooseBox({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.buttonText,
    required this.targetRoutePath,
    required this.additionalDelay,
    this.isShownInBottomSheet,
  });

  final String title;
  final String description;
  final IconData icon;
  final String buttonText;
  final String targetRoutePath;
  final Duration additionalDelay;
  final bool? isShownInBottomSheet;
  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.of(context).pushNamed(targetRoutePath);
    }

    return Animate(
      delay: const Duration(milliseconds: 400),
      effects: const <Effect>[
        FadeEffect(),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onTap: onTap,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (isShownInBottomSheet == false) ...[
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.95),
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Animate(
                      delay: additionalDelay * 2,
                      effects: <Effect>[
                        SlideEffect(
                          begin: Offset(-0.35, 0),
                          end: Offset(0.35, 0),
                          duration: 2500.ms,
                        ),
                      ],
                      onComplete: (controller) =>
                          controller.repeat(reverse: true),
                      child: Icon(
                        AppUtils.instance.directionalityIcon(
                          context,
                          onArabicIcon: FlutterRemix.arrow_left_fill,
                          onNonArabicIcon: FlutterRemix.arrow_right_fill,
                        ),
                        size: 15,
                      ),
                    ),
                    Animate(
                      delay: 1500.ms + additionalDelay,
                      effects: const <Effect>[FadeEffect()],
                      child: RoundaboutButton(
                        isSmall: true,
                        onTap: onTap,
                        text: buttonText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
