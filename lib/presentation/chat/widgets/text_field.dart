import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                controller: controller,
                onSubmitted: (value) => onSubmit(),
                decoration: InputDecoration(
                  hintText: "typeHere".tr(),
                ),
              ),
            ),
            IconButton(
              onPressed: () => onSubmit(),
              icon: const Icon(
                FlutterRemix.send_plane_2_line,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
