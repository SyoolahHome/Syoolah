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
  });

  final VoidCallback onTap;
  final String? text;
  final bool isSmall;
  final bool isRounded;
  final IconData? icon;

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
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: isSmall ? 1 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: isSmall
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(10),
            ),
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
              if (text != null)
                Text(
                  text!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: isSmall ? 11 : 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (icon != null) ...[
                SizedBox(width: 7.5),
                Icon(icon, size: isSmall ? 12.5 : 15),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
