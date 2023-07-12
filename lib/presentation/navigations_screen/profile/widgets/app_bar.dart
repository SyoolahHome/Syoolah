import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/navigations_screen/home/home.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import '../../../../services/utils/app_utils.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    required this.userMetadata,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  final UserMetaData userMetadata;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final bottomBarCubit = context.read<BottomBarCubit>();

    final shouldShowLeading = bottomBarCubit.shouldShowLeadingOnProfile;

    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      leading: shouldShowLeading
          ? IconButton(
              onPressed: () {
                final indexOfHomeScreen =
                    bottomBarCubit.itemsToShowInBottomBarScreen.indexWhere(
                  (element) => element.screen is Home,
                );

                bottomBarCubit.onItemTapped(indexOfHomeScreen);
              },
              icon: Icon(
                  AppUtils.instance.directionality_arrow_left_fill(context)),
            )
          : null,
      actions: <Widget>[
        IconButton(
          icon: const Icon(FlutterRemix.more_2_line),
          style: IconButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.onBackground.withOpacity(.2),
          ),
          onPressed: () {
            cubit.onMorePressed(
              context,
              onMyKeysPressed: () {
                Navigator.of(context).pushNamed(Paths.myKeys);
              },
              onEditProfile: () {
                Navigator.of(context)
                    .pushNamed(Paths.editProfile, arguments: userMetadata);
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
