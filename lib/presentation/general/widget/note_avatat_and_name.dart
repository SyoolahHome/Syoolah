import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/services/nostr/nostr.dart';
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
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(
              color: AppColors.teal,
              width: 1,
            ),
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
            radius: 21.5,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameToShow,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.black.withOpacity(0.85),
                    fontWeight: FontWeight.bold,
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
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            backgroundColor: AppColors.teal,
          ),
          child: Text(
            AppStrings.follow,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
