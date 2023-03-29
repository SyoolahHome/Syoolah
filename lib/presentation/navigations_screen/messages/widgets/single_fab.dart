import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';

class SingleFAB extends StatelessWidget {
  const SingleFAB({
    super.key,
    required this.onPressed,
    required this.toolTip,
    required this.heroTag,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String toolTip;
  final String heroTag;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.teal,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: buttonBorderColor, width: 3),
        borderRadius: BorderRadius.circular(100),
      ),
      tooltip: toolTip,
      heroTag: heroTag,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
