import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/presentation/onboarding/widgets/action_button_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Hero(
      tag: 'onBoardingSearch',
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          cubit.showSearchSheet(context);
        },
        splashFactory: NoSplash.splashFactory,
        child: ActionButtonContainer(
          child: Icon(
            FlutterRemix.search_line,
            color: color ?? Theme.of(context).colorScheme.onSecondary,
            size: 17.5,
          ),
        ),
      ),
    );
  }
}
