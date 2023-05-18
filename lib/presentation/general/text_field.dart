import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import '../../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.contentPadding,
    this.suffix,
    this.hint,
    this.isMultiline = false,
    this.focusNode,
    this.bgColor,
    this.fontWight,
  });

  final TextEditingController? controller;
  final String? label;
  final EdgeInsets? contentPadding;
  final Widget? suffix;
  final String? hint;
  final bool isMultiline;
  final FocusNode? focusNode;
  final Color? bgColor;
  final FontWeight? fontWight;

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
                color: Theme.of(context).primaryColor,
                fontWeight: fontWight,
              ),
              controller: controller,
              decoration: InputDecoration(
                hintText: hint ?? "typeHere".tr(),
                hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.grey,
                      fontWeight: fontWight,
                    ),
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 25,
                    ),
                fillColor: bgColor,
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
