import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';

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
            color: DefaultTextStyle.of(context).style.color!.withOpacity(.9),
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
