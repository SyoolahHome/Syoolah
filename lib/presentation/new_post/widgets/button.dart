import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import '../../../constants/colors.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return Row(
      children: [
        IconButton(
          onPressed: () {
            cubit.addImage();
          },
          icon: Icon(
            FlutterRemix.image_add_line,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            cubit.createNote();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.teal),
          ),
          child: Text(
            AppStrings.createNewPost,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.white,
                ),
          ),
        ),
      ],
    );
  }
}
