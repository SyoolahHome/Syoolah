import 'dart:convert';
import 'dart:io';

import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostr/nostr.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../main.dart';
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
                NostrService.instance.sendReq();
              },
              child: Text("clci,"),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
