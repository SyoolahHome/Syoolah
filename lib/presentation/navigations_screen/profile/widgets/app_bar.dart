import 'package:ditto/model/user_meta_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/profile/profile_cubit.dart';
import '../../../../constants/app_colors.dart';
import '../../../../services/utils/paths.dart';
import '../../../general/widget/title.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.userMetadata,
  });

  final UserMetaData userMetadata;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return AppBar(
      title: HeadTitle(title: "myProfile".tr()),
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(FlutterRemix.more_2_line, color: AppColors.black),
          onPressed: () {
            cubit.onMorePressed(
              context,
              onMyKeysPressed: () {
                Navigator.of(context).pushNamed(
                  Paths.myKeys,
                );
              },
              onEditProfile: () {
                Navigator.of(context).pushNamed(
                  Paths.editProfile,
                  arguments: userMetadata,
                );
              },
              onLogout: () {
                cubit.logout(
                  onSuccess: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Paths.onBoarding);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
