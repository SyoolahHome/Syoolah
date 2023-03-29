import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      FlutterRemix.checkbox_circle_line,
      color: AppColors.teal,
      size: 75,
    );
  }
}
