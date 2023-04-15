import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../general/widget/bottom_sheet_title_with_button.dart';

class ProfileOptionsTitle extends StatelessWidget {
  const ProfileOptionsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomSheetTitleWithIconButton(
      title: AppStrings.profileOptions,
    );
  }
}
