import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/presentation/onboarding/widgets/action_button_container.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
        child: ActionButtonContainer(
          child: Icon(
            FlutterRemix.user_2_line,
            color: color ?? Theme.of(context).colorScheme.onSecondary,
            size: 17.5,
          ),
        ),
      ),
    );
  }
}
