import 'package:ditto/model/user_meta_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({super.key, required this.metadata});

  final UserMetaData metadata;
  @override
  Widget build(BuildContext context) {
    final String toShow = metadata.nameToShow();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          toShow,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(width: 5),
        const Icon(
          Icons.verified,
          color: Colors.green,
          size: 15,
        ),
      ],
    );
  }
}
