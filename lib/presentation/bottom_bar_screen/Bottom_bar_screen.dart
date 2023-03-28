import 'package:ditto/Messages.dart';
import 'package:ditto/home.dart';
import 'package:ditto/profile.dart';
import 'package:flutter/material.dart';

import '../../globalChats.dart';
import '../../model/bottom_bat_item.dart';
import 'widgets/bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<BottomBarItem> items = [
    const BottomBarItem(
      screen: Home(),
      label: 'Home',
      icon: Icons.home,
    ),
    const BottomBarItem(
      screen: Messages(),
      label: 'Messages',
      icon: Icons.message,
    ),
    // BottomBarItem(
    //   screen: AddNewPost(),
    //   label: 'Add New Post',
    //   icon: Icons.add,
    // ),
    const BottomBarItem(
      screen: GlobalChatRelays(),
      label: 'Global',
      icon: Icons.chat,
    ),
    const BottomBarItem(
      screen: Profile(),
      label: 'Profile',
      icon: Icons.person,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      bottomNavigationBar: CustomBottomBar(
        items: items,
        selectedIndex: _selectedIndex,
        onElementTap: _onItemTapped,
      ),
      body: Center(
        child: items.elementAt(_selectedIndex).screen,
      ),
    );
  }
}
