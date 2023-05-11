import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/profile/profile_cubit.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Animate(
      effects: [FadeEffect()],
      delay: 1200.ms,
      child: TabBarView(
        children: cubit.state.profileTabsItems.map((e) {
          return e.widget;
        }).toList(),
      ),
    );
  }
}
