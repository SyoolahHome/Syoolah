import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class FieldSuffixIcon extends StatelessWidget {
  const FieldSuffixIcon({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lighGrey,
      child: IconButton(
        icon: Icon(
          icon,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
