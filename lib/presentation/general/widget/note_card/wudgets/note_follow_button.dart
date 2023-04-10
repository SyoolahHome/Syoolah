import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/strings.dart';

class NoteFollowButton extends StatelessWidget {
  const NoteFollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.5,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: AppColors.teal,
        ),
        child: Text(
          AppStrings.follow,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
