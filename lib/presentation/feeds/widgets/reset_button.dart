import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../../constants/app_colors.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MunawarahButton(
      isOnlyBorder: true,
      onTap: () {
        Navigator.of(context).pop();
        context.read<GlobalFeedCubit>().resetSearch();
      },
      text: "reset".tr(),
    );
  }
}
