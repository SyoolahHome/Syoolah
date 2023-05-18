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
    this.iconSize,
    this.mainColor,
  });

  final VoidCallback onTap;
  final String? text;
  final bool isSmall;
  final bool isRounded;
  final bool isOnlyBorder;
  final IconData? icon;
  final Widget? customWidget;
  final double? iconSize;
  final Color? mainColor;

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
                : mainColor ?? Theme.of(context).colorScheme.background,
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
                    color:
                        mainColor ?? Theme.of(context).colorScheme.background,
                  )
                : null,
            padding:
                isSmall ? const EdgeInsets.symmetric(horizontal: 15) : null,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (customWidget != null) customWidget!,
              if (text != null)
                Text(
                  text!,
                  style: TextStyle(
                    color: isOnlyBorder
                        ? mainColor ?? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.onBackground,
                    fontSize: isSmall ? 11 : 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (text != null && icon != null) const SizedBox(width: 7.5),
              if (icon != null) ...[
                Icon(
                  icon,
                  size: iconSize != null
                      ? iconSize!
                      : isSmall
                          ? 12.5
                          : 15,
                  color: isOnlyBorder
                      ? mainColor ?? Theme.of(context).colorScheme.background
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
