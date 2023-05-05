import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "yourName".tr(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
              ),
        ),
        const SizedBox(height: 5),
        TextField(
          style: const TextStyle(color: Colors.white),
          focusNode: context.read<AuthCubit>().nameFocusNode!,
          // controller: cubit.nameController,
          decoration: InputDecoration(
            hintText: "writeYourNameHere".tr(),
          ),
        ),
      ],
    );
  }
}
