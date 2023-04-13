import 'package:ditto/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../model/user_meta_data.dart';

class ProfileAbout extends StatelessWidget {
  const ProfileAbout({
    super.key,
    required this.metadata,
  });

  final UserMetaData metadata;
  @override
  Widget build(BuildContext context) {
    return Text(
      metadata.about! * 12,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.grey),
      textAlign: TextAlign.center,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
