import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class AboutMunawarahTitle extends StatelessWidget {
  const AboutMunawarahTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.aboutMunawarahWe,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
          ),
    );
  }
}
