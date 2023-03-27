import 'package:ditto/screen/event.dart';
import 'package:ditto/screen/profil.dart';
import 'package:ditto/utils.dart';
import 'package:ditto/widget/the_wall.dart';
// import '../../../Desktop/Flutter_App/chatbot-chatgpt/lib/widgets/the_wall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import '../constants/constants.dart';
import 'package:sqlite3/sqlite3.dart';

import 'model/profile.dart';

final db = sqlite3.openInMemory();

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final profil = context.watch<MProfile>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Global Message'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: TheWallWidget(
          channel: WebSocketChannel.connect(Uri.parse(profil.relay)),
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: buttonBorderColor, width: 3),
                borderRadius: BorderRadius.circular(100)),
            tooltip: 'Send an event',
            heroTag: "send_event",
            child: const Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: buttonBorderColor, width: 3),
                borderRadius: BorderRadius.circular(100)),
            tooltip: 'Edit your profil',
            heroTag: "profil",
            child: const Icon(Icons.vpn_key),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
