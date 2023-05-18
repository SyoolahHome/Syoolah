import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../model/bottom_bar_item.dart';
import '../../../services/bottom_sheet/bottom_sheet_service.dart';

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
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            height: height,
            selectedIndex: selectedIndex,
            onDestinationSelected: onElementTap,
            destinations: items.indexedMap((index, item) {
              Widget possibleWidget = NavigationDestination(
                icon: Icon(
                  item.icon,
                ),
                selectedIcon: Icon(item.selectedIcon),
                label: item.label,
              );
              if (item.icon == FlutterRemix.add_line) {
                possibleWidget = Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        BottomSheetService.showCreatePostBottomSheet(context);
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: possibleWidget,
                      ),
                    ),
                  ],
                );
              }

              return Animate(
                delay: delayFromCenterToSidesBasedOnIndex(index),
                effects: <Effect>[FadeEffect()],
                child: possibleWidget,
              );
            }).toList(),
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
