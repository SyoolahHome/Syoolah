import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import '../../../constants/colors.dart';

class PostField extends StatelessWidget {
  const PostField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(AppStrings.yourPost),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: cubit.textController,
          decoration: InputDecoration(
            hintText: AppStrings.typeHere,
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.grey,
                ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 25,
            ),
            fillColor: AppColors.lighGrey,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
