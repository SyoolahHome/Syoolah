import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.contentPadding,
    this.suffix,
    this.hint,
    this.isMultiline = false,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? label;
  final EdgeInsets? contentPadding;
  final Widget? suffix;
  final String? hint;
  final bool isMultiline;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(height: 5),
        ],
        Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            HashTagTextField(
              minLines: 1,
              focusNode: focusNode,
              maxLines: isMultiline ? 5 : 1,
              autofocus: false,
              decoratedStyle: TextStyle(
                color: AppColors.teal,
              ),
              controller: controller,
              decoration: InputDecoration(
                hintText: hint ?? AppStrings.typeHere,
                hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.grey,
                    ),
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 25,
                    ),
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
