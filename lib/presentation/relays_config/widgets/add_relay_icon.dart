import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class AddRelayIcon extends StatelessWidget {
  const AddRelayIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routing.appCubit.showAddRelaySheet(context);
      },
      child: const Icon(
        FlutterRemix.add_line,
        size: 20,
      ),
    );
  }
}
