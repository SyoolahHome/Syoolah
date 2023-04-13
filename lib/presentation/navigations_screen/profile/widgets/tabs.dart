import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/profile/profile_cubit.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return TabBar(
      indicatorWeight: 1,
      tabs: cubit.state.profileTabsItems.map((e) {
        return Tab(
          icon: Icon(
            e.icon,
            size: 18,
          ),
          text: e.label.capitalized,
        );
      }).toList(),
    );
  }
}
