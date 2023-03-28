import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../model/bottom_bat_item.dart';

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

    return NavigationBar(
      height: height,
      selectedIndex: selectedIndex,
      onDestinationSelected: onElementTap,
      destinations: items.indexedMap((index, item) {
        return NavigationDestination(
          icon: Icon(item.icon, color: AppColors.white),
          label: item.label,
        );
      }).toList(),
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
