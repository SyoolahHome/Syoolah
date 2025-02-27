import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, -0.5)),
      ],
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const <Widget>[],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
