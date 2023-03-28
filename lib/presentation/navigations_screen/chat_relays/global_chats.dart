import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import 'widgets/app_bar.dart';

class GlobalChatRelays extends StatelessWidget {
  const GlobalChatRelays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: const <Widget>[
          Center(
            child: Text(AppStrings.loading),
          )
        ],
      ),
    );
  }
}
