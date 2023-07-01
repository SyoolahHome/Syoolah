import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Animate(
        effects: const <Effect>[
          FadeEffect(),
        ],
        delay: 1200.ms,
        child: TabBarView(
          children: cubit.state.profileTabsItems.map((e) {
            return e.widget;
          }).toList(),
        ),
      ),
    );
  }
}
