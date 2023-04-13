import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
    this.onlyDivider = false,
    this.color = Colors.white,
  });

  final bool onlyDivider;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SizedBox(
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
                    color.withOpacity(0.55),
                    color.withOpacity(0.1),
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
                    color: color,
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
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    color.withOpacity(0.55),
                    color.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
