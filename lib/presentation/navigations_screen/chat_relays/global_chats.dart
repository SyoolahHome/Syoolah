import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';

class GlobalChatRelays extends StatelessWidget {
  const GlobalChatRelays({Key? key}) : super(key: key);

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
