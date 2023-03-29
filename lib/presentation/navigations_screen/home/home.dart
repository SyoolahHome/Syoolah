import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';
import '../../general/drawer_items.dart';
import 'widgets/app_bar.dart';
import '../../general/widget/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(
        items: GeneralDrawerItems.drawerListTileItems(context),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {
              },
              child: const Text('Click'),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
