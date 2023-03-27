import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../scan/scan.dart';

class PrivateKeyLabel extends StatelessWidget {
  const PrivateKeyLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScanKey()),
        );
      },
      child: Text(
        AppStrings.privateKeyAccess,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.white,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.white,
              fontWeight: FontWeight.w300,
            ),
      ),
    );
  }
}
