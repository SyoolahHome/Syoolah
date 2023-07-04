import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat_modules/chat_modules.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onElementTap,
    required this.items,
  });

  final int selectedIndex;
  final Function(int) onElementTap;
  final List<BottomBarItem> items;

  @override
  Widget build(BuildContext context) {
    const height = 65.0;

    return BlocBuilder<HomePageAfterLoginCubit, HomePageAfterLoginState>(
      builder: (context, state) {
        if (state.didConnectedToRelaysAndSubscribedToTopics) {
          return NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: height,
            selectedIndex: selectedIndex,
            onDestinationSelected: onElementTap,
            animationDuration: Animate.defaultDuration,
            destinations: items.indexedMap(
              (index, item) {
                Widget possibleWidget = NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon),
                  label: item.label,
                );

                if (item.screen is ChatModules) {
                  possibleWidget = Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          BottomSheetService.showWidgetAsBottomSheet(
                            item.screen,
                            context,
                          );
                        },
                        child: AbsorbPointer(
                          child: possibleWidget,
                        ),
                      ),
                    ],
                  );
                }

                return Animate(
                  delay: delayFromCenterToSidesBasedOnIndex(index),
                  effects: const <Effect>[
                    FadeEffect(),
                  ],
                  child: possibleWidget,
                );
              },
            ).toList(),
          );
        } else if (state.isLoading) {
          return Container(
            height: height,
            color: AppColors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Text("readhed here");
        }
      },
    );
  }

  Duration delayFromCenterToSidesBasedOnIndex(int index) {
    final centerIndex = items.length ~/ 2;
    final distanceFromCenter = (index - centerIndex).abs();
    return Duration(milliseconds: 100 * distanceFromCenter);
  }
}

// create indexed map method extension for list
extension IndexedMap<T> on List<T> {
  List<R> indexedMap<R>(R Function(int index, T item) map) {
    final result = <R>[];
    for (var i = 0; i < length; i++) {
      result.add(map(i, this[i]));
    }
    return result;
  }
}
