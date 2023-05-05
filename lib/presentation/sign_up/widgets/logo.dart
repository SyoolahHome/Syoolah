import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.logoSize = 120.0,
    this.padding,
  });

  final double logoSize;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: runtimeType.toString(),
      child: Tooltip(
        verticalOffset: 30.0,
        message: "homeTitle".tr(),
        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0.0),
          child: SizedBox(
            height: logoSize,
            width: logoSize,
            child: Image.asset(
              "assets/logo.png",
            ),
          ),
        ),
      ),
    );
  }
}
