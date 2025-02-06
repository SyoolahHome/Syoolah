import 'package:flutter/material.dart';

class PatternWidget extends StatelessWidget {
  const PatternWidget({
    super.key,
    required this.child,
    this.showPattern = true,
  });

  final Widget child;
  final bool showPattern;
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class PatternScaffold extends StatelessWidget {
  const PatternScaffold({
    super.key,
    required this.body,
  });

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: PatternWidget(
          child: body,
        ),
      ),
    );
  }
}
