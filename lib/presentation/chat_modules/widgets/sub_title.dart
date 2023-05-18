import 'package:flutter/material.dart';

class ChatModulesSubtitle extends StatelessWidget {
  const ChatModulesSubtitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final labelLarge = Theme.of(context).textTheme.labelLarge!;

    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Text(
        text,
        style: labelLarge.copyWith(
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
