import 'package:ditto/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
        ),
        onPressed: onTap,
        child: Text(
          AppStrings.save,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
    );
  }
}
