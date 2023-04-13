import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: AppColors.teal,
          width: 2,
        ),
      ),
      onPressed: () {
        context.read<FeedCubit>().resetSearch();
      },
      child: Text(
        AppStrings.reset,
        style: TextStyle(
          color: AppColors.teal,
        ),
      ),
    );
  }
}
