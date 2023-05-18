import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/bottom_sheet/bottom_sheet_service.dart';

class CustomCreatePostFAB extends StatelessWidget {
  const CustomCreatePostFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BottomSheetService.showCreatePostBottomSheet(context);
      },
      child: const Icon(FlutterRemix.quill_pen_line),
    );
  }
}
