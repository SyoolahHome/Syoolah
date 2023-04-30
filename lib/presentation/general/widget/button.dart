import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/app_colors.dart';

class MunawarahButton extends StatelessWidget {
  const MunawarahButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isSmall = false,
  });

  final VoidCallback onTap;
  final String text;
  final bool isSmall;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: (currentChild, previousChildren) => currentChild!,
      duration: 200.ms,
      child: SizedBox(
        key: ValueKey<String>(text),
        height: isSmall ? 30 : null,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black,
            elevation: isSmall ? 1 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: isSmall
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(10),
            ),
            padding: isSmall
                ? const EdgeInsets.symmetric(horizontal: 15, vertical: 0)
                : null,
            foregroundColor: AppColors.white.withOpacity(0.4),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontSize: isSmall ? 11 : 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
