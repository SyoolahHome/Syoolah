import 'package:flutter/material.dart';

class PatternWidget extends StatelessWidget {
  const PatternWidget({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pattern.jpg'),
          opacity: 0.1,
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: child,
    );
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
    return Scaffold(
      body: PatternWidget(
        child: body,
      ),
    );
  }
}
