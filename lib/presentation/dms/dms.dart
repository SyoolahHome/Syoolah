import 'package:flutter/material.dart';

import '../../constants/abstractions/abstractions.dart';

class DMS extends BottomBarScreen {
  const DMS({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('DMs not available in your jurisdiction'),
    ));
  }
}
