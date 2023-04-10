import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';

class NoteOwnerUsername extends StatelessWidget {
  const NoteOwnerUsername({
    super.key,
    required this.nameToShow,
  });

  final String nameToShow;
  @override
  Widget build(BuildContext context) {
    return Text(
      nameToShow,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.black.withOpacity(0.85),
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
