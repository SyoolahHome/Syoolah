import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class AddNewPostTitle extends StatelessWidget {
  const AddNewPostTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          AppStrings.addNewPost,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        IconButton(
          icon: const Icon(FlutterRemix.close_line),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
