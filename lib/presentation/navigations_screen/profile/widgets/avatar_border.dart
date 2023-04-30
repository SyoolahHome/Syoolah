import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class ProfileAvatarBorder extends StatelessWidget {
  const ProfileAvatarBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
    );
  }
}
