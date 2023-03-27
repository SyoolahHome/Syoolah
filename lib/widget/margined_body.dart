import 'package:flutter/material.dart';

class MarginedBody extends StatelessWidget {
  const MarginedBody({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
  });

  final Widget child;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: child,
    );
  }
}
