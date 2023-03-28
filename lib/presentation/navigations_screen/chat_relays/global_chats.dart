import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';

class GlobalChatRelays extends StatelessWidget {
  const GlobalChatRelays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: Text("Loading.....")),
            )
          ],
        ),
      ),
    );
  }
}
