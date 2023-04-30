import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/on_boarding/on_boarding_cubit.dart';
import '../../../constants/colors.dart';
import '../../../services/database/local/local.dart';
import '../../../services/utils/paths.dart';

class DarkIcon extends StatelessWidget {
  const DarkIcon({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        LocalDatabase.instance.toggleThemeState();
      },
      splashFactory: NoSplash.splashFactory,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.black.withOpacity(0.05),
        ),
        child: Icon(
          FlutterRemix.contrast_2_line,
          color: color ?? AppColors.black.withOpacity(0.75),
          size: 17.5,
        ),
      ),
    );
  }
}
