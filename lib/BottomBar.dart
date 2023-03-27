import 'package:ditto/AddNewPost.dart';
import 'package:ditto/Messages.dart';
import 'package:ditto/home.dart';
import 'package:ditto/profile.dart';
import 'package:flutter/material.dart';

import 'globalChats.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  static const List<Widget> _widgetOptions = <Widget>[
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 1: Business',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 2: School',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 3: SchoolCopy',
    //   style: optionStyle,
    // ),
    Home(),
    Messages(),
    // addNewPost(),
    GlobalChatRelays(),
    Profile(),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_sharp),
            label: 'Message',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_circle_rounded),
          //   label: 'Add comment',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_rounded),
            label: 'Global',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.tealAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
