import 'package:flutter/material.dart';

class ActionButtonContainer extends StatelessWidget {
  const ActionButtonContainer({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
