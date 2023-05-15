import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/global/global_cubit.dart';
import '../../../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.followingsList,
  });

  final List<String> followingsList;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final globalCubit = context.read<GlobalCubit>();

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: HeadTitle(title: "yourFollowings".tr()),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            FlutterRemix.more_2_line,
          ),
          onPressed: () {
            cubit.onFollowingsMorePressed(
              context,
              followings: followingsList,
              onUnFollowAll: () {
                for (var i = 0; i < followingsList.length; i++) {
                  globalCubit.handleFollowButtonTap(followingsList[i]);
                }
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
