import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';

import '../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import '../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../model/bottom_bat_item.dart';
import 'widgets/bottom_bar.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.cubit,
  });
  final HomePageAfterLoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocProvider(
        create: (context) => BottomBarCubit(),
        child: Builder(builder: (context) {
          final cubit = context.read<BottomBarCubit>();
          return BlocBuilder<BottomBarCubit, int>(builder: (context, state) {
            return Scaffold(
              bottomNavigationBar: CustomBottomBar(
                items: cubit.items,
                selectedIndex: state,
                onElementTap: cubit.onItemTapped,
              ),
              body: FadeIndexedStack(
                index: state,
                children: cubit.items.map(
                  (BottomBarItem item) {
                    return item.screen;
                  },
                ).toList(),
              ),
            );
          });
        }),
      ),
    );
  }
}
