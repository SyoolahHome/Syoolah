import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    required this.followingsList,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  final List<String> followingsList;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final globalCubit = context.read<GlobalCubit>();

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: HeadTitle(title: "followings".tr()),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
