import 'package:flutter/material.dart';
import '../../general/widget/bottom_sheet_title_with_button.dart';
import 'package:easy_localization/easy_localization.dart';

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
