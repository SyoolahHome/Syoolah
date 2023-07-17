import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/bottom_sheet/bottom_sheet_service.dart';

class CustomCreatePostFAB extends StatelessWidget {
  const CustomCreatePostFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: <Effect>[
        SlideEffect(
          begin: Offset(0, -0.075),
          end: Offset(0, 0.075),
          duration: 3000.ms,
        ),
      ],
      onComplete: (controller) => controller.repeat(reverse: true),
      child: FloatingActionButton(
        onPressed: () {
          BottomSheetService.showCreatePostBottomSheet(context);
        },
        child: const Icon(FlutterRemix.quill_pen_line),
      ),
    );
  }
}
