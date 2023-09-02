import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Animate(
      effects: const [FadeEffect()],
      delay: 1000.ms,
      child: TabBar(
        isScrollable: true,
        labelColor: Theme.of(context).colorScheme.background,
        indicatorColor: Theme.of(context).colorScheme.background,
        indicatorWeight: 1,
        tabs: cubit.state.profileTabsItems.map(
          (e) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Tab(
                icon: Icon(e.icon, size: 18),
                text: e.label.capitalized,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
