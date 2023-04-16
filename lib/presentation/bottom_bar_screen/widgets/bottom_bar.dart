import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../../constants/colors.dart';
import '../../../model/bottom_bat_item.dart';
import '../../../services/bottom_sheet/bottom_sheet.dart';

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
            height: height,
            selectedIndex: selectedIndex,
            onDestinationSelected: onElementTap,
            destinations: items.indexedMap((index, item) {
              Widget possibleWidget = NavigationDestination(
                icon: Icon(
                  item.icon,
                  color: AppColors.white,
                  size: 19,
                ),
                label: item.label,
              );
              if (item.icon == FlutterRemix.add_line) {
                possibleWidget = Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                        BottomSheetService.showCreatePostBottomSheet(context);
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: possibleWidget,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 30,
                      height: 1.5,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: const Text(
                        "Create",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return possibleWidget;
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
