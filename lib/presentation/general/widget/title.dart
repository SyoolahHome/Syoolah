import 'package:flutter/material.dart';

import '../../../services/utils/app_utils.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({
    super.key,
    required this.title,
    this.isForSection = false,
    this.alignment,
    this.minimizeFontSizeBy = 0.0,
  });

  final String title;
  final bool isForSection;
  final Alignment? alignment;
  final double minimizeFontSizeBy;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          alignment ?? AppUtils.instance.centerTextHorizontalAlignment(context),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: isForSection ? (32 - minimizeFontSizeBy) : null,
            ),
      ),
    );
  }
}
