import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/presentation/onboarding/widgets/action_button_container.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
      child: ActionButtonContainer(
        child: Icon(
          FlutterRemix.contrast_2_line,
          color: color ?? Theme.of(context).colorScheme.onSecondary,
          size: 17.5,
        ),
      ),
    );
  }
}
