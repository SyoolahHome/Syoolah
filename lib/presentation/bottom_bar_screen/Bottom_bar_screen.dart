import 'dart:math' as math;
import 'package:ditto/buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/fab.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.cubit,
  });

  final HomePageAfterLoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalCubit>(
      create: (context) => GlobalCubit(
        currentUserFollowing: NostrService.instance.currentUserFollowings(),
        currentUserFollowers: NostrService.instance.currentUserFollowers(),
      ),
      child: BlocProvider.value(
        value: cubit,
        child: BlocProvider(
          create: (context) => BottomBarCubit(),
          child: Builder(
            builder: (context) {
              final cubit = context.read<BottomBarCubit>();
              return BlocBuilder<BottomBarCubit, int>(
                builder: (context, state) {
                  return Scaffold(
                    bottomNavigationBar: CustomBottomBar(
                      items: cubit.itemsToShowInBottomBarScreen,
                      selectedIndex:
                          state > cubit.itemsToShowInBottomBarScreen.length - 1
                              ? 0
                              : state,
                      onElementTap: cubit.onItemTapped,
                    ),
                    floatingActionButton: const CustomCreatePostFAB(),
                    body: AnimatedSwitcher(
                      duration: Animate.defaultDuration,
                      child: cubit.items[state].screen,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
