import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.createNote();
      },
      child: const Text(AppStrings.createNewPost),
    );
  }
}
