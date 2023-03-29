import 'package:ditto/presentation/navigations_screen/messages/widgets/single_fab.dart';
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
        SingleFAB(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EventScreen(),
              ),
            );
          },
          heroTag: "send_event",
          toolTip: 'Send an event',
          icon: FlutterRemix.chat_2_line,
        ),
        const SizedBox(height: 10),
        SingleFAB(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilScreen()),
            );
          },
          heroTag: "profil",
          toolTip: 'Edit your profil',
          icon: FlutterRemix.chat_2_line,
        ),
      ],
    );
  }
}
