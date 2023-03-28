import 'package:ditto/presentation/navigations_screen/home/home.dart';
import 'package:ditto/presentation/navigations_screen/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../general/bottom_bar_items.dart';
import '../navigations_screen/chat_relays/global_chats.dart';
import '../../model/bottom_bat_item.dart';
import '../navigations_screen/messages/Messages.dart';
import 'widgets/bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70,
      bottomNavigationBar: CustomBottomBar(
        items: GeneralBottomBar.items,
        selectedIndex: _selectedIndex,
        onElementTap: _onItemTapped,
      ),
      body: GeneralBottomBar.items.elementAt(_selectedIndex).screen,
    );
  }
}
