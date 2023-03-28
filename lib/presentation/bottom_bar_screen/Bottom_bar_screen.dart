import 'package:ditto/presentation/navigations_screen/home/home.dart';
import 'package:ditto/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../globalChats.dart';
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

  final List<BottomBarItem> items = [
    const BottomBarItem(
      screen: Home(),
      label: 'Home',
      icon: FlutterRemix.home_4_line,
    ),
    const BottomBarItem(
      screen: Messages(),
      label: 'Messages',
      icon: FlutterRemix.message_3_line,
    ),
    // BottomBarItem(
    //   screen: AddNewPost(),
    //   label: 'Add New Post',
    //   icon: Icons.add,
    // ),
    const BottomBarItem(
      screen: GlobalChatRelays(),
      label: 'Global',
      icon: FlutterRemix.list_check_2,
    ),
    const BottomBarItem(
      screen: Profile(),
      label: 'Profile',
      icon: FlutterRemix.user_line,
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
      body: items.elementAt(_selectedIndex).screen,
    );
  }
}
