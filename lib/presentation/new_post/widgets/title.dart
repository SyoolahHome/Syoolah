import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';

class AddNewPostTitle extends StatelessWidget {
  const AddNewPostTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.addNewPost,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
