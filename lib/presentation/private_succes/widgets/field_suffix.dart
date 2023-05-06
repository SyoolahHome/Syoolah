import 'package:flutter/material.dart';

class FieldSuffixIcon extends StatelessWidget {
  const FieldSuffixIcon({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      child: IconButton(
        icon: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
