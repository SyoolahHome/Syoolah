import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../general/widget/bottom_sheet_title_with_button.dart';

class BottomSheetOptionsTitle extends StatelessWidget {
  const BottomSheetOptionsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomSheetTitleWithIconButton(
      title: AppStrings.BottomSheetOptions,
    );
  }
}
