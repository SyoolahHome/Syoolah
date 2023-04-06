import 'package:flutter/material.dart';

class MarginedBody extends StatelessWidget {
  static const EdgeInsets defaultMargin = EdgeInsets.symmetric(horizontal: 16);
  const MarginedBody({
    super.key,
    required this.child,
    this.margin = defaultMargin,
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
