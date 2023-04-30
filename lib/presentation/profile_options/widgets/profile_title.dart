import 'package:ditto/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../general/widget/bottom_sheet_title_with_button.dart';

class BottomSheetOptionsTitle extends StatelessWidget {
  const BottomSheetOptionsTitle({
    super.key,
    required this.title,
  });

  final String? title;
  @override
  Widget build(BuildContext context) {
    return BottomSheetTitleWithIconButton(
      title: title ?? AppStrings.BottomSheetOptions,
    );
  }
}
