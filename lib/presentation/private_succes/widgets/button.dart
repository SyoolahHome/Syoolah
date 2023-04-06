import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../services/utils/paths.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacementNamed(context, Paths.bottomBar);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          AppStrings.start,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
