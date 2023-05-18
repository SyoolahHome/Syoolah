import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrivateKeyLabel extends StatelessWidget {
  const PrivateKeyLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Paths.existentSignUp);
      },
      child: Text(
        "privateKeyAccess".tr(),
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
