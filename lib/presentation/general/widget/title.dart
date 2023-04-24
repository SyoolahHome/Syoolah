import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({
    super.key,
    required this.title,
    this.isForSection = false,
  });

  final String title;
  final bool isForSection;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isForSection ? 32 : null,
            ),
      ),
    );
  }
}
