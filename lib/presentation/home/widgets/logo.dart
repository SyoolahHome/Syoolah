import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.logoSize = 180.0,
    this.padding = const EdgeInsets.only(top: 180.0),
  });

  final double logoSize;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: logoSize,
        width: logoSize,
        child: Image.asset(
          "assets/logo.png",
        ),
      ),
    );
  }
}
