import 'package:ditto/constants/colors.dart';
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
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.lighGrey,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ],
      ),
    );
  }
}
