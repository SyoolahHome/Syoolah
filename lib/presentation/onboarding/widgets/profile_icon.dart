import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/on_boarding/on_boarding_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../services/utils/paths.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Hero(
      tag: '',
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          BottomSheetService.showRouteAsBottomSheet(
            Paths.authChoose,
            context,
            height: 575,
          );
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
            FlutterRemix.user_2_line,
            color: color ?? AppColors.black.withOpacity(0.75),
            size: 17.5,
          ),
        ),
      ),
    );
  }
}
