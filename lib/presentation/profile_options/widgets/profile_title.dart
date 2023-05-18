import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomSheetOptionsTitle extends StatelessWidget {
  const BottomSheetOptionsTitle({
    super.key,
    required this.title,
  });

  final String? title;
  @override
  Widget build(BuildContext context) {
    return BottomSheetTitleWithIconButton(
      title: title ?? "BottomSheetOptions".tr(),
    );
  }
}
