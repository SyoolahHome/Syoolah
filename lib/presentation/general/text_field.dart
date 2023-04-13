import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.contentPadding,
      this.suffix});

  final TextEditingController controller;
  final String label;
  final EdgeInsets? contentPadding;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label),
        const SizedBox(height: 5),
        Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            HashTagTextField(
              decoratedStyle: TextStyle(
                color: AppColors.teal,
              ),
              controller: controller,
              decoration: InputDecoration(
                hintText: AppStrings.typeHere,
                hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.grey,
                    ),
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(
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
            if (suffix != null) suffix!,
          ],
        ),
      ],
    );
  }
}
