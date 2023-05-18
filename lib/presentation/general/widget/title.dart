import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({
    super.key,
    required this.title,
    this.isForSection = false,
    this.alignment,
  });

  final String title;
  final bool isForSection;
  final Alignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: isForSection ? 32 : null,
            ),
      ),
    );
  }
}
