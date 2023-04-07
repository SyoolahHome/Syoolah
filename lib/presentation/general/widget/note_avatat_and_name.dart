import 'package:ditto/constants/colors.dart';
import 'package:flutter/material.dart';

class NoteAvatarAndName extends StatelessWidget {
  const NoteAvatarAndName({
    super.key,
    required this.avatarUrl,
    required this.nameToShow,
    required this.dateTimeToShow,
  });

  final String avatarUrl;
  final String nameToShow;
  final String dateTimeToShow;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
          radius: 22.5,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameToShow,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.black.withOpacity(0.85),
                  ),
            ),
            const SizedBox(height: 5),
            Text(
              dateTimeToShow,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.black.withOpacity(0.75),
                  ),
            ),
          ],
        )
      ],
    );
  }
}
