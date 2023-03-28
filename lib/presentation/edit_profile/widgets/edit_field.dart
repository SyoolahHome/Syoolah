import 'package:flutter/material.dart';

class EditField extends StatelessWidget {
  const EditField({
    super.key,
    required this.label,
  });

  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 15,
                  ),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
      ],
    );
  }
}
