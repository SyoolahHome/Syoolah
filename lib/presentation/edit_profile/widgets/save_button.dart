import 'package:ditto/constants/strings.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../bottom_bar_screen/bottom_bar_screen.dart';

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
