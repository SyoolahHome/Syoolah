import 'package:flutter/material.dart';

class SingleFAB extends StatelessWidget {
  const SingleFAB({
    super.key,
    required this.onPressed,
    required this.toolTip,
    required this.heroTag,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String toolTip;
  final String heroTag;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor, width: 3),
        borderRadius: BorderRadius.circular(100),
      ),
      tooltip: toolTip,
      heroTag: heroTag,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
