import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';

class NoteOwnerUsername extends StatelessWidget {
  const NoteOwnerUsername({
    super.key,
    required this.nameToShow,
  });

  final String nameToShow;
  @override
  Widget build(BuildContext context) {
    return Text(
      nameToShow.capitalized,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: DefaultTextStyle.of(context).style.color!.withOpacity(.9),
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
