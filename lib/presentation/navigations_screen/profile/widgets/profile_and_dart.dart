import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/follow_info.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../services/utils/paths.dart';
import 'avatar.dart';
import 'avatar_border.dart';
import 'avatar_neon.dart';
import 'avatar_neon_border.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.metadata,
    required this.followersCount,
    required this.followingCount,
  });

  final int followersCount;
  final int followingCount;
  final UserMetaData metadata;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FollowInfo(label: AppStrings.followings, count: followingCount),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const ProfileAvatarNeon(),
            const ProfileAvatarNeonBorder(),
            const ProfileAvatarBorder(),
            ProfileAvatar(picture: metadata.picture!),
          ],
        ),
        FollowInfo(label: AppStrings.followers, count: followersCount),
      ],
    );
  }
}
