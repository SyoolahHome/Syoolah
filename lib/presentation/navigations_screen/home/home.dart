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
import '../../../model/event.dart';
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
              onPressed: () async {
                final key = NostrService.instance.generateKeys();
                LocalDatabase.instance.setPrivateKey(key);

                final event = NostrEvent.fromPartialData(
                  kind: 0,
                  keyChain: Keychain(key),
                  content: jsonEncode({"name": "test name"}),
                );
                final serialized = event.serialized();

                HttpOverrides.global = MyHttpOverrides();

                Future<WebSocket> fws =
                    WebSocket.connect("wss://relay.damus.io");
                fws.then(
                  (WebSocket ws) {
                    ws.listen((d) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(d.toString()),
                        ),
                      );
                    }, onError: (e) {
                      print("error");
                      print(e);
                    }, onDone: () {
                      print('in onDone');
                      ws.close();
                    });

                    print("sending: $serialized");
                    ws.add(jsonEncode(serialized));
                  },
                );
              },
              child: const Text('publish request to relay'),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
