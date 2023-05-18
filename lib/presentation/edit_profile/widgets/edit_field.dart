import 'package:ditto/presentation/general/text_field.dart';
import 'package:flutter/material.dart';

class EditField extends StatelessWidget {
  const EditField({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextField(
            label: label,
            controller: controller,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ],
      ),
    );
  }
}
