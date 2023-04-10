import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../margined_body.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MarginedBody.defaultMargin.horizontal / 2,
        vertical: MarginedBody.defaultMargin.horizontal / 4,
      ),
      margin: EdgeInsets.symmetric(
        vertical: MarginedBody.defaultMargin.horizontal / 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lighGrey,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
