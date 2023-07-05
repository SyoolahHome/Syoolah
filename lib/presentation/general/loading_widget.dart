import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.strokeWidth,
    this.size,
    this.isVisible = true,
  });

  factory LoadingWidget.minor({
    bool isVisible = true,
  }) {
    return LoadingWidget(
      strokeWidth: 1.0,
      size: 15.0,
      isVisible: isVisible,
    );
  }
  final double? strokeWidth;
  final double? size;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: <Effect>[
        FadeEffect(),
      ],
      target: isVisible ? 1 : 0,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Theme.of(context).colorScheme.background,
          strokeWidth: strokeWidth ?? 2.0,
        ),
      ),
    );
  }
}
