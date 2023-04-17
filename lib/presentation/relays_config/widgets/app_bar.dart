import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import '../../navigations_screen/home/widgets/relays_widget.dart';
import 'add_relay_icon.dart';
import 'reconnect_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const ReconnectButton(),
      centerTitle: true,
      actions: const <Widget>[
        AddRelayIcon(),
        SizedBox(width: 17.5),
        RelaysWidget(),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
