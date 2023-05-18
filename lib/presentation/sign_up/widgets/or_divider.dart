import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
    this.onlyDivider = false,
    this.color,
  });

  final bool onlyDivider;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final localColor = color ?? Theme.of(context).dividerColor;

    return Animate(
      delay: const Duration(milliseconds: 1000),
      effects: const <Effect>[FadeEffect()],
      child: SizedBox(
        width: mq.size.width * 0.55,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.centerLeft,
                    begin: Alignment.centerRight,
                    colors: [
                      localColor.withOpacity(0.55),
                      localColor.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            if (onlyDivider) ...[
              const SizedBox(width: 5),
              Text(
                'OR',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: localColor,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              const SizedBox(width: 5),
            ],
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      localColor.withOpacity(0.55),
                      localColor.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
