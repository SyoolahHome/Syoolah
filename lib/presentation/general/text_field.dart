import 'package:ditto/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:hashtagable_v3/hashtagable.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 25,
    ),
    this.suffix,
    this.hint,
    this.isMultiline = false,
    this.focusNode,
    this.bgColor,
    this.fontWight,
    this.showClearButton = false,
    this.readOnly = false,
    this.maxLines,
    this.minLines = 1,
  });

  final TextEditingController? controller;
  final String? label;
  final EdgeInsets contentPadding;
  final Widget? suffix;
  final String? hint;
  final bool isMultiline;
  final FocusNode? focusNode;
  final Color? bgColor;
  final FontWeight? fontWight;
  final bool showClearButton;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null) ...<Widget>[
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
              minLines: minLines,
              focusNode: focusNode,
              readOnly: readOnly,
              maxLines: maxLines != null
                  ? maxLines
                  : isMultiline
                      ? 5
                      : 1,
              decoratedStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: fontWight,
              ),
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: showClearButton
                    ? Container(
                        margin: EdgeInsets.only(right: 5),
                        child: IconButton(
                          onPressed: () {
                            final textFieldController = controller;

                            if (textFieldController != null) {
                              textFieldController.clear();
                            }
                          },
                          icon: Icon(
                            FlutterRemix.close_line,
                            color: Theme.of(context)
                                .iconTheme
                                .color
                                ?.withOpacity(.25),
                          ),
                        ),
                      )
                    : null,
                hintText: hint ?? "typeHere".tr(),
                hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.grey,
                      fontWeight: fontWight,
                    ),
                contentPadding: contentPadding,
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
