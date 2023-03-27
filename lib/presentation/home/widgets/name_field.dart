import 'package:flutter/material.dart';

import '../../../constants/strings.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    this.padding = const EdgeInsets.only(left: 80, right: 80, top: 16),
  });

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 15),
            borderRadius: BorderRadius.circular(50),
          ),
          hintText: AppStrings.whatIsYourName,
        ),
      ),
    );
  }
}
