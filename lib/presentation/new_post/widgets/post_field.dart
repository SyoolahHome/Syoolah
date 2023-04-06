import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import '../../../constants/colors.dart';

class PostField extends StatelessWidget {
  const PostField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return TextField(
      controller: cubit.textController,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.all(10) + const EdgeInsets.symmetric(vertical: 20),
        fillColor: AppColors.lighGrey,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
