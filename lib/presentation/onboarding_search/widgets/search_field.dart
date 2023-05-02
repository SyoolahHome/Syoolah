import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/on_boarding/on_boarding_cubit.dart';
import '../../../constants/app_strings.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Animate(
      delay: const Duration(milliseconds: 400),
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(
          begin: Offset(0, 0.5),
        )
      ],
      child: TextField(
        focusNode: cubit.searchNodeFocus,
        controller: cubit.searchController,
        decoration: InputDecoration(
          hintText: AppStrings.searchUsersHint,
          filled: true,
          fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
