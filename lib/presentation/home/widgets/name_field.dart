import 'package:ditto/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../constants/strings.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.yourName,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
              ),
        ),
        const SizedBox(height: 5),
        const TextField(
          decoration: InputDecoration(
            hintText: AppStrings.writeYourNameHere,
          ),
        ),
      ],
    );
  }
}
