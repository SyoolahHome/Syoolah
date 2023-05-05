import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../general/widget/bottom_sheet_title_with_button.dart';

class AddNewPostTitle extends StatelessWidget {
  const AddNewPostTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetTitleWithIconButton(
      title: "addNewPost".tr(),
    );
  }
}
