import 'package:ditto/presentation/home/widgets/logo.dart';
import 'package:flutter/material.dart';

import '../../BottomBar.dart';
import '../../scan.dart';
import 'widgets/go_button.dart';
import 'widgets/name_field.dart';
import 'widgets/private_key_label.dart';
import 'widgets/title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
          child: Column(
        children: const <Widget>[
          Logo(),
          ScreenTitle(),
          NameField(),
          SizedBox(height: 20),
          GoButton(),
          SizedBox(height: 60),
          PrivateKeyLabel(),
        ],
      )),
    );
  }
}
