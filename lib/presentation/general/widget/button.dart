import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MunawarahButton extends StatelessWidget {
  const MunawarahButton({
    super.key,
    required this.onTap,
    this.text,
    this.isSmall = false,
    this.isRounded = true,
    this.icon,
    this.isOnlyBorder = false,
    this.customWidget,
  });

  final VoidCallback onTap;
  final String? text;
  final bool isSmall;
  final bool isRounded;
  final bool isOnlyBorder;
  final IconData? icon;
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: (currentChild, previousChildren) => currentChild!,
      duration: 200.ms,
      child: SizedBox(
        key: ValueKey<String>(text.toString()),
        height: isSmall ? 30 : null,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isOnlyBorder
                ? Colors.transparent
                : Theme.of(context).colorScheme.background,
            elevation: isOnlyBorder
                ? 0
                : isSmall
                    ? 1
                    : 4,
            shape: RoundedRectangleBorder(
              borderRadius: isSmall
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(10),
            ),
            side: isOnlyBorder
                ? BorderSide(
                    color: Theme.of(context).colorScheme.background,
                    width: 1.5,
                  )
                : null,
            padding: isSmall
                ? const EdgeInsets.symmetric(horizontal: 15, vertical: 0)
                : null,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (customWidget != null) customWidget!,
              if (text != null)
                Text(
                  text!,
                  style: TextStyle(
                    color: isOnlyBorder
                        ? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.onBackground,
                    fontSize: isSmall ? 11 : 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (text != null && icon != null) SizedBox(width: 7.5),
              if (icon != null) ...[
                Icon(
                  icon,
                  size: isSmall ? 12.5 : 15,
                  color: isOnlyBorder
                      ? Theme.of(context).colorScheme.background
                      : null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
