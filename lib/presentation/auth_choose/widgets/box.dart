import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/feed_box/feed_box_cubit.dart';
import '../../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../services/utils/paths.dart';
import '../../general/widget/button.dart';

class AuthChooseBox extends StatelessWidget {
  const AuthChooseBox({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.buttonText,
    required this.targetRoutePath,
  });

  final String title;
  final String description;
  final IconData icon;
  final String buttonText;
  final String targetRoutePath;
  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.of(context).pushNamed(targetRoutePath);
    }

    return Animate(
      delay: const Duration(milliseconds: 400),
      effects: <Effect>[
        FadeEffect(),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.lighGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
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
                        color: AppColors.black.withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.black.withOpacity(0.85),
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FlutterRemix.arrow_right_line,
                      size: 15,
                    ),
                    Animate(
                      delay: const Duration(milliseconds: 1500),
                      effects: <Effect>[
                        FadeEffect(),
                      ],
                      child: MunawarahButton(
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
