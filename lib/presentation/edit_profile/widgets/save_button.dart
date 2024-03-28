import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
      child: AppBrandButton(
        onTap: onTap,
        text: "save".tr(),
      ),
    );
  }
}
