import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../services/utils/paths.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldColor =
        context.findAncestorWidgetOfExactType<Scaffold>()!.backgroundColor;

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              AppStrings.continueText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: scaffoldColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
