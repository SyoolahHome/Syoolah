import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../constants/constants.dart';
import '../../../../screen/event.dart';
import '../../../../screen/profil.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: buttonBorderColor, width: 3),
            borderRadius: BorderRadius.circular(100),
          ),
          tooltip: 'Send an event',
          heroTag: "send_event",
          child: const Icon(FlutterRemix.chat_2_line),
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
    );
  }
}
