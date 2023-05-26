import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import '../../profile/profile.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BottomBarCubit>();

    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
      onPressed: () {
        final profileItemIndex =
            cubit.items.indexWhere((item) => item.screen is Profile);

        cubit.onItemTapped(profileItemIndex);
      },
      icon: const Icon(FlutterRemix.user_line),
    );
  }
}
