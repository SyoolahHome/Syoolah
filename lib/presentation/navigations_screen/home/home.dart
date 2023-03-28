import 'package:ditto/about.dart';
import 'package:ditto/globalChats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';
import '../../../model/drawer_list_tile.dart';
import '../messages/Messages.dart';
import 'widgets/app_bar.dart';
import 'widgets/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DrawerListTimeItem> get drawerListTileItems => [
        DrawerListTimeItem(
          icon: FlutterRemix.home_4_line,
          label: 'Following',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.chat_2_line,
          label: 'Messages',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Messages(),
              ),
            );
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.camera_lens_line,
          label: 'Global',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GlobalChatRelays(),
              ),
            );
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.user_line,
          label: 'Profile',
          onTap: () {},
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.settings_line,
          label: 'Settings',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.information_line,
          label: 'About',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutPage(),
              ),
            );
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(items: drawerListTileItems),
      body: Center(
        child: Column(children: const <Widget>[SizedBox(height: 50)]),
      ),
    );
  }
}
