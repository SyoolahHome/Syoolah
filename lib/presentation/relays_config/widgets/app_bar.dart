import 'package:ditto/presentation/navigations_screen/home/widgets/relays_widget.dart';
import 'package:ditto/presentation/relays_config/widgets/add_relay_icon.dart';
import 'package:ditto/presentation/relays_config/widgets/reconnect_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const ReconnectButton(),
      centerTitle: false,
      actions: const <Widget>[
        AddRelayIcon(),
        SizedBox(width: 2.5),
        RelaysWidget(),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
