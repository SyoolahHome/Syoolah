import 'package:ditto/presentation/navigations_screen/chat_relays/widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GlobalChatRelays extends StatelessWidget {
  const GlobalChatRelays({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("loading".tr()),
          )
        ],
      ),
    );
  }
}
