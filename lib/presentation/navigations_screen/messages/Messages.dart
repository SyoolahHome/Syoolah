import 'package:ditto/screen/event.dart';
import 'package:ditto/screen/profil.dart';
import 'package:ditto/presentation/general/widget/the_wall.dart';
// import '../../../Desktop/Flutter_App/chatbot-chatgpt/lib/widgets/the_wall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../constants/constants.dart';
import '../../../model/profile.dart';
import 'widgets/app_bar.dart';
import 'widgets/custom_fabs.dart';

final db = sqlite3.openInMemory();

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  MessagesState createState() => MessagesState();
}

class MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final profil = context.watch<MProfile>();
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: const CustomFAB(),
      body: SingleChildScrollView(
        child: Text(""),
        // child: TheWallWidget(
        //   channel: WebSocketChannel.connect(Uri.parse(profil.relay)),
        // ),
      ),
    );
  }
}
