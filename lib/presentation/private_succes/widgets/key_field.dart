import 'package:flutter/material.dart';

class KeyField extends StatelessWidget {
  const KeyField({
    super.key,
    required this.text,
    required this.isPasswordVisible,
  });

  final String text;
  final bool isPasswordVisible;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPasswordVisible,
      controller: TextEditingController(text: text),
      style: Theme.of(context).textTheme.labelSmall,
      enabled: false,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
