import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/navigations_screen/home/home.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.userMetadata,
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
              icon: const Icon(FlutterRemix.arrow_left_fill),
            )
          : null,
      actions: <Widget>[
        IconButton(
          icon: const Icon(FlutterRemix.more_2_line),
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
